import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/module/archive_screen.dart';
import 'package:todo_list/module/done_tasks_screen.dart';
import 'package:todo_list/module/tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list/shared/components/component.dart';
import 'package:todo_list/shared/cubit/cubit.dart';
import 'package:todo_list/shared/cubit/states.dart';

import '../../shared/components/consts.dart';

class HomeScreen extends StatelessWidget {


  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  GlobalKey<FormState> formdKey = GlobalKey();


  var textController = TextEditingController();
  var stateController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=> AppCubit()..onCreateDataBase() ,// to deal with as it an object,
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (BuildContext context , state){
          if(state is AppInsertToDatabaseState){
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context , state){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
                title: Text(cubit.appBarTiltle[cubit.currentIndex])),
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
              cubit.changeIndex(index);
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
              currentIndex: cubit.currentIndex,
            ),
            body: (state is AppGetDatabaseLoadingState)
                ? Center(child: CircularProgressIndicator())
                : cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.showSheetBar) {
                  if (formdKey.currentState!.validate()) {
                    cubit.insertToDataBase(
                       title: textController.text,
                      date:  dateController.text,
                      note:  timeController.text
                    ).then((value) {
                      cubit.changeBottomSheeStste(isShow: false, icondata: Icons.edit);
                      //showSheetBar = false;
                      // setState(() {
                      //   icon = Icons.edit;
                      // });
                    });
                  }
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
                                        initialTime: TimeOfDay.now()).then((value) {
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
                    cubit.changeBottomSheeStste(isShow: false, icondata: Icons.edit);                   // showSheetBar = false;
                    // setState(() {
                    //   icon = Icons.edit;
                    // });
                  });
                  cubit.changeBottomSheeStste(isShow: true, icondata: Icons.add);
                  //showSheetBar = true;
                  // setState(() {
                  //   icon = Icons.add;
                  // });
                }
              },
              child: Icon(cubit.icon),
            ),

          );
        },
      ),
    );
  }


 }

