import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../main.dart';
import '../model/note_model.dart';
import '../repository/sql_helper.dart';
import 'show_note_view.dart';


class PageOne extends StatefulWidget {
  PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {


  SqlHelper sqlHelper = SqlHelper();

  List<NoteModel> allNotes = [];


  @override
  void didChangeDependencies() async {
    allNotes = await sqlHelper.getAllNotes();
    setState(() {});
    super.didChangeDependencies();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/addNote');
        },
        child: Icon(Icons.add,),
      ),
      appBar: AppBar(
        title: const Text('Notes',style: TextStyle(fontSize: 30,),),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch(),);
            },
          ),
        ],
      ),
      backgroundColor: Color(0xff232420),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: allNotes.isEmpty ?
              Center(
                child: SvgPicture.asset(
                  'images/undraw_add_notes_re_ln36.svg',
                  height: 300,
                  width: 300,
                ),
              )
                  :
              ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: allNotes.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowNoteView(note: allNotes[index],)));
                      },
                      child: Dismissible(
                        key: Key(allNotes[index].id.toString()),
                        onDismissed: (direction) async {
                          await sqlHelper.deleteData(allNotes[index]);
                          setState(() {
                            allNotes.removeAt(index);
                          });
                        },
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(Icons.delete,color: Colors.white,),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Icon(Icons.delete,color: Colors.white,),
                              ),
                            ],
                          ),
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: allNotes[index].color == 1 ? Colors.orangeAccent : allNotes[index].color == 2 ? Colors.deepPurpleAccent : allNotes[index].color == 3 ? Colors.pinkAccent : Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 3.0,
                                spreadRadius: 1.0,
                                offset: Offset(2.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    allNotes[index].title!,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(allNotes[index].note!.replaceAll('\n', '').length > 50 ? allNotes[index].note!.replaceAll('\n', '').substring(0, 50) + '...' : allNotes[index].note!.replaceAll('\n', ''),
                                    style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),),
                                ),
                              Container(
                                child: Text(
                                  allNotes[index].date!.substring(0, 10) + ' ' + allNotes[index].date!.substring(11, 16),
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                              ),

                            ],
                          ),


                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],

      ),
    );
  }
}


class DataSearch extends SearchDelegate{


  SqlHelper sqlHelper = SqlHelper();
  List<NoteModel> allNotes = [];

  DataSearch(){
    sqlHelper.getAllNotes().then((value) {
      allNotes = value;
    });
  }


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List filteredNotes = allNotes.where((element) => element.title!.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: query.isEmpty ? allNotes.length : filteredNotes.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowNoteView(note: query.isEmpty ? allNotes[index] : filteredNotes[index],)));
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: query.isEmpty ? allNotes[index].color == 1 ? Colors.orangeAccent : allNotes[index].color == 2 ? Colors.deepPurpleAccent : allNotes[index].color == 3 ? Colors.pinkAccent : Colors.lightBlueAccent : filteredNotes[index].color == 1 ? Colors.orangeAccent : filteredNotes[index].color == 2 ? Colors.deepPurpleAccent : filteredNotes[index].color == 3 ? Colors.pinkAccent : Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 3.0,
                  spreadRadius: 1.0,
                  offset: Offset(2.0, 2.0), // shadow direction: bottom right
                )
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    query.isEmpty ? allNotes[index].title! : filteredNotes[index].title!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    query.isEmpty ? allNotes[index].note!.replaceAll('\n', '').length > 50 ? allNotes[index].note!.replaceAll('\n', '').substring(0, 50) + '...' : allNotes[index].note!.replaceAll('\n', '') : filteredNotes[index].note!.replaceAll('\n', '').length > 50 ? filteredNotes[index].note!.replaceAll('\n', '').substring(0, 50) + '...' : filteredNotes[index].note!.replaceAll('\n', ''),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),),
                ),
                Container(
                  child: Text(
                    query.isEmpty ? allNotes[index].date! : filteredNotes[index].date!,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 12,
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

}