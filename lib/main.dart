import 'package:flutter/material.dart';
import 'package:flutter_iot_cake_fast_app/views/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const FlutterIotCakeFastApp());
}

class FlutterIotCakeFastApp extends StatefulWidget {
  const FlutterIotCakeFastApp({super.key});

  @override
  State<FlutterIotCakeFastApp> createState() => _FlutterIotCakeFastAppState();
}

class _FlutterIotCakeFastAppState extends State<FlutterIotCakeFastApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
          textTheme: GoogleFonts.kanitTextTheme(Theme.of(context).textTheme)),
    );
  }
}
