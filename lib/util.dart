import 'package:caller/caller.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

/// Caller
Future<void> initializeCaller() async {
  // Check if the user has granted permissions
  final permission = await Caller.checkPermission();
  debugPrint('Caller permission $permission');

  // If not, then request user permission to access the Call State
  if (!permission) {
    await Caller.requestPermissions();
  } else {
    await Caller.initialize();
  }
}

/// Contact
List<Contact> _contacts = [];

Future<String?> getContactName(String number) async {
  try {
    if (_contacts.isEmpty) {
      _contacts = await ContactsService.getContacts(withThumbnails: false);
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  for (Contact contact in _contacts) {
    if (contact.phones == null) continue;

    for (final phone in contact.phones!) {
      if (phone.value == null) continue;

      String tempNumber = phone.value!.replaceAll(" ", "");
      tempNumber = tempNumber.replaceAll("+91", "");
      if (tempNumber == number.replaceAll("+91", "")) return contact.displayName;
    }
  }
  return null;
}
