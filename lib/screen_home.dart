import 'package:flutter/material.dart';

class ScreenHome extends StatefulWidget {
  static const String id = 'screen_home';

  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
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
