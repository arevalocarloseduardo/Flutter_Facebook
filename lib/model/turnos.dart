import 'package:firebase_database/firebase_database.dart';

class Turnos {
  String _id;
  String _cliente;
  String _especialista;
  String _fecha;
  String _hora;
  String _tratamiento;

  Turnos(this._id, this._cliente, this._especialista, this._fecha,
      this._hora, this._tratamiento);

  Turnos.map(dynamic obj) {
    this._id = obj['id'];
    this._cliente = obj['cliente'];
    this._especialista = obj['especialista'];
    this._fecha = obj['fecha'];
    this._hora = obj['hora'];
    this._tratamiento = obj['tratamiento'];
  }

  String get id => _id;
  String get cliente => _cliente;
  String get especialista => _especialista;
  String get fecha => _fecha;
  String get hora => _hora;
  String get tratamiento => _tratamiento;

  Turnos.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _cliente = snapshot.value['cliente'];
    _especialista = snapshot.value['especialista'];
    _fecha = snapshot.value['fecha'];
    _hora = snapshot.value['hora'];
    _tratamiento = snapshot.value['tratamiento'];
  }
}
