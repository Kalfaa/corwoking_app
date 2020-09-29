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
  List<S2Choice<String>> options = [];
  List<OpenSpace> openSpacesList = [];
  List<Reservation> availableReservation= [];
  String value = 'OpenSpace';
  bool showFromTP = false;
  bool showToTP = false;
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
      if(value!='OpenSpace'){
        print("getAvailable");
        var availableJSON = await ReservationService.getAvailable(value, pickeDate.toString());
        Available available = Available.convert(availableJSON);
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
          child:SmartSelect<String>.single(
            title: 'Openspace',
            value: value,
            choiceItems: options,
            onChange: (state) => setState(() => value = state.value)
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
      options.add(S2Choice<String>(value: openSpace.id, title: openSpace.name));
    }
  }

  void _startHourChanged(TimeOfDay hour) {
    showToTP=true;
    setState(() => toStartTP = hour.add(minutes: 60));
  }

  void _endHourChanged(TimeOfDay hour) {
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


