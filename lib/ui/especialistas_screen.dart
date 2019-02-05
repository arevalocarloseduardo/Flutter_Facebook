import 'dart:async';
import 'dart:ui';
import 'package:bitstudio/model/especialistas.dart';
import 'package:bitstudio/model/subTratamientos.dart';
import 'package:bitstudio/ui/turnos_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:firebase_database/firebase_database.dart';

class EspecialistasScreen extends StatefulWidget {
  final SubTratamientos tratamientos;
  EspecialistasScreen(this.tratamientos);

  @override
  _EspecialistasScreenState createState() => _EspecialistasScreenState();
}
final especialistasReference = FirebaseDatabase.instance.reference().child('especialistas');

class _EspecialistasScreenState extends State<EspecialistasScreen> {
  List<SubTratamientos> tratamientos;
  List<Especialistas> listEspecialista;

  StreamSubscription<Event> _onEspecialistasAddedSubscription;
  StreamSubscription<Event> _onEspecialistasChangedSubscription;

  @override
  void initState() {
    super.initState();

    listEspecialista = new List();
    tratamientos = new List();
    _onEspecialistasAddedSubscription =
        especialistasReference.onChildAdded.listen(_onEspecialistasAdded);
    _onEspecialistasChangedSubscription =
        especialistasReference.onChildChanged.listen(_onEspecialistasUpdated);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.purple[600],
        centerTitle: true,
        title: Text("Selecciona Especialistas"),
      ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 350),
                  child: InkWell(
                    onTap: () => _navigateToEspecialistas(context, listEspecialista[index],widget.tratamientos),
                    child:Card(
                    clipBehavior: Clip.hardEdge,
                    elevation: 10,
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Image.network(
                      '${listEspecialista[index].fotoperfil}',
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                    ),
                  ),) 
                ),
                Center(
                  child: Text(
                    '${listEspecialista[index].nombre}',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 0.0),
                            blurRadius: 15.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ]),
                  ),
                ),
                
              ],
            ),
          );
        },
        control: SwiperControl(),
        loop: false,
        itemCount: listEspecialista.length,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }

  void _navigateToEspecialistas(
      BuildContext context, Especialistas espe, SubTratamientos note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TurnosScreen(espe, note)),
    );
  }

  void _onEspecialistasAdded(Event event) {
    setState(
      () {
        listEspecialista.add(new Especialistas.fromSnapshot(event.snapshot));
      },
    );
  }

  void _onEspecialistasUpdated(Event event) {
    var oldEspecialistasValue =
        listEspecialista.singleWhere((espe) => espe.id == event.snapshot.key);
    setState(
      () {
        listEspecialista[listEspecialista.indexOf(oldEspecialistasValue)] =
            new Especialistas.fromSnapshot(event.snapshot);
      },
    );
  }
}
