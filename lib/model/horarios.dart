import 'package:firebase_database/firebase_database.dart';
class Horarios{
   String _id;
   String _dia;
   String _de;
   String _a;

 Horarios(this._id,this._dia,this._de,this._a);

 Horarios.map(dynamic obj) {
    this._id = obj['id'];
    this._dia = obj['dia'];
    this._de = obj['de'];
    this._a = obj['a'];
}
 
  String get id => _id;
  String get dia => _dia;
  String get de => _de;
  String get a => _a;
 
  Horarios.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _dia = snapshot.value['dia'];
    _de = snapshot.value['de'];
    _a = snapshot.value['a'];
  }
}
