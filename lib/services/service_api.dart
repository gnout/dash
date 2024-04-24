import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  final String baseURL = "https://issuer-admin.polygonid.me";
  final String username = 'user-api';
  final String password = 'password-api';
  late int _statusCode;

  // Getter for status code
  int get statusCode => _statusCode;

  // Setter for status code
  set statusCode(int value) {
    _statusCode = value;
  }

  late String _responseBody;
  // Getter for response body
  String get responseBody => _responseBody;

  // Setter for response body
  set responseBody(String value) {
    _responseBody = value;
  }




  Future<String> fetchData() async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var url = Uri.parse('$baseURL/v1/credentials');
    var headers = <String, String>{
      'authorization': basicAuth,
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "credentialSchema": "https://raw.githubusercontent.com/iden3/claim-schema-vocab/main/schemas/json/KYCAgeCredential-v3.json",
      "type": "KYCAgeCredential",
      "credentialSubject": {
        "id": "did:polygonid:polygon:amoy:2qYkoXJ9AXjr8jjH6C9zdUjPAyzAQdhxTp3a6AnUKv",
        "birthday": 19960424,
        "documentType": 2
      },
      "expiration": "2025-04-24T09:40:04.101Z",
      "signatureProof": true,
      "mtProof": false,
    });
    var response = await http.post(url, headers: headers, body: body);
    statusCode = response.statusCode;

    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      return getCredentialDetails(responseData['id']); // Return the Future returned by getCredentialDetails
    } else {
      throw Exception('Failed to fetch data');
    }
  }




  Future<String> getCredentialDetails(String credentialId) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var url = Uri.parse('$baseURL/v1/credentials/$credentialId/qrcode?type=link');
    var headers = <String, String>{
      'authorization': basicAuth,
      'accept': 'application/json',
    };
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      return responseData['link']; // Assuming the link is stored in a key named 'link'
    } else {
      return ''; // Return empty string if response is not successful
    }
  }


}
