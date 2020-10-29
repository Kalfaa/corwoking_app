import 'package:corwoking_app/component/flush_bar_message.dart';
import 'package:corwoking_app/model/open_space.model.dart';
import 'package:corwoking_app/screens/reservation.dart';
import 'package:corwoking_app/services/open_space.dart';
import 'package:corwoking_app/services/reservation.dart';
import 'package:corwoking_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home.dart';
import 'list_reservation.dart';


class EditReservationScreen extends StatefulWidget {

  final Reservation reservation;
  final List<Reservation> reservations;
  final OpenSpace openSpace;
  EditReservationScreen({Key key, this.reservation,this.reservations,this.openSpace}) : super(key: key);
  @override
  _EditReservationScreenState createState() => _EditReservationScreenState();
}


class _EditReservationScreenState extends State<EditReservationScreen> {
  SortedTool availableTools = new SortedTool();
  SortedTool resSortedTool = new SortedTool();
  int printerModify = 0;
  int laptopModify = 0;
  int foodModify = 0;
  List<Reservation> reservations;
  OpenSpace openSpace ;


  @override
  void initState() {
    super.initState();

    setState(() {
    reservations = widget.reservations;
    openSpace = widget.openSpace;
    resSortedTool = SortedTool.fromListTool( widget.reservation.tools);
    availableTools = SortedTool.fromListTool(this.getAvailableTool());
    printerModify = resSortedTool.printers.length;
    laptopModify = resSortedTool.laptops.length;
    foodModify = widget.reservation.food;

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( backgroundColor: PRIMARY_COLOR,title: Text("Reservation")),
        body:Column(children: [
          Row(children:[
              Icon(
                Icons.calendar_today,
                color: Colors.green,
                size: 30.0,
              ),
                Text(new DateFormat('E dd MMMM','fr_FR').format(widget.reservation.start))],),
            Row(children:[Icon(
              Icons.access_alarm,
              color: Colors.red,
              size: 30.0,
            ),

              Text(new DateFormat('kk:00   ------>   ','fr_FR').format(widget.reservation.start.toLocal())),
              Text(new DateFormat('kk:00','fr_FR').format(widget.reservation.end.toLocal())), ]),
          Icon(
            Icons.laptop,
            color: Colors.black,
            size: 48.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          Visibility(
            visible: availableTools.laptops.length+resSortedTool.laptops.length>0,
            child: Slider(
              value:laptopModify+.0,
              min : 0,
              max : availableTools.laptops.length+resSortedTool.laptops.length+.0,
              onChanged: (newRating){ setState( ()=> laptopModify = (newRating).toInt());},
              divisions:getDivisions(availableTools.laptops,resSortedTool.laptops),
              label:"$laptopModify",
            ),),
            Visibility(
            visible: availableTools.laptops.length+resSortedTool.laptops.length<=0 ,
            child:Text(
            "Il n'y a plus d'ordinateur disponible",
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.bold),
            )
            ),
          Icon(
            Icons.print,
            color: Colors.black,
            size: 48.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          Visibility(
            visible: availableTools.printers.length+resSortedTool.printers.length>0,
            child: Slider(
              value:printerModify+.0,
              min : 0,
              max : availableTools.printers.length+resSortedTool.printers.length+.0,
              onChanged: (newRating){ setState( ()=> printerModify = (newRating).toInt());},
              divisions: getDivisions(availableTools.printers,resSortedTool.printers),
              label:"$printerModify",
            ),),
            Visibility(
                visible: availableTools.printers.length+resSortedTool.printers.length<=0 ,
                child:Text(
                  "Il n'y a plus d'imprimante disponible",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
            ),
          Icon(
            Icons.fastfood,
            color: Colors.black,
            size: 48.0,
            semanticLabel: 'Text to announce in accessibility modes',
          ),
          Visibility(
            visible: true,
            child: Slider(
              value:foodModify+.0,
              min : 0,
              max : 20,
              onChanged: (newRating){ setState( ()=> foodModify = (newRating).toInt());},
              divisions:20,
              label:"$foodModify",
            ),),
          FlatButton(
            color: PRIMARY_COLOR,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              changeReservation();
            },
            child: Text(
              "Sauvegarder les changements !",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          FlatButton(
            color: Colors.red,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.red,
            onPressed: () {
              showAlertDialog(context);
            },
            child: Text(
              "Annuler la reservation !",
              style: TextStyle(fontSize: 20.0),
            ),
          )


        ]

        ),

      drawer: Container( width:200 ,child:Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 85.0,
            child:DrawerHeader(
              child: Text('Coworking'),
              decoration: BoxDecoration(
                color: PRIMARY_COLOR,
              ),
            ),
          ),
          ListTile(
            title: Text('Reserver une salle'),
            onTap: () {
              // Update the state of the app
              // ...
              Navigator.popUntil(context,ModalRoute.withName('main'));

              Navigator.push(  context,
                MaterialPageRoute(builder: (context) => ReservationScreen()),);
              // Then close the drawer
              //Navigator.pop(context);

            },
          ),
          ListTile(
            title: Text('Mes réservations'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.popUntil(context,ModalRoute.withName('main'));

              Navigator.push(  context,
                MaterialPageRoute(builder: (context) => ListReservationScreen()),);
              //Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
    )
    );
  }

  getDivisions(List<Object> list1,List<Object> list2){
    if(list1.length + list2.length == 0){
      return 1;
    }
    print("lap");
    print(list1.length);
    print(list2.length);
    return list1.length+list2.length;

  }

  List<Tool> getAvailableTool(){
    List<Tool> tools = [];
    for (Tool tool in this.openSpace.tools){
      if(this.isToolAvailable(tool.id))
      {
        tools.add(tool);
        print("add");
      }
    }
    return tools;
  }

  bool isToolAvailable(String id) {
    DateTime start = widget.reservation.start;
    DateTime end = widget.reservation.end;

    for (Reservation reservation in  widget.reservations){
      for(Tool tool in reservation.tools){
        if (tool.id == id ){
          if (this.isDateOverLapping(reservation.start, reservation.end, start, end))
          {
            return false;
          }
        }
      }
    }
    return true;
  }


  isDateOverLapping(DateTime startDate1, DateTime endDate1, DateTime startDate2,  DateTime endDate2){
    return (startDate1.isBefore(endDate2) || startDate1.isAtSameMomentAs(endDate2) ) && (endDate1.isAfter(startDate2) || endDate1.isAtSameMomentAs(startDate2) );
  }

  getLength(List<Object> list){
    if(list.length<=0){
      return 1;
    }
    return list.length;
  }

  void changeReservation() async  {
    print(laptopModify-resSortedTool.laptops.length);
    print(printerModify-resSortedTool.printers.length);
    List remove = pickSomeToolToRemove(laptopModify-resSortedTool.laptops.length,printerModify-resSortedTool.printers.length);
    List add= pickSomeToolToReserve(laptopModify-resSortedTool.laptops.length,printerModify-resSortedTool.printers.length);
    print(remove.length);
    print(add.length);
    await ReservationService.addToolToReservation(widget.reservation.id,add);
    await ReservationService.removeToolsToReservation(widget.reservation.id,remove);
    await ReservationService.changeFood(widget.reservation.id,foodModify);
    Navigator.of(context).popUntil((route) => route.isFirst);
    FlushBarMessage.goodMessage(content: "Reservation modifié !").showFlushBar(context);

  }

  pickSomeToolToRemove(int laptopToAdd,int printerToAdd){
    List<String> res = [];
    if(laptopToAdd<0){
      for(Tool tool in resSortedTool.laptops){
        res.add(tool.id);
        laptopToAdd++;
        if(laptopToAdd==0){
          break;
        }
      }
    }

    if(printerToAdd<0){
      for(Tool tool in resSortedTool.printers){
        res.add(tool.id);
        printerToAdd++;
        if(printerToAdd==0){
          break;
        }
      }
    }
    return res;

  }

  pickSomeToolToReserve(int pcNumber, int printerNumber){
    List<String> res = [];
    int pcRetrieve = 0;
    int  printerRetrieve = 0;
    for (Tool laptop in availableTools.laptops){
      if( pcRetrieve >= pcNumber){
        break;
      }
      res.add(laptop.id);
      pcRetrieve += 1;

    }

    for (Tool printer in availableTools.printers){
      if( printerRetrieve >= printerNumber){
        break;
      }
      res.add(printer.id);
      printerRetrieve++;
    }
    return res;
  }


  showAlertDialog(BuildContext context) {  // set up the button
    Widget cancelButton = FlatButton(
      child: Text("Non"),
      onPressed:  () {},
    );
    Widget continueButton = FlatButton(
      child: Text("Oui"),
      onPressed:  () async {
        await ReservationService.delete(widget.reservation.id);
        Navigator.of(context).popUntil((route) => route.isFirst);
        FlushBarMessage.goodMessage(content: "Reservation annulé  !").showFlushBar(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Annuler la reservation"),
      content: Text("Etes vous sûr de vouloir annuler cette reservation ?"),
      actions: [
        cancelButton,
        continueButton
      ],
    );  // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}