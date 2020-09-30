import 'package:corwoking_app/utilities/constants.dart';
import 'package:enum_to_string/enum_to_string.dart';


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
     openSpace.rooms = new List<Room>.from(Utilities.convertArray(map['rooms'],Room.convert));
     openSpace.tools = new List<Tool>.from(Utilities.convertArray(map['tools'],Tool.convert));
     return openSpace;
  }

  static returnByID(List<OpenSpace> openSpaces,String id){
    for (OpenSpace openSpace in openSpaces){
      if(id==openSpace.id){
        return openSpace;
      }
    }
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
    openSpace.type = EnumToString.fromString(ToolType.values,map['type']);
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
    reservation.tools =  new List<Tool>.from(Utilities.convertArray(map['tools'],Tool.convert));
    reservation.user = map['user']['id'];
    return reservation;
  }


}

class Available {
  List<Reservation> reservations;
  var availableHour;

  static dynamic convert(Map map){
    Available available = new Available();
    available.reservations =  new List<Reservation>.from(Utilities.convertArray(map['reservations'],Reservation.convert));
    available.availableHour = map['availableHour'];
    return available;
  }

}

class SortedTool{
    List<Tool> laptops = [];
    List<Tool> printers = [];
    List<Tool> others = [];

    static dynamic fromListTool(List<Tool> tools){
      SortedTool res = new SortedTool();
      for(Tool tool in tools){
        if(tool.type == ToolType.LAPTOP){
          res.laptops.add(tool);
        }else if(tool.type == ToolType.PRINTER){
          res.printers.add(tool);
        }else if(tool.type == ToolType.TOOL){
          res.others.add(tool);
        }
      }
      return res;
    }
}

class ReservationCreation {
  String start;
  String end;
  int food;
  String room;
  List<String> tools;

  toJson(){
    Map<String,dynamic> json={'start':start,'end':end,'food':food,'room':room,'tools':tools};
    return json;
  }
}