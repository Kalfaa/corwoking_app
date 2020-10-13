import 'package:corwoking_app/model/open_space.model.dart';
import 'package:corwoking_app/screens/reservation.dart';
import 'package:corwoking_app/services/open_space.dart';
import 'package:corwoking_app/services/reservation.dart';
import 'package:corwoking_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'edit_reservation.dart';

class ListReservationScreen extends StatefulWidget {
  @override
  _ListReservationScreenState createState() => _ListReservationScreenState();
}


class _ListReservationScreenState extends State<ListReservationScreen> {
  List<Reservation> reservations = [];



  @override
  void initState() {
    super.initState();
    //pickeDate = DateTime.now();
    _getReservation();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( backgroundColor: PRIMARY_COLOR,title: Text("Reservation")),
        body:
          SingleChildScrollView(child:DataTable(
            columns: [
              DataColumn(label: Text('OpenSpace')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text(''))
            ],
            rows: reservations
                .map(
                  (reservation) => DataRow(
                cells: [
                  DataCell(
                    Text(reservation.room.openSpace.name),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                    Text( DateFormat('yyyy-MM-dd').format(reservation.start.toLocal())+'\n'+DateFormat('kk:00').format(reservation.start.toLocal())  +'--->' +DateFormat('kk:00').format(reservation.end.toLocal())),
                    showEditIcon: false,
                    placeholder: false,
                  ),
                  DataCell(
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.black,
                          onPressed: () async {
                            var availableJSON = await ReservationService.getAvailable(reservation.room.openSpace.id,reservation.start.toString());
                            var reservationsEdit = Available.convert(availableJSON).reservations;
                            var openSpaceJSON = await OpenSpaceService.readOne(reservation.room.openSpace.id);
                            var openSpace = OpenSpace.convert(openSpaceJSON);

                            Navigator.push(  context,
                            MaterialPageRoute(builder: (context) =>  EditReservationScreen(reservation: reservation,openSpace: openSpace,reservations: reservationsEdit,) ),);},
                        ),
                      )
                ],
              ),
            ).toList(),

          ))

      ,

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
                  print('eee');
                  Navigator.push(  context,
                    MaterialPageRoute(builder: (context) => ReservationScreen()),);
                  // Then close the drawer
                  //Navigator.pop(context);

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

    _getReservation() async  {
    List<Reservation> res = [];
    var reservationsJson = await ReservationService.read();
    for (var reservation in reservationsJson ){
      Reservation reservationConverted = Reservation.convert(reservation);
      reservations.add(reservationConverted);
    }

    setState(() {

    });
  }




}