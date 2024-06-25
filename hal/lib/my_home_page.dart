import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: 
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed:() => Navigator.pushNamed(context, '/create_account'), child: Text('Crear Cuenta')),
              ElevatedButton(
                  onPressed:() => Navigator.pushNamed(context, '/accounts'), child: Text('Ver Cuentas')),
            ],
          ),
        )
      )
    );   
  }
}
