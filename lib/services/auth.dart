import 'dart:convert';
import 'package:corwoking_app/utilities/constants.dart';
import 'package:http/http.dart' as http;

class Auth {
  static dynamic login(String username, String password) async {
    var response;
    response = await http.post(URL_API+"/auth/login",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),);
    print(json.decode(response.body));
    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Email ou Mot de Passe incorrect');
    }
  }
  static dynamic register(String username, String password) async {
    var response;
    response = await http.post(URL_API+"/auth/register",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email' : 'blabla@bla.fr',
      }),);
    print(response.body);
    if (response.statusCode == 201) {
      return ;
    } else {
      throw Exception('Un utilisateur avec ce nom existe déja');
    }
  }

}
