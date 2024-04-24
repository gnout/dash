import 'package:dash/presentation/screens/home.dart';
import 'package:dash/presentation/screens/create.dart';
import 'package:dash/presentation/screens/verify_traveler.dart';
import 'package:dash/presentation/theme.dart';
import 'package:flutter/material.dart';

class DashApp extends StatelessWidget {
  const DashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Berlin Hackathon',
      theme: const SummerTheme().toThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/home': (context) => const Home(),
        '/create': (context) => const Create(),
        '/verify_traveler': (context) => const VerifyTraveler(),
      },
    );
  }
}
