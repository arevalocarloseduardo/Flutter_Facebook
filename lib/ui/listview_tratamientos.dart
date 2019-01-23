import 'dart:async';

import 'package:bitstudio/ui/especialistas_screen.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import 'package:bitstudio/model/tratamientos.dart';

class ListviewTratamientos extends StatefulWidget {
  @override
  _ListviewTratamientosState createState() => _ListviewTratamientosState();
}

final tratamientosReference =
    FirebaseDatabase.instance.reference().child('tratamientos');

class _ListviewTratamientosState extends State<ListviewTratamientos> {
  List<Tratamientos> items;
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "jajaj",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: Text("Selecciona Tratamientos"),
        ),
        body: Center(
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(5.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[

                InkWell(
                  onTap: () => _navigateToNote(context, items[position]),
                  child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            '${items[position].imageurl}',
                          ),
                          Text(
                            '${items[position].title}',
                            style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.deepPurple,
                                fontStyle: FontStyle.italic),
                            textAlign: TextAlign.right,
                          )
                          
                        ],
                      ),),
                ),
                )
                
              ],
              
            );
          },
        )),
      ),
    );
  }
void _navigateToNote(BuildContext context, Tratamientos note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EspecialistasScreen(note)),
    );
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

/*Card(
            
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              
            child: Image.network(
                "https://www.imagen.com.mx/assets/img/imagen_share.png",
                fit: BoxFit.fill,),
                
             elevation: 5,
            margin: EdgeInsets.all(10),
          )*/
