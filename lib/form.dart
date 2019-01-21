/*
import 'dart:async';
import 'package:bitstudio/PantallaPrincipal.dart';
import 'package:flutter/material.dart';
import 'package:bitstudio/MenuPrincipal.dart';


void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.purpleAccent,
    accentColor: Colors.yellowAccent
    ),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
  routes: <String,WidgetBuilder>{
    '/Second':(BuildContext context)=>MenuPrincipal(),
  },
  ));


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds:3),
    ()=> Navigator.push(
      context,
      MaterialPageRoute(builder: (context)=>PantallaPrincipal()),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              gradient: LinearGradient(
                colors: [Color(0xff622f74),Color(0xffde5cbc)],
                begin: Alignment.centerRight,
                end: Alignment(-1.0,-1.0),
              )
              ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 50.0,
                    child: Icon(
                      Icons.shopping_cart,
                      color: Colors.greenAccent,
                      size: 50.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0)
                    ),
                    Text("Estetica",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      ))
                ],
              )
            ),
            ),
            Expanded(flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                  ),
                  Text("Estetica\nLa Plata",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                    ),
                    )
              ],
            ),
            )
          ],
          )
        ],
      ),
    );
  }
}

*/