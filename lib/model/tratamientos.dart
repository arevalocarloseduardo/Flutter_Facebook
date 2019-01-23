import 'package:firebase_database/firebase_database.dart';
 
class Tratamientos {
  String _id;
  String _title;
  String _imageurl;
 
  Tratamientos(this._id, this._title, this._imageurl);
 
  Tratamientos.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._imageurl = obj['imageurl'];
  }
 
  String get id => _id;
  String get title => _title;
  String get imageurl => _imageurl;
 
  Tratamientos.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _imageurl = snapshot.value['imageurl'];
  }
}