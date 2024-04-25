import 'dart:convert';
import 'package:dash/presentation/models/ConnectionQRCode.dart';
import 'package:dash/services/session.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

Future getQueryQRCode(String context, String type, List<Map<String, Map<String, String>>> credentialSubjects) async {
  var url = Uri.parse('https://verifier-backend.polygonid.me/sign-in');
  var payload = {
    "chainID": "80002",
    "skipClaimRevocationCheck": false,
    "scope": List.generate(credentialSubjects.length, (index) {
      return {
        "circuitID": "credentialAtomicQueryV3-beta.1",
        "id": index + 1, // Assuming id starts at 1 and increments for each credential subject
        "query": {
          "context": context,
          "allowedIssuers": ["*"],
          "type": type,
          "credentialSubject": credentialSubjects[index]
        }
      };
    })
  };
  print(payload);


  var response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode(payload),
  );

  if (response.statusCode == 200) {
    print('API call successful.');
    var data = json.decode(response.body);
    String qrCode = data['qrCode'];
    print(data['sessionID']);
    print('QR Code: $qrCode');


    // return Map<String, String>.of({
    //   "link": qrCode,
    //   "sessionID": data['sessionID']
    // });


    Session.connection = ConnectionQRCode(qrCodeLink: qrCode, sessionID: data['sessionID']);

    // Session.connection.copyWith(qrCodeLink: qrCode);
    // Session.connection.copyWith(sessionID: data['sessionID']);

  } else {
    print('Failed to call API. Status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    throw Exception('Failed to load qrCode');
  }
}
Future verifyUKTraveler(String lastName, String firstName) async{
  return getQueryQRCode(
    "ipfs://QmbsEWM7nGU9p3vLkB3G8mp99WESVa25nRHS3Exq8WfBh3",
    "PassportUK", 
    [
      { "Lastname": {"\$eq": lastName}},
      {"Firstname": {"\$eq": firstName}}
    ]);
}
Future verifyDriversLicense(String lastName, DateTime birthDate) async{
  return getQueryQRCode(
    "ipfs://QmbsEWM7nGU9p3vLkB3G8mp99WESVa25nRHS3Exq8WfBh3",
    "PassportUK",  
    [
      { "Lastname": {"\$eq": lastName}},
      {"DateOfBirth": {"\$lt": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(birthDate)}}
    ]);
}
