import 'dart:convert';
import 'dart:io';

import 'package:corwoking_app/screens/login_screen.dart';
import 'package:corwoking_app/utilities/constants.dart';
import 'package:http/http.dart' as http;
String base ="openSpace";

class OpenSpaceService {


  static dynamic read() async {
    var response;
    response = await http.get(URL_API+"/"+base+"/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },
     );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson;

    } else {
      throw Exception('Erreur read');
    }

  }


}