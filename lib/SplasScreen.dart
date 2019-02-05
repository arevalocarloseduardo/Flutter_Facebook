import 'dart:async';

import 'package:bitstudio/MenuPrincipal.dart';
import 'package:bitstudio/PantallaPrincipal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;

    getCurrentUser() async {
      mCurrentUser = await _auth.currentUser();
      setState(
        () {
          mCurrentUser != null
              ? Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuPrincipal()),
                )
              : 'no hay usuario';
        },
      );
    }

    print("antes del user${getCurrentUser()}");

    Timer(
        Duration(seconds: 5),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PantallaPrincipal()),
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
                  colors: [Color(0xff622f74), Color(0xffde5cbc)],
                  begin: Alignment.centerRight,
                  end: Alignment(-1.0, -1.0),
                )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
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
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Text("Estetica",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                )),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      "Estetica\nLa Plata",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
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
