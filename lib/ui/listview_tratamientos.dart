import 'dart:async';
import 'package:bitstudio/model/subTratamientos.dart';
import 'package:bitstudio/ui/especialistas_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:bitstudio/model/tratamientos.dart';
import 'package:configurable_expansion_tile/configurable_expansion_tile.dart';

class ListviewTratamientos extends StatefulWidget {
  @override
  _ListviewTratamientosState createState() => _ListviewTratamientosState();
}

final tratamientosReference =
    FirebaseDatabase.instance.reference().child('tratamientos');
final subTratamientosReference =
    FirebaseDatabase.instance.reference().child('subtratamientos');

class _ListviewTratamientosState extends State<ListviewTratamientos> {
  List<SubTratamientos> sub;
  List<Tratamientos> items;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;

  StreamSubscription<Event> _onSubAddedSubscription;
  StreamSubscription<Event> _onSubChangedSubscription;

  @override
  void initState() {
    super.initState();

    items = new List();
    sub = new List();
    _onNoteAddedSubscription =
        tratamientosReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription =
        tratamientosReference.onChildChanged.listen(_onNoteUpdated);
    _onSubAddedSubscription =
        subTratamientosReference.onChildAdded.listen(_onSubAdded);
    _onSubChangedSubscription =
        subTratamientosReference.onChildChanged.listen(_onSubUpdated);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "jajaj",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple[600],
          centerTitle: true,
          title: Text("Selecciona Tratamientos"),
        ),
        body: Container(
          color: Colors.white,
          alignment: Alignment.topCenter,
          child:ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ConfigurableExpansionTile(
                    header: Container(
                      alignment: Alignment.center,
                      height: 200,
                      color: Colors.transparent,
                      child: Center(
                        child: Card(
                          margin: EdgeInsets.only(top: 10),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                '${items[index].imageurl}',
                                filterQuality: FilterQuality.low,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                '${items[index].id}',
                                style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.deepPurple,
                                    fontStyle: FontStyle.italic),
                                textAlign: TextAlign.right,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    children: creartext("${items[index].id}")                   
                  );
                },
              
          ),
        ),
      ),
    );
  }

  List<Column> creartext(String id) {
    List<Column> childrenText = List<Column>();
    for (var name in sub) {
      if(name.tratamiento==id){
      childrenText.add(new Column(
        children: <Widget>[
          ListTile(
            leading: Container(
              child: Icon(Icons.arrow_drop_down, color: Colors.black),
            ),
            title: Text(name.nombre,
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            subtitle: Text("Precio: ${name.precio}",
                        style: TextStyle(color: Colors.black),
                      ),
            trailing: Text("Duracion:${name.duracion} min"),
            onTap: () => _navigateToNote(context, name),
          ),
       Divider(height: 1,) ],
      ),
      );}
      
    }
    return childrenText;
  }

  void _navigateToNote(BuildContext context, SubTratamientos note) async {
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
    setState(
      () {
        items[items.indexOf(oldNoteValue)] =
            new Tratamientos.fromSnapshot(event.snapshot);
      },
    );
  }

  void _onSubAdded(Event event) {
    setState(() {
      sub.add(new SubTratamientos.fromSnapshot(event.snapshot));
    });
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
