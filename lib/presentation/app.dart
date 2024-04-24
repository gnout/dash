import 'package:dash/presentation/screens/home.dart';
import 'package:dash/presentation/screens/create.dart';
import 'package:dash/presentation/screens/qr_code.dart';
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
        '/create/qrcode': (context) => const QrCode(),
        '/verify_traveler': (context) => const VerifyTraveler(),
        '/verify_traveler/qrcode': (context) => const QrCode(),
      },
    );
  }
}
