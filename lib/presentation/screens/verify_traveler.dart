import 'package:flutter/material.dart';

class VerifyTraveler extends StatelessWidget {
  const VerifyTraveler({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berlin Hackathon'),
      ),
      body: const Center(
        child: Text('Verify Traveler'),
      ),
    );
  }
}
