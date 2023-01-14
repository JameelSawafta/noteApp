import 'package:flutter/material.dart';
import 'package:noteapp/model/note_model.dart';
import '../repository/sql_helper.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({Key? key}) : super(key: key);

  @override
  State<AddItemView> createState() => _AddItemViewState();
}



class _AddItemViewState extends State<AddItemView> {

  SqlHelper sqlHelper = SqlHelper();

  late TextEditingController titleController ;
  late TextEditingController noteController ;

  bool isTitleEnabled = false;
  bool isNoteEnabled = false;

  @override
  void initState() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    noteController.addListener(() {
      setState(() {
        isNoteEnabled = noteController.text.isNotEmpty;
      });
    });
    titleController.addListener(() {
      setState(() {
        isTitleEnabled = titleController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  var radioValue = 1;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff232420),
      appBar: AppBar(
        title: const Text('Add Note',style: TextStyle(fontSize: 30,),),
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              cursorColor: Colors.greenAccent,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                label: Text('Title'),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: noteController,
              cursorColor: Colors.greenAccent,
              maxLines: 5,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                label: Text('Note'),
                hintText: 'Enter a note',
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
             const SizedBox(height: 20),
            // radio buttons for color
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('Color',style: TextStyle(color: Colors.grey),),
                Radio(
                  value: 1,
                  groupValue: radioValue,
                  onChanged: (value) {
                    setState(() {
                      radioValue = 1;
                    });
                  },
                  hoverColor: Colors.orangeAccent,
                  activeColor: Colors.orangeAccent,
                  fillColor: MaterialStateProperty.all(Colors.orangeAccent),
                ),
                Radio(
                  value: 2,
                  groupValue: radioValue,
                  onChanged: (value) {
                    setState(() {
                      radioValue = 2;
                    });
                  },
                  hoverColor: Colors.deepPurpleAccent,
                  activeColor: Colors.deepPurpleAccent,
                  fillColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                ),
                Radio(
                  value: 3,
                  groupValue: radioValue,
                  onChanged: (value) {
                    setState(() {
                      radioValue = 3;
                    });
                  },
                  hoverColor: Colors.pinkAccent,
                  activeColor: Colors.pinkAccent,
                  fillColor: MaterialStateProperty.all(Colors.pinkAccent),
                ),
                Radio(
                  value: 4,
                  groupValue: radioValue,
                  onChanged: (value) {
                    setState(() {
                      radioValue = 4;
                    });
                  },
                  hoverColor: Colors.lightBlueAccent,
                  activeColor: Colors.lightBlueAccent,
                  fillColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              onPressed: isNoteEnabled && isTitleEnabled  ?  () {
                sqlHelper.insertNote(NoteModel(title: titleController.text.toString(),note: noteController.text.toString(),date: DateTime.now().toString(),color: radioValue));
                titleController.text = '';
                noteController.text = '';
                setState(() {
                  isNoteEnabled = false;
                  isTitleEnabled = false;
                });
                titleController.clear();
                noteController.clear();

                Navigator.pushReplacementNamed(context, '/pageOne');
                }
                : null,
              child: const Text('Add Note'),
            ),
            
          ],
        ),
      ),
    );
  }
}
