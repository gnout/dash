import 'dart:async';

import 'package:dash/presentation/models/ConnectionQRCode.dart';
import 'package:dash/services/service_api.dart';
import 'package:dash/services/session.dart';
import 'package:flutter/material.dart';

class ConnectWallet extends StatefulWidget {
  const ConnectWallet({super.key});

  @override
  State<ConnectWallet> createState() => _ConnectWalletState();
}

Future<void> _onReturnBack(APIService service, String? sessionId, BuildContext context) async {
  String result = '';
  int attempts = 0;
  const maxAttempts = 15;

  Timer.periodic(const Duration(seconds: 2), (timer) async {
    result = await service.fetchIssuerId(sessionId!);

    if (result.isNotEmpty) {
      timer.cancel();
      Session.userId = result;

      SnackBar snackBar = const SnackBar(
        content: Text('UserID successfully acquired'),
        backgroundColor: Colors.green,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (attempts >= maxAttempts) {
      timer.cancel();
      Session.userId = '';

      SnackBar snackBar = const SnackBar(
        content: Text('Fail to acquired UserID'),
        backgroundColor: Colors.red,
      );
    }

    attempts++;
  });
}

class _ConnectWalletState extends State<ConnectWallet> {
  APIService service = APIService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Wallet'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              ConnectionQRCode connection = await service.fetchQRCodeLink();

              await Navigator.pushNamed(context, '/connect_wallet/qrcode', arguments: connection.qrCodeLink)
                  .then((value) async => {
                await _onReturnBack(service, connection.sessionID, context)
              });
            } catch (e) {
              print(e);
            }
          },
          child: const Text('Connect'),
        ),
      ),
    );
  }
}
