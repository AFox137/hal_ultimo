import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hal/types/checkbox_field.dart';
import 'package:hal/types/text_field.dart'; // Actualiza la importación para que coincida con el nuevo nombre del archivo
import 'package:http/http.dart' as http;
import 'dart:developer';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key, required this.title});

  final String title;

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  dynamic _id;
  final _databaseNameController = TextEditingController();
  final _hostController = TextEditingController();
  final _nameController = TextEditingController();
  bool? _isCheck = true;
  bool? _active = true;
  
  void createUser() async {
    final url = Uri.parse("http://10.0.2.2:8000/user/");
 
    try {
      var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }, 
        body: jsonEncode(<String, dynamic>{ 
          'name': _nameController.text,
          'id_account': _id,
          'active': _active,
        })
      );
      if (response.statusCode == 200) {
        log('Datos enviados correctamente:');
        log(response.body);
        final resUser = jsonDecode(response.body);
        log(resUser.toString());
      } else {
        log('Error al enviar los datos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      log('Excepción al enviar los datos: $e');
    }
  } 
  
  void sendData() async {
    final url = Uri.parse("http://10.0.2.2:8000/account/");
    bool? active = _isCheck;
    final databaseName = _databaseNameController.text;
    final host = _hostController.text;
    final name = _nameController.text;

    try {
      var response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        }, 
        body: jsonEncode(<String, dynamic>{ 
          'active': active,
          'database_name': databaseName,
          'host': host,
          'name': name,
        })
      );
      if (response.statusCode == 200) {
        log('Datos enviados correctamente:');
        log(response.body);
        final res = jsonDecode(response.body);
        setState(() {
          _id = res['data'][0]['id'];
        });
        if (_active == true) {
          createUser();
        }
      } else {
        log('Error al enviar los datos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      log('Excepción al enviar los datos: $e');
    }
  } 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,  
        ),
        body: Center(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              TextFieldWidget(
                controller: _databaseNameController,
                onSave: (value) {},
                onCancel: () {},
              ),  
              TextFieldWidget(
                controller: _hostController,
                onSave: (value) {},
                onCancel: () {},
              ),          
              TextFieldWidget(
                controller: _nameController,
                onSave: (value) {},
                onCancel: () {},
              ), 
              CheckboxField2(
                isChecked: _isCheck,
                title: "Active",
              ),
              CheckboxField2(
                isChecked: _active,
                title: "Crear usuario",
              ),
              ElevatedButton(
                onPressed: sendData,
                child: Text('Crear'),
              ),
            ]
          ),
        ),
      )
    );
  }
}