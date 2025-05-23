import 'package:flutter/material.dart';
import 'package:flutter_todo_app/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
//init the hive
  await Hive.initFlutter();
//open a box
  await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.yellow),
    );
  
  }
}