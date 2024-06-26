import 'package:dash/presentation/screens/qr_code3.dart';
import 'package:dash/presentation/screens/requestPreferences.dart';
import 'package:dash/presentation/screens/preferences.dart';
import 'package:flutter/material.dart';
import 'package:dash/presentation/screens/connect_wallet.dart';
import 'package:dash/presentation/screens/home.dart';
import 'package:dash/presentation/screens/create.dart';
import 'package:dash/presentation/screens/qr_code.dart';
import 'package:dash/presentation/screens/verify_driver.dart';
import 'package:dash/presentation/screens/verify_traveler.dart';
import 'package:dash/presentation/theme.dart';
import 'package:dash/presentation/screens/qr_code2.dart';

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
        '/connect_wallet': (context) => const ConnectWallet(),
        '/connect_wallet/qrcode': (context) => const QrCode(),
        '/create': (context) => const Create(),
        '/create/qrcode': (context) => const QrCode(),
        '/verify_traveler': (context) => const VerifyTraveler(),
        '/verify_traveler/qrcode2': (context) => const QrCode2(),
        '/verify_driver': (context) => const VerifyDriver(),
        '/verify_driver/qrcode2': (context) => const QrCode2(),
        '/requestPreferences': (context) => const RequestPrefs(),
        '/requestPreferences/qrcode3': (context) => const QrCode3(),
        '/preferences': (context) => const Preferences(),
        '/preferences/qrcode': (context) => const QrCode(),
      },
    );
  }
}
