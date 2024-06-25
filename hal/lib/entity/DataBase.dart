import 'package:flutter/material.dart';
import 'package:hal/prueba/database_creator.dart';

class DataBase extends StatefulWidget {
  DataBase({super.key, required this.title});

  final String title;

  @override
  State<DataBase> createState() => _DataBaseState();
}


class _DataBaseState extends State<DataBase> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Database Creator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
        body: SafeArea(child: 
          Center(child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () => Navigator.pushNamed(context,'/create'), child: Text("crear base de datos"),),
                ElevatedButton(onPressed: () => Navigator.pushNamed(context,'/create'), child: Text("ver bases de datos"),),
              ],
            )
          )
        ),
      ),
    );
  }
}