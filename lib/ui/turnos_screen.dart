import 'package:bitstudio/model/especialistas.dart';
import 'package:bitstudio/model/horarios.dart';
import 'package:bitstudio/model/subTratamientos.dart';
import 'package:bitstudio/model/tratamientos.dart';
import 'package:bitstudio/model/turnos.dart';
import 'package:bitstudio/ui/confirmacion_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TurnosScreen extends StatefulWidget {
  final Especialistas especialistas;
  final SubTratamientos tratamientos;
  TurnosScreen(this.especialistas, this.tratamientos);

  @override
  _TurnosScreenState createState() => _TurnosScreenState();
}

final turnosReference = FirebaseDatabase.instance.reference().child('turnos');
final horariosReference =
    FirebaseDatabase.instance.reference().child('horarios');

class _TurnosScreenState extends State<TurnosScreen> {
  List<Turnos> turnos;
  List<Horarios> horarios;

  DateTime _selectedDay;
  StreamSubscription<Event> _onTurnosAddedSubscription;
  StreamSubscription<Event> _onTurnosChangedSubscription;
  StreamSubscription<Event> _onHorariosAddedSubscription;
  StreamSubscription<Event> _onHorariosChangedSubscription;

  var horaTurnos = [];
  var hora = [];
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

  int anio;
  int mes;
  int dia;
  int diaSemana;
  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;

  String fechaSeleccionada =
      "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";

  @override
  void initState() {
    super.initState();

    _auth = FirebaseAuth.instance;

    getCurrentUser() async {
      mCurrentUser = await _auth.currentUser();

      setState(() {
        mCurrentUser != null
            ? accountStatus = '${mCurrentUser.uid}'
            : 'no hay usuario';
      });
    }

    print("antes del user${getCurrentUser()}");

    horarios = new List();
    turnos = new List();
    hora = new List();
    anio = DateTime.now().year;
    mes = DateTime.now().month;
    dia = DateTime.now().day;
    diaSemana = DateTime.now().weekday;
    

    _onHorariosAddedSubscription = horariosReference
        .orderByChild("dia")
        .equalTo("${diaSemana}")
        .onChildAdded
        .listen(_onHorariosAdded);
    _onHorariosChangedSubscription =
        horariosReference.onChildChanged.listen(_onHorariosUpdated);

    _onTurnosAddedSubscription = turnosReference
        .orderByChild("fecha")
        .equalTo("$dia-$mes-$anio")
        .onChildAdded
        .listen(_onTurnosAdded);
    _onTurnosChangedSubscription =
        turnosReference.onChildChanged.listen(_onTurnosUpdated);
  }

  set selectedTime(DateTime time) {
    setState(() {
      _selectedDay = time;
      print("$_selectedDay");
    });
  }

  void handleNewDate(date, diaC, mesC, anioC) {
    setState(() {
      hora.clear();
      horarios.clear();
      turnos.clear();
      horaTurnos.clear();

      fechaSeleccionada = "$diaC-$mesC-$anioC";
      _onTurnosAddedSubscription = turnosReference
          .orderByChild("fecha")
          .equalTo("$diaC-$mesC-$anioC")
          .onChildAdded
          .listen(_onTurnosAdded);
      _onHorariosAddedSubscription = horariosReference
          .orderByChild("dia")
          .equalTo("${date}")
          .onChildAdded
          .listen(_onHorariosAdded);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[600],
        centerTitle: true,
        title: Text("Horarios disponible"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Calendar(
              isExpandable: true,
              onDateSelected: (date) =>
                  handleNewDate(date.weekday, date.day, date.month, date.year),
            ),
            new Divider(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: hora.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                        border: new Border(
                          right:
                              new BorderSide(width: 1.0, color: Colors.black),
                        ),
                      ),
                      child: Icon(Icons.access_time, color: Colors.black),
                    ),
                    title: Text("${hora[i]}"),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.linear_scale, color: Colors.black),
                        Text(
                          " Disponible",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.black, size: 30.0),
                    onTap: () {
                      _navigateToNote(context, widget.tratamientos, widget.especialistas,hora[i],fechaSeleccionada);
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

/*

  turnosReference.push()
                  .set({
                    'cliente': "${accountStatus}",
                    'especialista': "${widget.especialistas.id}",
                    'fecha': "${fechaSeleccionada}",
                    'hora': "${hora[i]}",
                    'tratamiento': "${widget.tratamientos.title}"
                  }).then((_) {
                    Navigator.pop(context);
                  });

                  
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
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: CalendarCarousel(
              selectedDateTime: _selectedDay,
              onDayPressed: (DateTime time, List event) {
                selectedTime = time;
              }),
        )
        )
      ],
    )
    );
  }*/
  void _onHorariosAdded(Event event) {
    setState(() {
      horarios.add(new Horarios.fromSnapshot(event.snapshot));
    });

    imprimirListaHorarios(hora, horarios, p1);

    borrarTurnosReservados(horaTurnos, hora);
  }

  void _onHorariosUpdated(Event event) {
    var oldNoteValue =
        horarios.singleWhere((note) => note.id == event.snapshot.key);
    setState(
      () {
        horarios[horarios.indexOf(oldNoteValue)] =
            new Horarios.fromSnapshot(event.snapshot);
      },
    );
  }

  void _onTurnosAdded(Event event) {
    setState(() {
      //se añaden todos los turnos de la BD
      turnos.add(new Turnos.fromSnapshot(event.snapshot));
    });
    horaTurnos.clear();
    //Se guardan Solo los turnos de los especialistas seleccionado
    for (var i = 0; i < turnos.length; i++) {
      if (turnos[i].especialista == widget.especialistas.id) {
        //se añade a los turnos la hora
        horaTurnos.add("${turnos[i].hora}");
      }
    }
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
void _navigateToNote(BuildContext context, SubTratamientos note,Especialistas espe,hora,String dia) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfirmacionScreen(espe,note,hora,dia)),
    );
  }

void borrarTurnosReservados(List horaTurnos, List hora) {
  for (var x = 0; x < horaTurnos.length; x++) {
    for (var z = 0; z < hora.length; z++) {
      if (horaTurnos[x] == hora[z]) {
        hora.removeAt(z);
      }
    }
  }
}

void imprimirListaHorarios(
    List hora, List<Horarios> horarios, List<String> p1) {
  hora.clear();
  for (var i = 0; i < horarios.length; i++) {
    var indexA = p1.indexOf(horarios[i].a);
    var indexDe = p1.indexOf(horarios[i].de);
    for (var e = indexDe; e < indexA; e++) {
      hora.add("${p1[e]}");
    }
  }
}
