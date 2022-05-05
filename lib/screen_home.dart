import 'package:caller/caller.dart';
import 'package:flutter/material.dart';
import 'package:incoming_call/util.dart';
import 'package:permission_handler/permission_handler.dart';

class ScreenHome extends StatefulWidget {
  static const String id = 'screen_home';

  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  _getPermissions() async {
    await [
      Permission.phone,
      Permission.contacts,
    ].request();
  }

  _init() async {
    await _getPermissions();

    await initializeCaller();

    Caller.onEvent.listen((CallEvent event) async {
      debugPrint(event.toString());

      String number = event.number;
      int? duration = event.duration;

      String? name = await getContactName(number);
      if (name != null) debugPrint("[ Caller ] Name: $name");

      switch (event.action) {
        case CallAction.callEnded:
          debugPrint('[ Caller ] Ended a call with number $number and duration $duration');
          break;
        case CallAction.onMissedCall:
          debugPrint('[ Caller ] Missed a call from number $number');
          break;
        case CallAction.onIncomingCallAnswered:
          debugPrint('[ Caller ] Accepted call from number $number');
          break;
        case CallAction.onIncomingCallReceived:
          debugPrint('[ Caller ] Phone is ringing with number $number');
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Incoming Call'),
      ),
      body: Container(),
    );
  }
}
