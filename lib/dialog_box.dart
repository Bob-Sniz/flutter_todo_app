import 'package:flutter/material.dart';
import 'package:flutter_todo_app/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final dynamic controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content:SizedBox(
        height: 120,
        child: Column(children:[
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add a new task"
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //save button
                  MyButton(text: 'Save', onPressed: onSave),
                  const SizedBox(width:8),
                  //cancel button
                  MyButton(text:'Cancel', onPressed: onCancel)
                ],
              ),
                ])
      )
    );
  }
}