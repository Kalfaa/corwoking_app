import 'package:carousel_slider/carousel_slider.dart';
import 'package:corwoking_app/screens/detail_open.dart';
import 'package:corwoking_app/screens/reservation.dart';
import 'package:corwoking_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import 'list_reservation.dart';
var imgList = ['nrepublique.jpg','nbastille.jpeg','nodeon.jpg','nbeaubourg.jpg','nplacedit.jpg','nternes.jpg'];
var nameOpen = ['République','Bastille','Odéon','Beaubourg',"Place d'italie",'Ternes'];

class Home extends StatelessWidget {
  final String title;
  Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( backgroundColor: PRIMARY_COLOR,title: Text(title)),
      body: Container(
          child: SingleChildScrollView(  child :
          Column(children: <Widget>[
            Text(
            "Coworking",
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    color: Colors.cyan,
                    fontSize: 18,
                    fontWeight: FontWeight.w900)),
          ),
            SizedBox(
              height: 8,
            ),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
            SizedBox(
              height: 18,
            ),
          Text(
            "Bienvenue sur l'application de mobile CO'WORKING vous pouvez réserver un espace de travail ou gérer vos réservations",
            style: GoogleFonts.openSans(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w300)),
          ),
            SizedBox(
              height: 18,
            )
            ,
          Padding(padding:EdgeInsets.all(15.0),
              child:Material(
            elevation: 4.0,
            clipBehavior: Clip.hardEdge,
            // needed
            color: Colors.transparent,
            child: InkWell(
              onTap: () => {Navigator.push(  context,
                MaterialPageRoute(builder: (context) => ReservationScreen()),)}, // needed
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset("assets/images/republique_hero.jpg"),
              ),
            ),
          )),
            Padding(padding:EdgeInsets.all(15.0),
                child:Material(
                  elevation: 4.0,
                  clipBehavior: Clip.hardEdge,
                  // needed
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => { Navigator.push(  context,
                    MaterialPageRoute(builder: (context) => ListReservationScreen()),)}, // needed
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset("assets/images/mesres.jpg"),
                    ),
                  ),
                )),
            Padding(padding:EdgeInsets.all(15.0),
                child:Material(
                  elevation: 4.0,
                  clipBehavior: Clip.hardEdge,
                  // needed
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => { Navigator.push(  context,
                    MaterialPageRoute(builder: (context) => DetailOpenSpaceScreen())),}, // needed
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset("assets/images/detailsdeslocaux.jpg"),
                    ),
                  ),
                ))
          ],)
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
              title: Text('Mes réservations'),
              onTap: () {

                // Update the state of the app
                // ...
                // Then close the drawer
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


  final List<Widget> imageSliders = imgList.map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.asset('assets/images/'+item),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    '${nameOpen[imgList.indexOf(item)]}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    ),
  )).toList();

}