import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/components/component.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class DoneTasksScreen extends StatefulWidget {
  const DoneTasksScreen({super.key});

  @override
  State<DoneTasksScreen> createState() => _DoneTasksScreenState();
}

class _DoneTasksScreenState extends State<DoneTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener:(builder , state){} ,
      builder: (builder , state){
        var tasks = AppCubit.get(context).doneTasks;
        return tasks.length>0? ListView.separated(
          itemCount: AppCubit.get(context).doneTasks.length,
          itemBuilder:(context , index)=> taskItemBuilder(AppCubit.get(context).doneTasks[index],context) ,
          separatorBuilder: (context ,index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Container( height: 2.0,
              color: Colors.blueGrey[100],),
          ),

        ):
        Center(
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
        ),);
      },
    );
  }
}
