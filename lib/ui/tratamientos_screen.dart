
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:bitstudio/model/tratamientos.dart';
import 'package:flutter_calendar/flutter_calendar.dart';


class TratamientosScreen extends StatefulWidget {
  final Tratamientos tratamientos;
  TratamientosScreen(this.tratamientos);
  

  @override
  _TratamientosScreenState createState() => _TratamientosScreenState();
}

final tratamientosReference =
    FirebaseDatabase.instance.reference().child('tratamientos');

class _TratamientosScreenState extends State<TratamientosScreen> {
  List<Tratamientos> items;
  DateTime _selectedDay;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;

  @override
  void initState() {
    super.initState();
    items = new List();
    _onNoteAddedSubscription =
        tratamientosReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription =
        tratamientosReference.onChildChanged.listen(_onNoteUpdated);
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

  void _onNoteAdded(Event event) {
    setState(() {
      items.add(new Tratamientos.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue =
        items.singleWhere((note) => note.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldNoteValue)] =
          new Tratamientos.fromSnapshot(event.snapshot);
    });
  }
}
