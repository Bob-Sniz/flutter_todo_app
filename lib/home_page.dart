import 'package:flutter/material.dart';
import 'package:flutter_todo_app/data/database.dart';
import 'package:flutter_todo_app/dialog_box.dart';
import 'package:flutter_todo_app/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  //reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();
  
  @override
  void initState() {
    // if this is the first time opening the app, then crete default data
    if (_myBox.get('TODOLIST') == null) {
      db.createInitialData();
    
    }
    else{
     //there already exist data
     db.loadData();
    }
    super.initState();
  }
  //text controller
  final _controller = TextEditingController();
  
  //checkbox
  void checkboxChanged(bool? value, int index){
    setState((){
      db.toDoList[index][1] = !db.toDoList[index][1];
    }
    );
    db.updateDtaBase();
  }
  //save new task
  void saveNewTask(){
    setState((){
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDtaBase();
  }
  //create a new task
  void createNewTask(){
    showDialog(
      context:context,
      builder: (context){
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }
  //delete task
  void deleteTask(int index){
    setState((){
      db.toDoList.removeAt(index);
    });
    db.updateDtaBase();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text('TO DO'),
        elevation: 0),
      floatingActionButton: FloatingActionButton(onPressed: createNewTask,
        child: Icon(Icons.add)
        ),

      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkboxChanged(value, index),
            deleteFunction: (p0) => deleteTask((index))
            );
        },
        ),
      );
  }

}
