import 'dart:async';
import 'package:dash/services/session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode2 extends StatefulWidget {
  const QrCode2({super.key});
  
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode2> {
  Timer? _timer;
  final double iconSize = 40.0;

  Icon _status = const Icon(
    Icons.pending,
    color: Colors.grey,
    size: 40.0,
  );

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  void _startPolling() {
    int attempts = 0;
    const maxAttempts = 30;

    const duration = Duration(seconds: 2);  // Poll every 5 seconds
    _timer = Timer.periodic(duration, (Timer t) async {
      if(Session.connection.sessionID!.isNotEmpty){
        await _checkStatus();
      }

      attempts++;

      if (attempts > maxAttempts) {
        _timer?.cancel();
        setState(() {
          _status = Icon(
            Icons.cancel,
            color: Colors.red,
            size: iconSize,
          );
        });
      }
    });
  }

  Future<void> _checkStatus() async {
    var response = await http.get(Uri.parse('https://verifier-backend.polygonid.me/status?sessionID=${Session.connection.sessionID}'));
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      _timer?.cancel();
      setState(() {
        _status = Icon(
          Icons.check,
          color: Colors.green,
          size: iconSize,
        );
      });
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
    print(_status);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImageView(
              data: Session.connection.qrCodeLink!,
              size: 280,
              embeddedImageStyle: const QrEmbeddedImageStyle(
                size: Size(
                  100,
                  100,
                )
              ),
            ),
            const SizedBox(height: 20),
            _status
          ],
        ),
      ),
    );
  }
}
