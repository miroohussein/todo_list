import 'package:flutter/material.dart';
import 'package:todo_list/module/archive_screen.dart';
import 'package:todo_list/module/done_tasks_screen.dart';
import 'package:todo_list/module/tasks_screen.dart';
import 'package:sqflite/sqflite.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   List<Widget> screens =[
     TasksScreen(),
     DoneTasksScreen(),
     ArchiveScreen()
   ];
   int currentIndex=0;
   List<String> appBarTiltle =[
     'Tasks',
     'Done Tasks',
     'Archive',
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          appBarTiltle[currentIndex]
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (inex){
          setState(() {
            currentIndex = inex;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(
              Icons.menu
          ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
              icon: Icon(
              Icons.done_outline
          ),
              label: 'Done Tasks'
          ),
          BottomNavigationBarItem(
              icon: Icon(
              Icons.archive
          ),
              label: 'Archive'
          ),
        ],
        currentIndex: currentIndex ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      body: screens[currentIndex],
    );
  }
   void OnCreateDataBase() async {
    Database database = await openDatabase(
        'todo.db',
      version: 1,
      onCreate: (Database database, int version) async{
          await database.execute('CREATE TABLE Tasks (id INTEGER PRIMARY KEY, Task TEXT, Date TEXT, Note TEXT)');
      },
      onOpen: (database){
          print("databace Opened");
    }
    );
   }

}
