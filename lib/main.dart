import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/add_note_view.dart';
import 'views/page_one.dart';
import 'views/show_note_view.dart';





void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData.dark(),
      home: PageOne(),
      routes: {
        '/addNote': (context) => AddItemView(),
        '/pageOne': (context) => PageOne(),
      },
    );
  }
}

