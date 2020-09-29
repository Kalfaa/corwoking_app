import 'package:corwoking_app/utilities/constants.dart';

class OpenSpace {
  String id;
  String description;
  String name;
  List<Room> rooms;
  List<Tool> tools;

  static convert(Map map){
     OpenSpace openSpace = new OpenSpace();
     openSpace.id = map['id'];
     openSpace.description = map['description'];
     openSpace.name = map['name'];
     openSpace.rooms = Utilities.convertArray(map['rooms'],Room.convert);
     openSpace.tools = Utilities.convertArray(map['tools'],Tool.convert);
     return openSpace;
  }
}

class OpenSpaceId{
  String id;

  static dynamic convert(Map map){
    OpenSpaceId openSpace = new OpenSpaceId();
    openSpace.id = map['id'];
    return openSpace;
  }
}

class Room {
  String id;
  String description;
  String name;
  OpenSpaceId openSpace;
  bool available = true;
  static dynamic convert(Map map){
    Room openSpace = new Room();
    openSpace.id = map['id'];
    openSpace.description = map['description'];
    openSpace.name = map['name'];
    return openSpace;
  }
}

enum ToolType {
  TOOL,
  PRINTER,
  LAPTOP,
}

class Tool {
  String id;
  String name;
  ToolType type;

  static dynamic convert(Map map){
    Tool openSpace = new Tool();
    openSpace.id = map['id'];
    openSpace.name = map['name'];
    return openSpace;
  }
}


class Reservation {
  String id;
  DateTime start;
  DateTime end;
  int food;
  Room room;
  List<Tool> tools;
  String user;

  static dynamic convert(Map map){
    Reservation reservation = new Reservation();
    reservation.id = map['id'];
    reservation.start = DateTime.parse(map['start']);
    reservation.end = DateTime.parse(map['end']);
    reservation.food = map['food'];
    reservation.room = Room.convert(map['room']);
    reservation.tools = Utilities.convertArray(map['tools'],Tool.convert);
    reservation.user = map['user']['id'];
    return reservation;
  }
}

class Available {
  List<Reservation> reservations;
  var availableHour;

  static dynamic convert(Map map){
    print(map);
    Available available = new Available();
    available.reservations = Utilities.convertArray(map['reservations'],Reservation.convert);
    available.availableHour = map['availableHour'];
    return available;
  }
}