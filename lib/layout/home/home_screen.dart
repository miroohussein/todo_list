import 'package:flutter/material.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Text(
          'Todo List'
        )),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
              Icons.menu
          ),
            label: 'Tasks'
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
        currentIndex: ,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(Icons.add),
      ),
    );
  }
}
