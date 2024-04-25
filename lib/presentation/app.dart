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
        '/verify_driver/qrcode': (context) => const QrCode2(),
      },

      // routes: {
      //   '/': (context) => const Home(),
      //   '/home': (context) => const Home(),
      //   '/connect_wallet': (context) => const ConnectWallet(),
      //   '/connect_wallet/qrcode': (context) => const QrCode(),
      //   '/create': (context) => const Create(),
      //   '/verify_traveler': (context) => const VerifyTraveler(),
      //   '/verify_driver/qrcode': (context) => const QrCode(),
      //   '/verify_driver': (context) => const VerifyDriver(),
      // },
      // onGenerateRoute: _handleRouteWithParameters,
    );
  }

  // Route<dynamic>? _handleRouteWithParameters(RouteSettings settings) {
  //   if (settings.name == '/verify_traveler/qrcode2') {
  //     final args = settings.arguments as Map<String, String>? ?? {};
  //     print(args);
  //     return MaterialPageRoute(
  //       builder: (context) => QrCode2(data: args),
  //       settings: settings,
  //     );
  //   }
  //   return null;
  // }
}
