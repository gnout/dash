import 'dart:async';
import 'package:dash/services/session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode3 extends StatefulWidget {
  // final Map<String, String> data;
  const QrCode3({super.key}/*, required this.data}*/);
  
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode3> {
  Timer? _timer;
  String _status = 'pending';
  String _foods = '';
  String _hobbies = '';
  String _cities = '';

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  void _startPolling() {
    int attempts = 0;
    const maxAttempts = 30;

    const duration = Duration(seconds: 5);  // Poll every 5 seconds
    _timer = Timer.periodic(duration, (Timer t) async {
      if(Session.connection.sessionID!.isNotEmpty){
        await _checkStatus();
      }

      attempts++;

      if (attempts > maxAttempts) {
        _timer?.cancel();
        setState(() {
          _status = 'failed';
        });
      }
    });
  }

  Future<void> _checkStatus() async {
    var response = await http.get(Uri.parse('https://verifier-backend.polygonid.me/status?sessionID=${Session.connection.sessionID}'));
    var data = jsonDecode(response.body);
    print(data);
    extractPreferences(response.body);
    if (data['status'] == 'success') {
      _timer?.cancel();
      setState(() {
        _status = 'approved';
      });
    }
  }
  void extractPreferences(String responseBody) {
  // Decode the JSON response
  var decodedResponse = jsonDecode(responseBody);

  // Navigate through the JSON to find the verifiable presentations
  var presentations = decodedResponse['jwzMetadata']['verifiablePresentations'];

  // Loop through each presentation to find the relevant data
  for (var presentation in presentations) {
    var credentialSubject = presentation['credentialSubject'];
    if (credentialSubject.containsKey('Hobbies')) {
      setState(() {
        _hobbies = credentialSubject['Hobbies'];
      });
    } else if (credentialSubject.containsKey('Foods')) {
      setState(() {
        _foods = credentialSubject['Foods'];
      });
    } else if (credentialSubject.containsKey('Cities')) {
      setState(() {
        _cities = credentialSubject['Cities'];
      });
    }
  }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(Session.connection.qrCodeLink);
    print(Session.connection.sessionID);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              SizedBox(height: 20),
              Text('I like this food: $_foods'),
              SizedBox(height: 20),
              Text('I want to go to: $_cities'),
              SizedBox(height: 20),
              Text('I like to do: $_hobbies'),
            // Assuming QrImageView is similar to QrImage, replace this with your actual QrImageView widget if different
            QrImageView(
              data: Session.connection.qrCodeLink!,
              size: 280,
              embeddedImageStyle: const QrEmbeddedImageStyle(
                size: Size(
                  100,
                  100,
                )
              ),  // Assuming this is a valid property
            ),
            SizedBox(height: 20),
            Text('Status: $_status'),
          ],
        ),
      ),
    );
  }
}
