import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:rivegame/rive_animations.dart';
import 'package:rivegame/rive_showcase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await rive.RiveNative.init();   // Required in 0.14.x
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rive Animation Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const RiveAnimations(),
    );
  }
}