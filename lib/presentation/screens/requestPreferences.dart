import 'package:dash/presentation/screens/verify_client.dart';
import 'package:flutter/material.dart';

class RequestPrefs extends StatefulWidget {
  const RequestPrefs({super.key});

  @override
  State<RequestPrefs> createState() => _CreateState();
}

class _CreateState extends State<RequestPrefs> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Request travel preferences'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ),
          child: Column(
            children: [
               ElevatedButton(
                onPressed: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  if (!_formKey.currentState!.validate()) {
                    return;
                  }

                  String message = '';

                  try {
                    await getMyPreferences();
                    await Navigator.pushNamed(context, '/requestPreferences/qrcode3');

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
                child: const Text('request Preferences'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
