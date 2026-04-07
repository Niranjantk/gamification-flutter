import 'package:flutter/material.dart';
import 'package:mario/home_screen.dart';
import 'package:flutter/services.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();

  // 🔒 Lock orientation to LANDSCAPE ONLY
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //chaning the phone land scape to landscape
    
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}



