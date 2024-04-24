import 'package:flutter/material.dart';

class Create extends StatelessWidget {
  const Create({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berlin Hackathon'),
      ),
      body: const Center(
        child: Text('Create Passport Credential'),
      ),
    );
  }
}
