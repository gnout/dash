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
              icon: Icons.wallet,
              title: 'Connect Wallet',
              subTitle: 'Connect Wallet',
              route: '/connect_wallet',
              checkUserId: false,
            ),
            MenuTile(
              icon: Icons.create,
              title: 'Create',
              subTitle: 'Create Passport Credential',
              route: '/create',
            ),
            MenuTile(
              icon: Icons.verified_outlined,
              title: 'Verify Traveller',
              subTitle: 'Verify Traveler',
              route: '/verify_traveler',
              checkUserId: false,
            ),
            MenuTile(
              icon: Icons.car_rental,
              title: 'Verify Driver',
              subTitle: 'Verify Drivers License',
              route: '/verify_driver',
              checkUserId: false,
            ),
            MenuTile(
              icon: Icons.room_preferences,
              title: 'Preferences',
              subTitle: 'Food, allergies etc.',
              route: '/preferences',
              checkUserId: false,
            ),
            MenuTile(
              icon: Icons.car_rental,
              title: 'Request Preferences',
              subTitle: 'Request Preferences',
              route: '/requestPreferences',
              checkUserId: false,
            )
          ],
        ),
      ),
    );
  }
}

