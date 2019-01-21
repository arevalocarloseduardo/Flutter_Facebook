import 'package:flutter/material.dart';//importacion de libreria principal
import 'package:firebase_database/firebase_database.dart'; //libreria de la base de datos
import 'package:bitstudio/model/note.dart';//importo la clase note
 
class NoteScreen extends StatefulWidget {
  final Note note;
  NoteScreen(this.note);
 
  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}
 //declaro la referencia de la base de datos a leer
final notesReference = FirebaseDatabase.instance.reference().child('notes');
 
class _NoteScreenState extends State<NoteScreen> {
//declaro varianbles de los edittext
  TextEditingController _titleController;
  TextEditingController _descriptionController;
 
  @override
  void initState() {
    super.initState();
     
    _titleController = new TextEditingController(text: widget.note.title);
    _descriptionController = new TextEditingController(text: widget.note.description);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notas')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              enabled: true,
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titulo'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripcion'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.note.id != null) ? Text('actualizar') : Text('agregar'),
              onPressed: () {
                if (widget.note.id != null) {
                  notesReference.child(widget.note.id)
                  .set({
                    'title': _titleController.text,
                    'description': _descriptionController.text
                  }).then((_) {
                    Navigator.pop(context);
                  });
                } else {
                  notesReference.push()
                  .set({
                    'title': _titleController.text,
                    'description': _descriptionController.text
                  }).then((_) {
                    Navigator.pop(context);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}