import 'dart:convert';
import 'package:http/http.dart' as http;

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
    "ipfs://QmSbdydtWpFvg8nDVhzYnASdpkncri6SQxfBzye6qhDJt8",
    "PassportUK", {
    "Lastname": {"\$eq": lastName},
    "Firstname": {"\$eq": firstName}
    });
}