import 'package:flutter/material.dart';
import 'package:incoming_call/util.dart';
import 'screen_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initializeCaller();

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
