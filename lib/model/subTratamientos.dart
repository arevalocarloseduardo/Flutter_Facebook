import 'package:firebase_database/firebase_database.dart';
 
class SubTratamientos {
  String _id;
  String _nombre;
  String _precio;
  String _duracion; 
  String _tratamiento; 
  SubTratamientos(this._id, this._nombre, this._precio,this._duracion,this._tratamiento);
 
  SubTratamientos.map(dynamic obj) {
    this._id = obj['id'];
    this._nombre = obj['nombre'];
    this._precio = obj['precio'];
    this._duracion= obj['duracion'];
    this._tratamiento= obj['tratamiento'];
  }
 
  String get id => _id;
  String get nombre => _nombre;
  String get precio => _precio;
  String get duracion =>_duracion;
  String get tratamiento =>_tratamiento;
 
  SubTratamientos.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _nombre = snapshot.value['nombre'];
    _precio = snapshot.value['precio'];
    _duracion = snapshot.value['duracion'];
    _tratamiento = snapshot.value['tratamiento'];
  }
}