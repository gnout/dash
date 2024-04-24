import 'package:flutter/material.dart';

class ConnectWallet extends StatelessWidget {
  const ConnectWallet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connect Wallet'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {

            String link = 'iden3comm://?request_uri=https://issuer-admin.polygonid.me/v1/qr-store?id=c698bc27-2556-4a5e-b053-1d4d36a5ab34';

            await Navigator.pushNamed(context, '/create/qrcode', arguments: link);




          },
          child: const Text('Connect'),
        ),
      ),
    );
  }
}
