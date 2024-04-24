import 'package:dash/presentation/screens/verify_client.dart';
import 'package:flutter/material.dart';

class VerifyTraveler extends StatefulWidget {
  const VerifyTraveler({super.key});

  @override
  State<VerifyTraveler> createState() => _CreateState();
}

class _CreateState extends State<VerifyTraveler> {
  final _formKey = GlobalKey<FormState>();

    String _lastName = '';
    String _firstName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Traveler'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Column(
            children: [
              TextFormField(
                validator: (val) {
                  if (val == null) {
                    return 'First name cannot be null';
                  }

                  if (val.isEmpty) {
                    return 'First name cannot be empty';
                  }

                  return null;
                },
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'First name',
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (text) {
                  _firstName = text;
                },
              ),
              const SizedBox(
                height: 12.0,
              ),TextFormField(
                validator: (val) {
                  if (val == null) {
                    return 'Last name cannot be null';
                  }

                  if (val.isEmpty) {
                    return 'Last name cannot be empty';
                  }

                  return null;
                },
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  hintText: 'Last name',
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (text) {
                  _lastName = text;
                },
              ),
              const SizedBox(
                height: 32.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  String message = '';

                  try {
                    //
                    // Do funny stuff here
                    //
                    verifyPassportUK(_lastName, _firstName);

                    message = 'Query created successfully';
                  } catch (e) {
                    message = '$e';
                  }

                  if (context.mounted) {
                    SnackBar snackBar = SnackBar(
                      content: Text(message),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
