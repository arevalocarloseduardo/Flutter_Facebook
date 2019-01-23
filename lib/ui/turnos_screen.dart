import 'package:bitstudio/model/especialistas.dart';
import 'package:bitstudio/model/tratamientos.dart';
import 'package:bitstudio/model/turnos.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class TurnosScreen extends StatefulWidget {
  final Especialistas especialistas;
  final Tratamientos tratamientos;
  TurnosScreen(this.especialistas,this.tratamientos);

  @override
  _TurnosScreenState createState() => _TurnosScreenState();
}
final turnosReference =
    FirebaseDatabase.instance.reference().child('turnos');

class _TurnosScreenState extends State<TurnosScreen> {
  List<Turnos> turnos;
  DateTime _selectedDay;
  StreamSubscription<Event> _onTurnosAddedSubscription;
  StreamSubscription<Event> _onTurnosChangedSubscription;
  
   @override
  void initState() {
    super.initState();
    turnos = new List();
    _onTurnosAddedSubscription =
        turnosReference.onChildAdded.listen(_onTurnosAdded);
    _onTurnosChangedSubscription =
        turnosReference.onChildChanged.listen(_onTurnosUpdated);
  }

 set selectedTime(DateTime time) {
    setState(() {
      _selectedDay = time;
    });
  }
   void handleNewDate(date) {
    print("handleNewDate ${date}");
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 250.0,
          floating: false, //sino sigue de largo el text
          pinned: true, //sino sigue de largo
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              widget.tratamientos.title,
              style: TextStyle(color: Colors.black),
            ),
            background: Image.network(
              widget.tratamientos.imageurl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverFillRemaining(
            child: Container(
              margin: new EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              Calendar(
                onSelectedRangeChange: (range) =>
                    print("Range is ${range.item1}, ${range.item2}"),
                isExpandable: true,
              ),
              new Divider(
                height: 50.0,
                
              ),
           
            ],
          ),

         /* margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: CalendarCarousel(
              selectedDateTime: _selectedDay,
              onDayPressed: (DateTime time, List event) {
                selectedTime = time;
              }),*/
            )
        )
      ],
    ));
  }

  void _onTurnosAdded(Event event) {
    setState(() {
      turnos.add(new Turnos.fromSnapshot(event.snapshot));
    });
  }

  void _onTurnosUpdated(Event event) {
    var oldNoteValue =
        turnos.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      turnos[turnos.indexOf(oldNoteValue)] =
          new Turnos.fromSnapshot(event.snapshot);
    });
  }
}