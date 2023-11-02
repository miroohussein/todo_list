import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/shared/cubit/states.dart';
import '../../module/archive_screen.dart';
import '../../module/done_tasks_screen.dart';
import '../../module/tasks_screen.dart';
import '../components/consts.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<Widget> screens = [TasksScreen(), DoneTasksScreen(), ArchiveScreen()];

  int currentIndex = 0;

  List<String> appBarTiltle = [
    'Tasks',
    'Done Tasks',
    'Archive',
  ];

  bool showSheetBar = false;
  IconData icon = Icons.edit;
  late Database database;
  List<Map> tasks = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  void onCreateDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) async {
      print("databace created");
      await database.execute(
          'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, Task TEXT, Date TEXT, Note TEXT)');
      print("table created");
    }, onOpen: (database) {
      getDataFromDatabase(database).then((value) {
        tasks = value;
        print(tasks);
        emit(AppGetDatabaseState());
      });
      print("database Opened");
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

///////////////////////////////////////////////////////////////
  insertToDataBase({required title, required date, required note}) async {
    await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO Tasks(Task, Date, Note) VALUES("$title", "$date", "$note")')
          .then((value) {
        print('Inserted $value');
        emit(AppInsertToDatabaseState());
        getDataFromDatabase(database).then((value) {
          tasks = value;
          print(tasks);
          emit(AppGetDatabaseState());
        });
      }).catchError((error) {
        print('error while inserting ${error.toString()}');
      });
    });
  }

  // database.transaction((txn) {
  //   txn.rawInsert('INSERT INTO Tasks(Task, Date, Note) VALUES("first Task","12-5","done")').then((value){
  //     print('$value Inserted successfully');
  //   }).catchError((error){
  //     print('Error when inserting new record ${error.toString()}');
  //   });
  //   return null;
  // });
  Future<List<Map>> getDataFromDatabase(database) async {
    emit(AppGetDatabaseLoadingState());
    return await database.rawQuery('SELECT * FROM Tasks');
  }

  void changeBottomSheeStste(
      {required bool isShow, required IconData icondata}) {
    showSheetBar = isShow;
    icon = icondata;
    emit(AppChangeBottomSheetState());
  }
}
