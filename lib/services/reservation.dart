
import 'dart:convert';
import 'dart:io';
import 'package:corwoking_app/screens/login_screen.dart';
import 'package:http/http.dart' as http;

import 'package:corwoking_app/utilities/constants.dart';

String base = "reservation";
class ReservationService {


  static dynamic read() async {
    var response;
    response = await http.get(URL_API+"/"+base+"/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Erreur read');
    }
  }


  static dynamic create( Map<String,dynamic> reservationCreation) async{
    var response;
    response = await http.post(URL_API+"/"+base+"/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },body:jsonEncode(reservationCreation)
    );
    //print(response.body);
    if (response.statusCode == 201) {
      return ;
    } else {
      print(json.decode(response.body));
      throw Exception('Erreur create');
    }
  }

  static dynamic getAvailable(String openSpaceId,String date) async{
    var response;
    response = await http.get("$URL_API/reservation/available/$openSpaceId/$date",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },
    );
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Erreur getAvailable');
    }
  }

  static dynamic changeFood(String reservationId, int foodNumber) async{
    var response;
    response = await http.post("$URL_API/reservation/$reservationId/changeFood/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },body:jsonEncode({'food':foodNumber}),
    );
    //print(response.body);
    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Erreur changeFood');
    }
  }


  static dynamic addToolToReservation(String reservationId, List<String> toolsId) async{
    var response;
    response = await http.post("$URL_API/reservation/$reservationId/addTools/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },body:jsonEncode({'tools':toolsId}),
    );
    //print(response.body);
    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Erreur addToolToReservation');
    }
  }

  static dynamic removeToolsToReservation(String reservationId, List<String> toolsId) async{
    var response;
    response = await http.post("$URL_API/reservation/$reservationId/removeTools/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },body:jsonEncode({'tools':toolsId})
    );
    //print(response.body);
    if (response.statusCode == 201) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Erreur removeToolsToReservation');
    }
  }

  static dynamic delete(String reservationId) async{
    var response;
    response = await http.delete("$URL_API/reservation/$reservationId/",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.authorizationHeader: await storage.read(key: "token")
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      return responseJson;
    } else {
      throw Exception('Erreur delete');
    }
  }

}