import 'package:flutter/material.dart';

import '../model/note_model.dart';
import '../repository/sql_helper.dart';

class ShowNoteView extends StatefulWidget {
  NoteModel note;
  ShowNoteView({Key? key, required this.note}) : super(key: key);


  @override
  State<ShowNoteView> createState() => _ShowNoteViewState();
}

class _ShowNoteViewState extends State<ShowNoteView> {

  SqlHelper sqlHelper = SqlHelper();
  final _formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff232420),
      appBar: AppBar(
        title: const Text('Note',style: TextStyle(fontSize: 30,),),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/pageOne');
          },
          icon: const Icon(Icons.arrow_back,),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.note.title,
                  cursorColor: Colors.greenAccent,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  onSaved: (value) {
                    widget.note.title = value!;
                  },
                ),
                const SizedBox(height: 10),
                // edit note text field
                TextFormField(
                  initialValue: widget.note.note,
                  cursorColor: Colors.greenAccent,
                  decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Note',
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 20),
                  maxLines: 10,
                  onSaved: (value) {
                    widget.note.note = value!;
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Color',style: TextStyle(color: Colors.grey),),
                    Radio(
                      value: 1,
                      groupValue: widget.note.color,
                      onChanged: (value) {
                        setState(() {
                          widget.note.color = 1;
                        });
                      },
                      hoverColor: Colors.orangeAccent,
                      activeColor: Colors.orangeAccent,
                      fillColor: MaterialStateProperty.all(Colors.orangeAccent),
                    ),
                    Radio(
                      value: 2,
                      groupValue: widget.note.color,
                      onChanged: (value) {
                        setState(() {
                          widget.note.color = 2;
                        });
                      },
                      hoverColor: Colors.deepPurpleAccent,
                      activeColor: Colors.deepPurpleAccent,
                      fillColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                    ),
                    Radio(
                      value: 3,
                      groupValue: widget.note.color,
                      onChanged: (value) {
                        setState(() {
                          widget.note.color = 3;
                        });
                      },
                      hoverColor: Colors.pinkAccent,
                      activeColor: Colors.pinkAccent,
                      fillColor: MaterialStateProperty.all(Colors.pinkAccent),
                    ),
                    Radio(
                      value: 4,
                      groupValue: widget.note.color,
                      onChanged: (value) {
                        setState(() {
                          widget.note.color = 4;
                        });
                      },
                      hoverColor: Colors.lightBlueAccent,
                      activeColor: Colors.lightBlueAccent,
                      fillColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  onPressed:  () async {
                    _formKey.currentState!.save();
                    widget.note.title == '' ? widget.note.title = 'Untitled' : widget.note.title = widget.note.title;
                    widget.note.note == '' ? widget.note.note = 'No note' : widget.note.note = widget.note.note;
                    NoteModel note = NoteModel(
                      id: widget.note.id,
                      title: widget.note.title,
                      note: widget.note.note,
                      date: DateTime.now().toString(),
                      color: widget.note.color,
                    );
                    await sqlHelper.updateData(note);
                    Navigator.pushReplacementNamed(context, '/pageOne');
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
