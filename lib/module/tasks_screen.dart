import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/shared/components/component.dart';
import 'package:todo_list/shared/components/consts.dart';
import 'package:todo_list/shared/cubit/cubit.dart';
import 'package:todo_list/shared/cubit/states.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener:(builder , state){} ,
      builder: (builder , state){
        return ListView.separated(
          itemCount: AppCubit.get(context).tasks.length,
          itemBuilder:(context , index)=> taskItemBuilder(AppCubit.get(context).tasks[index]) ,
          separatorBuilder: (context ,index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container( height: 2.0,
              color: Colors.blueGrey[100],),
          ),

        );
      },
    );
}}
