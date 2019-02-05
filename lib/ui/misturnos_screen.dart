import 'package:bitstudio/model/subTratamientos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:bitstudio/model/turnos.dart';

class MisTurnosScreen extends StatefulWidget {
  @override
  _MisTurnosScreenState createState() => _MisTurnosScreenState();
}

final notesReference = FirebaseDatabase.instance.reference().child('turnos');

final subReference =
    FirebaseDatabase.instance.reference().child('subtratamientos');

class _MisTurnosScreenState extends State<MisTurnosScreen> {
  List<Turnos> turnos;
  List<SubTratamientos> sub;
  StreamSubscription<Event> _onTurnosAddedSubscription;
  StreamSubscription<Event> _onTurnosChangedSubscription;
  StreamSubscription<Event> _onSubAddedSubscription;
  StreamSubscription<Event> _onSubChangedSubscription;

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
              ? accountStatus = '${mCurrentUser.uid}'
              : 'no hay usuario';
        },
      );
    }

    print("antes del user${getCurrentUser()}");

    turnos = new List();
    sub = new List();
    _onTurnosAddedSubscription =
        notesReference.onChildAdded.listen(_onTurnosAdded);
    _onTurnosChangedSubscription =
        notesReference.onChildChanged.listen(_onTurnosUpdated);

    _onSubAddedSubscription = subReference.onChildAdded.listen(_onSubAdded);
    _onSubChangedSubscription =
        subReference.onChildChanged.listen(_onSubUpdated);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "ksk",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[600],
          centerTitle: true,
          title: Text("Turnos Reservados"),
        ),
        body: Container(
          color: Colors.white,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: creartext(),
            ),
          ),
        ),
      ),
    );
  }

  List<Column> creartext() {
    List<Column> childrenText = List<Column>();

    for (var name in turnos) {
      for (var inde in sub) {
        if (name.cliente == "$accountStatus") {
          if (inde.id == name.tratamiento) {
            childrenText.add(
          new Column(
            children: <Widget>[
              Card(
                elevation: 5,
                child: ListTile(
                    leading: Container(
                      child: Icon(Icons.send, color: Colors.black),
                    ),
                    title: Text(
                      name.hora,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text(
                      "${inde.nombre}",
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: Text("Fecha:${name.fecha}"),
                    onTap: () => {}),
              ),
            ],
          ),
        );
          }
        }
      }
    }
    return childrenText;
  }

  void _onTurnosAdded(Event event) {
    setState(
      () {
        turnos.add(new Turnos.fromSnapshot(event.snapshot));
      },
    );
  }

  void _onTurnosUpdated(Event event) {
    var oldNoteValue =
        turnos.singleWhere((note) => note.id == event.snapshot.key);
    setState(
      () {
        turnos[turnos.indexOf(oldNoteValue)] =
            new Turnos.fromSnapshot(event.snapshot);
      },
    );
  }

  void _onSubAdded(Event event) {
    setState(
      () {
        sub.add(new SubTratamientos.fromSnapshot(event.snapshot));
      },
    );
  }

  void _onSubUpdated(Event event) {
    var oldNoteValue = sub.singleWhere((note) => note.id == event.snapshot.key);
    setState(
      () {
        sub[sub.indexOf(oldNoteValue)] =
            new SubTratamientos.fromSnapshot(event.snapshot);
      },
    );
  }
}
