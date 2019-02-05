import 'package:bitstudio/model/especialistas.dart';
import 'package:bitstudio/model/tratamientos.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class ConfirmacionScreen extends StatefulWidget {
  final Especialistas especialistas;
  final Tratamientos tratamientos;
  final String hora;
  final String dia;
  ConfirmacionScreen(this.especialistas, this.tratamientos,this.hora,this.dia);
  @override
  _ConfirmacionScreenState createState() => _ConfirmacionScreenState();
}
final turnosReference = FirebaseDatabase.instance.reference().child('turnos');

class _ConfirmacionScreenState extends State<ConfirmacionScreen> {

  String accountStatus = '******';
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;


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
                    child:Icon(Icons.perm_identity) 
                  ),
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
                        image: NetworkImage(
                            "${widget.especialistas.fotoperfil}"),
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
                    widget.tratamientos.title,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),                
                ],
              ),
              Divider(height: 25,
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
              Divider(height: 25,
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
              Divider(height: 25,
                color: Colors.white,
              ),
              
            
            RaisedButton.icon(
              color: Colors.purple[200],
              onPressed: (){
                 turnosReference.push()
                  .set({
                    'cliente': "$accountStatus",
                    'especialista': "${widget.especialistas.id}",
                    'fecha': "${widget.dia}",
                    'hora': "${widget.hora}",
                    'tratamiento': "${widget.tratamientos.title}"
                  }).then((_) {
                    Navigator.pop(context);
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
              
              
