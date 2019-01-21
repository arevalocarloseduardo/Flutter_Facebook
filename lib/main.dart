import 'package:bitstudio/SplasScreen.dart';
import 'package:flutter/material.dart';
import 'package:bitstudio/ui/listview_note.dart';


void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.purpleAccent,
    accentColor: Colors.yellowAccent
    ),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
  routes: <String,WidgetBuilder>{
    '/Second':(BuildContext context)=>ListViewNote(),
  },
  ));


