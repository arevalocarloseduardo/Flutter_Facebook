import 'package:firebase_database/firebase_database.dart';
 
class Especialistas {
  String _id;
  String _nombre;
  String _fotoperfil;
  String _correo;
  String _direccion;
  String _edad;
  String _telefono;

 
  Especialistas(this._id, this._nombre, this._fotoperfil, this._correo, this._edad, this._telefono, this._direccion);
 
  Especialistas.map(dynamic obj) {
    this._id = obj['id'];
    this._nombre = obj['nombre'];
    this._fotoperfil = obj['fotoperfil'];
    this._correo = obj['correo'];
    this._direccion = obj['direccion'];
    this._edad = obj['edad'];
    this._telefono = obj['telefono'];
  }
 
  String get id => _id;
  String get nombre => _nombre;
  String get fotoperfil => _fotoperfil;
  String get correo => _correo;
  String get direccion => _direccion;
  String get edad => _edad;
  String get telefono => _telefono;
 
  Especialistas.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _nombre= snapshot.value['nombre'];
    _fotoperfil = snapshot.value['fotoperfil'];
    _correo= snapshot.value['correo'];
    _direccion = snapshot.value['direccion'];
    _edad= snapshot.value['edad'];
    _telefono = snapshot.value['telefono'];

  }
}