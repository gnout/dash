import 'package:dash/presentation/screens/verify_client.dart';
import 'package:flutter/material.dart';

class VerifyDriver extends StatefulWidget {
  const VerifyDriver({super.key});

  @override
  State<VerifyDriver> createState() => _CreateState();
}

class _CreateState extends State<VerifyDriver> {
  final _formKey = GlobalKey<FormState>();

    String _lastName = '';
    DateTime _dateOfBrith = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Driver\'s license'),
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
              InputDatePickerFormField(
                initialDate:DateTime.now().subtract(const Duration(days: 365*18)),
                firstDate: DateTime.now().subtract(const Duration(days: 365*100)), 
                lastDate: DateTime.now().subtract(const Duration(days: 365*18)),
                onDateSubmitted: (value) =>{
                  _dateOfBrith = value
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
                    await verifyDriversLicense(_lastName, _dateOfBrith);
                    await Navigator.pushNamed(context, '/verify_driver/qrcode2');
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
                child: const Text('Verify'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
