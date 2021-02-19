import 'package:flutter/material.dart';


class ReusableButton extends StatelessWidget {
  ReusableButton({this.title,this.function});

  final String title;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        elevation: 6.0,
        color: Colors.purple,
        borderRadius: BorderRadius.circular(26.0),
        child: MaterialButton(
          onPressed:function,
          minWidth: 200.0,
          textColor: Colors.white,
          child: Text(title,style: TextStyle(fontSize: 18.0)),
        ),
      ),
    );
  }
}
