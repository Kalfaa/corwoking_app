import 'package:corwoking_app/screens/reservation.dart';
import 'package:corwoking_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatelessWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: PRIMARY_COLOR,title: Text(title)),
      body: Center(child: Text('My Page!')),

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
}