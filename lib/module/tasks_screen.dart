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
        var tasks = AppCubit.get(context).newTasks;
        return tasks.length>0? ListView.separated(
          itemCount: AppCubit.get(context).newTasks.length,
          itemBuilder:(context , index)=> taskItemBuilder(AppCubit.get(context).newTasks[index],context) ,
          separatorBuilder: (context ,index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container( height: 2.0,
              color: Colors.blueGrey[100],),
          ),

        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Icon(Icons.menu,
              size: 100.0,
              color: Colors.grey,),
              Text('No Tasks Yet',style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey
              ),),
            ],
          ),
        );
      },
    );
}}
