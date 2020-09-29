import 'package:corwoking_app/model/open_space.model.dart';
import 'package:corwoking_app/services/open_space.dart';
import 'package:corwoking_app/services/reservation.dart';
import 'package:corwoking_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_select/smart_select.dart';
import 'package:time_range/time_list.dart';
import 'package:time_range/time_range.dart';

class ReservationScreen extends StatefulWidget {
  @override
  _Reservation createState() => _Reservation();
}

class _Reservation extends State<ReservationScreen> {
  DateTime pickeDate;
  List<S2Choice<OpenSpace>> options = [];
  List<OpenSpace> openSpacesList = [];
  List<Reservation> availableReservation= [];
  Available available;
  OpenSpace openSpaceSelected;
  bool showFromTP = false;
  bool showToTP = false;
  var hourArray = ['8:00', '9:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00'];
  var availableHour= {8:{"available":false},9:{"available":false},10:{"available":false},11:{"available":false},12:{"available":false},13:{"available":false},14:{"available":false},
    15:{"available":false},16:{"available":false},17:{"available":false},18:{"available":false},19:{"available":false},20:{"available":false},21:{"available":false}};


  TimeOfDay fromStartTP = TimeOfDay(hour: 8, minute: 00);
  TimeOfDay fromEndTP = TimeOfDay(hour: 21, minute: 00);

  TimeOfDay toStartTP = TimeOfDay(hour: 8, minute: 00);
  TimeOfDay toEndTP = TimeOfDay(hour: 21, minute: 00);

  @override
  void initState() {
    super.initState();
    pickeDate = DateTime.now();
    _getOpenSpace();
  }



  _pickDate() async {
    DateTime date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year+2),
      initialDate:pickeDate,
    );


    if(date != null){
      setState((){
        pickeDate = date;
      });
      if(openSpaceSelected!=null){
        print("getAvailable");
        var availableJSON = await ReservationService.getAvailable(openSpaceSelected.id, pickeDate.toString());
        available = Available.convert(availableJSON);

        showFromTP = true;
        setState(() {

        });
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( backgroundColor: PRIMARY_COLOR,title: Text("Reservation")),
        body:Column(children:[
          Flexible(
          child:SmartSelect<OpenSpace>.single(
            title: 'Openspace',
            value: openSpaceSelected,
            choiceItems: options,
            onChange: (state) => setState(() => openSpaceSelected = state.value)
        ),
          ),
          Flexible(
            child: ListTile(
              title: Text( "Date : ${pickeDate.day} ${pickeDate.month} ${pickeDate.year}"),
              trailing:Icon(Icons.keyboard_arrow_down),
              onTap: _pickDate,
            ),

          ),Visibility(
              visible:showFromTP ,
              child:Column(children:[
                Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text('Date de début', style: TextStyle(fontSize: 18, color: Colors.grey),),
              ),
                SizedBox(height: 8),
                TimeList(
                  firstTime: fromStartTP,
                  lastTime: fromEndTP,
                  initialTime: fromStartTP,
                  timeStep: 60,
                  padding: 20,
                  onHourSelected: _startHourChanged,
                  borderColor: Colors.black54,
                  activeBorderColor: Colors.orange,
                  backgroundColor: Colors.transparent,
                  activeBackgroundColor: Colors.orange,
                  textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
                  activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                )

          ])),
          Visibility(
              visible:showToTP ,
              child:Column(children:[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text('Date de fin', style: TextStyle(fontSize: 18, color: Colors.grey),),
                ),
                SizedBox(height: 8),
                TimeList(
                  firstTime: toStartTP,
                  lastTime: toEndTP,
                  initialTime: toStartTP,
                  timeStep: 60,
                  padding: 20,
                  onHourSelected: _endHourChanged,
                  borderColor: Colors.black54,
                  activeBorderColor: Colors.orange,
                  backgroundColor: Colors.transparent,
                  activeBackgroundColor: Colors.orange,
                  textStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black87),
                  activeTextStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                )

              ]))

        ]),

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
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Mes réservations'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Mon compte'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        )
    );
  }
  _getOpenSpace() async {
    var openSpaces = await OpenSpaceService.read();
    for (var openSpaceJSON in openSpaces){
      OpenSpace openSpace = OpenSpace.convert(openSpaceJSON);
      openSpacesList.add(openSpace);
      options.add(S2Choice<OpenSpace>(value: openSpace, title: openSpace.name));
    }
  }

  void _startHourChanged(TimeOfDay hour) {
    print(hour.hour);
    if(available.availableHour[hour.hour.toString()] == openSpaceSelected.rooms.length){
      return;
    }
    showToTP=true;
    var possibleEnd =  findNextHourAvailable(hour.hour,available.availableHour);
    toEndTP = TimeOfDay(hour: possibleEnd, minute: 00);
    setState(() => toStartTP = hour.add(minutes: 60));
  }

  void _endHourChanged(TimeOfDay hour) {
  }

  findNextHourAvailable(start,availableHour) {
    while(start<21){
      start++;
      if(available.availableHour[start.toString()] == openSpaceSelected.rooms.length){
        return start;
      }
    }
    return 22;
  }


}




List<Map<String, String>> days = [
  { 'value': 'mon', 'title': 'Monday' },
  { 'value': 'tue', 'title': 'Tuesday' },
  { 'value': 'wed', 'title': 'Wednesday' },
  { 'value': 'thu', 'title': 'Thursday' },
  { 'value': 'fri', 'title': 'Friday' },
  { 'value': 'sat', 'title': 'Saturday' },
  { 'value': 'sun', 'title': 'Sunday' },
];


