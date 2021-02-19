import 'package:flutter/material.dart';

const kTitleTextStyle=TextStyle(
    fontSize: 50.0,
    fontWeight: FontWeight.bold
);

const kDecoration=InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 10.0),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0))
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white ,width: 1),
        borderRadius: BorderRadius.all(Radius.circular(30.0))
    ),
    focusedBorder:OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white ,width: 2),
        borderRadius: BorderRadius.all(Radius.circular(30.0))
    )
);