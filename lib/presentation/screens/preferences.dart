import 'package:dash/presentation/models/preferences.dart';
import 'package:dash/services/service_api.dart';
import 'package:flutter/material.dart';

class Preferences extends StatefulWidget {
  const Preferences({super.key});

  @override
  State<Preferences> createState() => _PreferencesState();
}

class _PreferencesState extends State<Preferences> {
  final _formKey = GlobalKey<FormState>();

  String _food = '';
  String _hobbies = '';
  String _cities = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Preferences'),
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
                    return 'Food name cannot be null';
                  }

                  if (val.isEmpty) {
                    return 'Food name cannot be empty';
                  }

                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Food',
                  prefixIcon: Icon(Icons.fastfood),
                ),
                onChanged: (text) {
                  _food = text;
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                validator: (val) {
                  if (val == null) {
                    return 'Hobbies cannot be null';
                  }

                  if (val.isEmpty) {
                    return 'Hobbies cannot be empty';
                  }

                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Hobbies',
                  prefixIcon: Icon(Icons.sports_football),
                ),
                onChanged: (text) {
                  _hobbies = text;
                },
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                validator: (val) {
                  if (val == null) {
                    return 'Cities cannot be null';
                  }

                  if (val.isEmpty) {
                    return 'Cities cannot be empty';
                  }

                  return null;
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  hintText: 'Cities',
                  prefixIcon: Icon(Icons.map_outlined),
                ),
                onChanged: (text) {
                  _cities = text;
                },
              ),
              const SizedBox(
                height: 12.0,
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
                    String link = await _getLink(preferences: PreferencesDao(
                      food: _food,
                      hobbies: _hobbies,
                      cities: _cities,
                    ));

                    await Navigator.pushNamed(context, '/preferences/qrcode', arguments: link);

                    message = 'Preferences created successfully';
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

  Future<String> _getLink({required PreferencesDao preferences}) async {
    APIService service = APIService();

    String link = await service.setPreferencesData(preferences: preferences);

    if (link.isEmpty) {
      throw Exception('Creating Preferences Failed');
    }

    return link;
  }
}
