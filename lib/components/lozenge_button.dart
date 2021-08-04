import 'package:flutter/material.dart';
// --

class LozengeButton extends StatelessWidget {
  LozengeButton({this.bgColour, this.label, @required this.onPress});

  final Color bgColour;
  final String label;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: bgColour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
            style: TextStyle(
              color: Color(0xffffffff),
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
