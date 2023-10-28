import 'package:flutter/material.dart';
import 'package:todo_list/shared/components/component.dart';
import 'package:todo_list/shared/components/consts.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder:(context , index)=> taskItemBuilder(tasks[index]) ,
      separatorBuilder: (context ,index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container( height: 2.0,
        color: Colors.blueGrey[200],),
      ),

    );
}}
