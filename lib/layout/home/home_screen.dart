import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/module/archive_screen.dart';
import 'package:todo_list/module/done_tasks_screen.dart';
import 'package:todo_list/module/tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list/shared/components/component.dart';

import '../../shared/components/consts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> screens = [TasksScreen(), DoneTasksScreen(), ArchiveScreen()];
  int currentIndex = 0;
  List<String> appBarTiltle = [
    'Tasks',
    'Done Tasks',
    'Archive',
  ];
  late Database database;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<FormState> formdKey = GlobalKey();
  bool showSheetBar = false;
  var textController = TextEditingController();
  var stateController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();
  IconData icon = Icons.edit;


  @override
  void initState() {
    super.initState();
    onCreateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
          title: Text(appBarTiltle[currentIndex])),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (inex) {
          setState(() {
            currentIndex = inex;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.done_outline), label: 'Done Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.archive), label: 'Archive'),
        ],
        currentIndex: currentIndex,
      ),
        body: tasks.length == 0 ? Center(child: CircularProgressIndicator()) : screens[currentIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
      if (showSheetBar) {
        if (formdKey.currentState!.validate()) {
          insertToDataBase(
              textController.text,
              dateController.text,
              timeController.text
          ).then((value) {
            Navigator.pop(context);
            showSheetBar = false;
            setState(() {
              icon = Icons.edit;
            });
          });}
      } else {
        scaffoldKey.currentState!.showBottomSheet((context) =>
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Form(
                key: formdKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    defaultFormFeild(
                        controller: textController,
                        textInputType: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return ' Task must not be empty';
                          }
                          return null;
                        },
                        text: 'Task Title',
                        icon: Icons.title
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    defaultFormFeild(

                        onTap: () {
                          showTimePicker(context: context,
                              initialTime: TimeOfDay.now()).then((
                              value) {
                            timeController.text =
                                value!.format(context).toString();
                            print(value.format(context));
                          });
                        },
                        controller: timeController,
                        textInputType: TextInputType.datetime,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return ' Time must not be empty';
                          }
                          return null;
                        },
                        text: 'Task Time',
                        icon: Icons.watch_later_outlined
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    defaultFormFeild(
                        onTap: () {
                          showDatePicker(context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2055-12-30'),

                          ).then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                            print(DateFormat.yMMMd().format(value));
                          });
                        },
                        controller: dateController,
                        textInputType: TextInputType.datetime,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return ' Date must not be empty';
                          }
                          return null;
                        },
                        text: 'Task Date',
                        icon: Icons.calendar_month
                    ),
                  ],
                ),
              ),
            ),
            elevation: 30.0,
        ).closed.then((value) {
          showSheetBar = false;
          setState(() {
            icon = Icons.edit;
          });
        });
        showSheetBar = true;
        setState(() {
          icon = Icons.add;
        });
      }
    },
       child: Icon(icon),
      ),

    );

  }

  void onCreateDataBase() async {
    database = await openDatabase('todo.db', version: 1,
        onCreate: (database, version) async {
      print("databace created");
      await database.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, Task TEXT, Date TEXT, Note TEXT)');
      print("table created");
    }, onOpen: (database) {
      getDataFromDatabase(database).then((value) {
        tasks = value;
        print(tasks);
      });
      print("database Opened");
    });
  }

  Future insertToDataBase(
       title,
       date,
       note
    ) async {
    return await database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          'INSERT INTO Tasks(Task, Date, Note) VALUES("$title", "$date", "$note")');
      print('Inserted $id1');
    });
    // database.transaction((txn) {
    //   txn.rawInsert('INSERT INTO Tasks(Task, Date, Note) VALUES("first Task","12-5","done")').then((value){
    //     print('$value Inserted successfully');
    //   }).catchError((error){
    //     print('Error when inserting new record ${error.toString()}');
    //   });
    //   return null;
    // });
  }

  Future<List<Map>> getDataFromDatabase (database) async{
   return await database.rawQuery('SELECT * FROM Tasks');
  }
}
