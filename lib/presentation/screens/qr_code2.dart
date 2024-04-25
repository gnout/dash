import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode2 extends StatefulWidget {
  final Map<String, String> data;
  const QrCode2({super.key, required this.data});
  
  @override
  _QrCodeState createState() => _QrCodeState();
}

class _QrCodeState extends State<QrCode2> {
  Timer? _timer;
  String _status = 'pending';

  @override
  void initState() {
    super.initState();
    _startPolling();
  }

  void _startPolling() {
    const duration = Duration(seconds: 5);  // Poll every 5 seconds
    _timer = Timer.periodic(duration, (Timer t) async {
      if(widget.data['sessionID']!.isNotEmpty){
        await _checkStatus();
      }
    });
  }

  Future<void> _checkStatus() async {
    var response = await http.get(Uri.parse('https://verifier-backend.polygonid.me/status?sessionID=${widget.data['sessionID']}'));
    var data = jsonDecode(response.body);
    if (data['status'] == 'success') {
      _timer?.cancel();
      setState(() {
        _status = 'approved';
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
    print(widget.data);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Assuming QrImageView is similar to QrImage, replace this with your actual QrImageView widget if different
            QrImageView(
              data: widget.data['link']!,
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
