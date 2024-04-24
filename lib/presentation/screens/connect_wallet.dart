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
        child: Text('Connect Wallet'),
      ),
    );
  }
}
