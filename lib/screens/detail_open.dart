import 'package:corwoking_app/model/open_space.model.dart';
import 'package:corwoking_app/screens/reservation.dart';
import 'package:corwoking_app/services/open_space.dart';
import 'package:corwoking_app/services/reservation.dart';
import 'package:corwoking_app/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell/widget.dart';
import 'package:intl/intl.dart';

import 'edit_reservation.dart';

class DetailOpenSpaceScreen extends StatefulWidget {
  @override
  _DetailOpenSpaceScreen createState() => _DetailOpenSpaceScreen();
}


class _DetailOpenSpaceScreen extends State<DetailOpenSpaceScreen> {


  final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2e282a),
      alignment: Alignment.topCenter,
      child: SimpleFoldingCell(
          key: _foldingCellKey,
          frontWidget: _buildFrontWidget(),
          innerTopWidget: _buildInnerTopWidget(),
          innerBottomWidget: _buildInnerBottomWidget(),
          cellSize: Size(MediaQuery.of(context).size.width, 125),
          padding: EdgeInsets.all(15),
          animationDuration: Duration(milliseconds: 300),
          borderRadius: 10,
          onOpen: () => print('cell opened'),
          onClose: () => print('cell closed')),
    );
  }

  Widget _buildFrontWidget() {
    return Container(
        color: Color(0xFFffcd3c),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/nodeon.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Odeon",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400)),
              FlatButton(
                onPressed: () => _foldingCellKey?.currentState?.toggleFold(),
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



  Widget _buildInnerTopWidget() {
    return Container(
        color: Color(0xFFff9234),
        alignment: Alignment.center,
        child: Text("TITLE",
            style: TextStyle(
                color: Color(0xFF2e282a),
                fontFamily: 'OpenSans',
                fontSize: 20.0,
                fontWeight: FontWeight.w800)));
  }

  Widget _buildInnerBottomWidget() {
    return Container(
      color: Color(0xFFecf2f9),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: FlatButton(
          onPressed: () => _foldingCellKey?.currentState?.toggleFold(),
          child: Text(
            "Close",
          ),
          textColor: Colors.white,
          color: Colors.indigoAccent,
          splashColor: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }
}
