import 'package:caller/caller.dart';
import 'package:flutter/material.dart';
import 'screen_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Incoming Call',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenHome(),
      routes: {
        ScreenHome.id: (context) => const ScreenHome(),
      },
    );
  }
}

/// Defines a callback that will handle all background incoming events
///
/// The duration will only have a value if the current event is `CallerEvent.callEnded`
Future<void> callerCallbackHandler(CallerEvent event, String number, int? duration) async {
  debugPrint("New event received from native $event");
  switch (event) {
    case CallerEvent.callEnded:
      debugPrint('[ Caller ] Ended a call with number $number and duration $duration');
      break;
    case CallerEvent.onMissedCall:
      debugPrint('[ Caller ] Missed a call from number $number');
      break;
    case CallerEvent.onIncomingCallAnswered:
      debugPrint('[ Caller ] Accepted call from number $number');
      break;
    case CallerEvent.onIncomingCallReceived:
      debugPrint('[ Caller ] Phone is ringing with number $number');
      break;
  }
}

Future<void> initialize() async {
  /// Check if the user has granted permissions
  final permission = await Caller.checkPermission();
  debugPrint('Caller permission $permission');

  /// If not, then request user permission to access the Call State
  if (!permission) {
    Caller.requestPermissions();
  } else {
    Caller.initialize(callerCallbackHandler);
  }
}
