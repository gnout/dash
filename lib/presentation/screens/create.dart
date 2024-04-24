import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final _formKey = GlobalKey<FormState>();

  String _firstName = '';
  String _lastName = '';
  String _nationality = '';
  String _dateOfBirth = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Credentials'),
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
              ),
              TextFormField(
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
                height: 12.0,
              ),
              TextFormField(
                validator: (val) {
                  if (val == null) {
                    return 'Nationality cannot be null';
                  }

                  if (val.isEmpty) {
                    return 'Nationality cannot be empty';
                  }

                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Nationality',
                  prefixIcon: Icon(Icons.flag),
                ),
                onChanged: (text) {
                  _nationality = text;
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                validator: (val) {
                  if (val == null) {
                    return 'Date of Birth cannot be null';
                  }

                  if (val.isEmpty) {
                    return 'Date of Birth cannot be empty';
                  }

                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Date of Birth',
                  prefixIcon: Icon(Icons.date_range_outlined),
                ),
                onChanged: (text) {
                  _dateOfBirth = text;
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

                    String link = 'iden3comm://?request_uri=https://verifier-backend.polygonid.me/qr-store?id=73e013b3-e47b-4ccc-bf19-aaf69df06269';

                    await Navigator.pushNamed(context, '/create/qrcode', arguments: link);

                    message = 'Credential created successfully';
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
