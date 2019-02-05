import 'package:bitstudio/model/especialistas.dart';
import 'package:bitstudio/model/subTratamientos.dart';
import 'package:bitstudio/ui/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class ConfirmacionScreen extends StatefulWidget {
  final Especialistas especialistas;
  final SubTratamientos tratamientos;
  final String hora;
  final String dia;
  ConfirmacionScreen(
      this.especialistas, this.tratamientos, this.hora, this.dia);
  @override
  _ConfirmacionScreenState createState() => _ConfirmacionScreenState();
}

final turnosReference = FirebaseDatabase.instance.reference().child('turnos');

class _ConfirmacionScreenState extends State<ConfirmacionScreen> {
  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;
  var p1 = [
    "00:00",
    "00:30",
    "01:00",
    "01:30",
    "02:00",
    "02:30",
    "03:00",
    "03:30",
    "04:00",
    "04:30",
    "05:00",
    "05:30",
    "06:00",
    "06:30",
    "07:00",
    "07:30",
    "08:00",
    "08:30",
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "13:00",
    "13:30",
    "14:00",
    "14:30",
    "15:00",
    "15:30",
    "16:00",
    "16:30",
    "17:00",
    "17:30",
    "18:00",
    "18:30",
    "19:00",
    "19:30",
    "20:00",
    "20:30",
    "21:00",
    "21:30",
    "22:00",
    "22:30",
    "23:00",
    "23:30",
  ];
  var turno1;
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < p1.length; i++) {
      if (widget.hora == p1[i]) {
        setState(() {
          turno1 = p1[i + 1];
        });
      }
    }
    _auth = FirebaseAuth.instance;

    getCurrentUser() async {
      mCurrentUser = await _auth.currentUser();
      setState(
        () {
          mCurrentUser != null
              ? accountStatus = '${mCurrentUser.uid}'
              : 'no hay usuario';
        },
      );
    }

    print("antes del user${getCurrentUser()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[600],
        centerTitle: true,
        title: Text("Confirmar"),
      ),
      body: Center(
          child: Card(
        child: Container(
          alignment: AlignmentDirectional.bottomCenter,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Confirmar Reserva",
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ),
              Divider(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(Icons.perm_identity)),
                  Text(
                    "Especialista:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${widget.especialistas.nombre}",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            NetworkImage("${widget.especialistas.fotoperfil}"),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.receipt),
                  ),
                  Text(
                    "tratamiento:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.tratamientos.nombre,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.calendar_today),
                  ),
                  Text(
                    "Fecha:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.dia,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.access_time),
                  ),
                  Text(
                    "Horario:",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    widget.hora,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 25,
                color: Colors.white,
              ),
              RaisedButton.icon(
                color: Colors.purple[200],
                onPressed: () {
                  var duracion = widget.tratamientos.duracion;

                  if (int.parse(duracion) > 40) {
                    turnosReference.push().set({
                      'cliente': "duracion",
                      'especialista': "${widget.especialistas.id}",
                      'fecha': "${widget.dia}",
                      'hora': "${turno1}",
                      'tratamiento': "${widget.tratamientos.id}"
                    });
                  }
                  turnosReference.push().set({
                    'cliente': "$accountStatus",
                    'especialista': "${widget.especialistas.id}",
                    'fecha': "${widget.dia}",
                    'hora': "${widget.hora}",
                    'tratamiento': "${widget.tratamientos.id}"
                  }).then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MenuScreen(2)),
                    );
                  });
                },
                icon: Icon(Icons.add),
                label: Text("Reservar"),
              )
            ],
          ),
        ),
        margin: EdgeInsets.all(20.0),
        elevation: 5.0,
      )),
    );
  }
}
