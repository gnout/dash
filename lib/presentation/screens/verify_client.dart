import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future<String> getQueryQRCode(String context, String type, Map<String, Map<String, String>> credentialSubject) async {
  var url = Uri.parse('https://verifier-backend.polygonid.me/sign-in');
  var payload = {
    "chainID": "80002",
    "skipClaimRevocationCheck": false,
    "scope": [{
      "circuitId": "credentialAtomicQuerySigV2",
      "id": 1713961493,
      "query": {
        "allowedIssuers": ["*"],
        "context": context,
        "type": type,
        "credentialSubject": credentialSubject
      }
    }]
  };

  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(payload),
  );

  if (response.statusCode == 200) {
    print('API call successful.');
    var data = json.decode(response.body);
    String qrCode = data['qrCode'];
    print('QR Code: $qrCode');
    return qrCode;
  } else {
    print('Failed to call API. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load qrCode');
  }
}
Future<String> verifyUKTraveler(String lastName, String firstName) async{
  return getQueryQRCode(
    "ipfs://QmbsEWM7nGU9p3vLkB3G8mp99WESVa25nRHS3Exq8WfBh3",
    "PassportUK", 
    {
      "Lastname": {"\$eq": lastName},
      "Firstname": {"\$eq": firstName}
    });
}
Future<String> verifyDriversLicense(String lastName, DateTime brithDate) async{
  return getQueryQRCode(
    "ipfs://QmbsEWM7nGU9p3vLkB3G8mp99WESVa25nRHS3Exq8WfBh3",
    "PassportUK",  
    {
      "Lastname": {"\$eq": lastName},
      "DateOfBrith": {"\$le": DateFormat('yyyy-MM-dd').format(brithDate)}
    });
}