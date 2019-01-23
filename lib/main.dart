import 'package:bitstudio/SplasScreen.dart';
import 'package:bitstudio/ui/listview_tratamientos.dart';
import 'package:flutter/material.dart';


void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.purpleAccent,
    accentColor: Colors.yellowAccent
    ),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
  routes: <String,WidgetBuilder>{
    '/Second':(BuildContext context)=>ListviewTratamientos(),
  },
  ));


