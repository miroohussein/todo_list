import 'package:flutter/material.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: MaterialButton(
          onPressed: () async {
            var name = await getName();
            print(name);
          },
          color: Colors.blue,
          child: Text('Click Here To get The Name'),
        ),
      ),
    );
  }

  Future<String> getName() async{
    return" Marwa hussein";
  }
}
