import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> verifyPassportUK(String lastName, String firstName) async {
  var url = Uri.parse('https://verifier-backend.polygonid.me/sign-in');
  var payload = {
    "chainID": "80002",
    "skipClaimRevocationCheck": false,
    "scope": [{
      "circuitId": "credentialAtomicQuerySigV2",
      "id": 1713961493,
      "query": {
        "allowedIssuers": ["*"],
        "context": "ipfs://QmSbdydtWpFvg8nDVhzYnASdpkncri6SQxfBzye6qhDJt8",
        "type": "PassportUK",
        "credentialSubject": {
          "Lastname": {"\$eq": lastName},
          "Firstname": {"\$eq": firstName}
        }
      }
    }]
  };

  var response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
    },
    body: json.encode(payload),
  );

  if (response.statusCode == 200) {
    print('API call successful. Response:');
    print(json.decode(response.body));
    var data = json.decode(response.body);
    String qrCode = data['qrCode'];
    print('QR Code: $qrCode');

  } else {
    print('Failed to call API. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
