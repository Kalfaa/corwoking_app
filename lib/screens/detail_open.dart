import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:intl/intl.dart';

import 'edit_reservation.dart';

class DetailOpenSpaceScreen extends StatefulWidget {
  @override
  _DetailOpenSpaceScreen createState() => _DetailOpenSpaceScreen();
}


class _DetailOpenSpaceScreen extends State<DetailOpenSpaceScreen> {


  final _foldingCellKey1 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey2 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey3 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey4 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey5 = GlobalKey<SimpleFoldingCellState>();
  final _foldingCellKey6 = GlobalKey<SimpleFoldingCellState>();


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2e282a),
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(child:Column(children: [
        SizedBox(height: 50),
        _detailWidget("assets/images/nodeon.jpg",_buildInnerBottomWidget,_foldingCellKey1,"Odéon"),
        _detailWidget("assets/images/nplacedit.jpg",_buildInnerBottomWidget,_foldingCellKey2,"Place d'italie"),
        _detailWidget("assets/images/nbeaubourg.jpg",_buildInnerBottomWidget,_foldingCellKey3,"Beaubourg"),
        _detailWidget("assets/images/nrepublique.jpg",_buildInnerBottomWidget,_foldingCellKey4,"République"),
        _detailWidget("assets/images/nbastille.jpeg",_buildInnerBottomWidget,_foldingCellKey5,"Bastille"),

      ],),)
    );
  }

  Widget _detailWidget(String imagePath,bottomWidget,foldingCellKey,String openSpace){
      return SimpleFoldingCell(
          key: foldingCellKey,
          frontWidget: _buildFrontWidget(imagePath,openSpace,foldingCellKey),
          innerTopWidget: _buildInnerTopWidget(imagePath),
          innerBottomWidget: bottomWidget(foldingCellKey),
          cellSize: Size(MediaQuery.of(context).size.width, 210),
          padding: EdgeInsets.all(15),
          animationDuration: Duration(milliseconds: 300),
          borderRadius: 10,
          onOpen: () => print('cell opened'),
          onClose: () => print('cell closed'));
  }


  Widget _buildFrontWidget(String imagePath,String openSpacename,foldingCellKey) {
    return Container(
        color: Color(0xFFffcd3c),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(openSpacename,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400)),
              FlatButton(
                onPressed: () => foldingCellKey?.currentState?.toggleFold(),
                child: Text(
                  "Voir plus",
                ),
                textColor: Colors.white,
                color: Colors.indigoAccent,
                splashColor: Colors.white.withOpacity(0.5),
              )
            ],
          ) /* add child content here */,
        ),
    );
  }



  Widget _buildInnerTopWidget(String  imagePath) {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    ),
        alignment: Alignment.center,);
  }

  Widget _buildInnerBottomWidget(foldingCellKey) {
    return Container(
      color: Color(0xFFecf2f9),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Column(children: [
          Row(
            children:[
            Icon(
              Icons.place,
              color: Colors.green,
              size: 30.0,
            ),
            Text("3 rue du faubourg saint antoine",  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.2),) ,],),
          Row(
            children:[
            Icon(
              Icons.phone,
              color: Colors.red,
              size: 30.0,
            ),
            Text("01 34 33 32 31",  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.2),) ,],),

          Row(
            children:[
            Icon(
              Icons.wifi,
              color: Colors.greenAccent,
              size: 30.0,
            ),
            Text("Wi-Fi très haut débit",  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.2),) ,  Icon(
              Icons.score,
              color: Colors.blue,
              size: 30.0,
            ),
            Text("4 salles de réunion",  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.2),) ,],),

        Row(
          children:[
          Icon(
            Icons.mms,
            color: Colors.orange,
            size: 30.0,
          ),
          Text("2 salons cosy",  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.2),) ,
            SizedBox(width: 50),
            Icon(
            Icons.print,
            color: Colors.blue,
            size: 30.0,
          ),

          Text("2 Imprimantes",  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.2),) ,],)
          ,
        Row(
          children:[
            Icon(
              Icons.local_drink,
              color: Colors.brown,
              size: 30.0,
            ),
            Text("Boissons à volontés",  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.2),) ,
            SizedBox(width: 10),
            Icon(
              Icons.laptop,
              color: Colors.blue,
              size: 30.0,
            ),

            Text("18 ordinateurs portables",  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.2),) ,],),

          FlatButton(
          onPressed: () => foldingCellKey?.currentState?.toggleFold(),
          child: Text(
            "Close",
          ),
          textColor: Colors.white,
          color: Colors.indigoAccent,
          splashColor: Colors.white.withOpacity(0.5),
        )],),
      ),
    );
  }
}
