import 'package:dash/presentation/models/passport.dart';
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

  Future<String> fetchData({required Passport passport}) async {
    String basicAuth = 'Basic ' + base64Encode(utf8.encode('$username:$password'));
    var url = Uri.parse('$baseURL/v1/credentials');
    var headers = <String, String>{
      'authorization': basicAuth,
      'Content-Type': 'application/json',
    };
    var body = jsonEncode({
      "credentialSchema": "ipfs://QmcsKmvYMnCb27Eu3T6aGNkmNxA5CmeZX7iQkvZ2B5V4WD",
      "type": "PassportUK",
      "credentialSubject": {
        "id": "did:polygonid:polygon:amoy:2qW4hiyyiXcVCHTe82ktcfpD6jNyp7tMKDyrTr5W4T",
        "Lastname": passport.lastName,
        "Firstname": passport.firstName,
        "Nationality": passport.nationality,
        "DateOfBirth": passport.dateOfBirth
      },
      "signatureProof": true,
      "mtProof": false
    });
    var response = await http.post(url, headers: headers, body: body);
    statusCode = response.statusCode;

    if (response.statusCode == 201) {
      var responseData = jsonDecode(response.body);
      return await getCredentialDetails(responseData['id']); // Return the Future returned by getCredentialDetails
    } else {
      return '';
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

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      return responseData['qrCodeLink']; // Assuming the link is stored in a key named 'link'
    } else {
      return ''; // Return empty string if response is not successful
    }
  }
}
