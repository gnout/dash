import 'package:flutter/material.dart';
import 'package:dash/presentation/widgets/example_tile.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berlin Hackathon'),
      ),
      body: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: const [
            MenuTile(
              icon: Icons.create,
              title: 'Create',
              subTitle: 'Create Passport Credential',
              route: '/create',
            ),
            MenuTile(
              icon: Icons.verified_outlined,
              title: 'Verify',
              subTitle: 'Verify Traveler',
              route: '/verify_traveler',
            ),
          ],
        ),
      ),
    );
  }
}

