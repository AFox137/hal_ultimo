import 'package:flutter/material.dart';
import 'package:hal/accounts.dart';
import 'package:hal/create_account.dart';
import 'package:hal/entity/DataBase.dart';
import 'package:hal/my_home_page.dart';
import 'package:hal/prueba/database_creator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HAL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      routes: {
        '/create_account': (context) => CreateAccount(title: 'Create Accounts'),
        '/accounts': (context) => AccountPage(title:'Accounts'),
        '/Data_Base': (context) => DataBase(title:'Base de datos'),
        '/create': (context) => DatabaseCreator(),
        //'/view': (context) => ViewDatabasesScreen(),
      },

      home: const MyHomePage(title: 'Hal'),
    );
  }
}

