import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class AccountTile extends StatefulWidget {
  const AccountTile({super.key});

  @override
  State<AccountTile> createState() => _AccountTileState();
}

class _AccountTileState extends State<AccountTile> {
  List accounts = [];
  List user = [];
  bool isLoading = true; 

  @override
  void initState() {
    super.initState();
    getData().then((_) => getUser()).then((_) {
      setState(() {
        isLoading = false; 
      });
    });
  }

  Future<void> getData() async {
    final url = Uri.parse("http://10.0.2.2:8000/account/");
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        log('Datos de cuenta recibidos correctamente:');
        var jsonResponse = json.decode(response.body);
        setState(() {
          accounts = jsonResponse['data'];
        });
      } else {
        log('Error al enviar los datos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      log('Excepción al enviar los datos: ${e}');
    }
  }

  Future<void> getUser() async {
    final urlUser = Uri.parse("http://10.0.2.2:8000/user/");
    try {
      var response = await http.get(urlUser);
      if (response.statusCode == 200) {
        log('Datos de usuario recibidos correctamente:');
        var jsonResponse = json.decode(response.body);
        setState(() {
          user = jsonResponse['data'];
        });
      } else {
        log('Error al enviar los datos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      log('Excepción al enviar los datos: ${e}');
    }
  }

  dynamic lenList(String idAccount) {
    dynamic cant = user[0].where((x) => x['id_account'] == idAccount).toList();
    print(cant);
    return cant;
  }

 @override
  Widget build(BuildContext context) {
    String id_account;

    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(), // Muestra un indicador de carga mientras se obtienen los datos
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: accounts[0].length,
        itemBuilder: (context, index1) {
          id_account = accounts[0][index1]['id'];
          dynamic list = lenList(id_account);
          return Card(
              child: ExpansionTile(
            title: Text("${accounts[0][index1]['name']}"),
            subtitle: Text('activate: ${accounts[0][index1]['active']}'),
            leading: Icon(Icons.house),
            trailing: Icon(Icons.arrow_drop_down),
            children: [
              Container(
                height: 150,
                child: ListView.builder(
                  itemCount: (lenList(id_account).length),
                  itemBuilder: (context, index2) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            Column(
                              children: [
                                Card(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Flex(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        direction: Axis.horizontal,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Container(
                                            child: Icon(
                                            Icons.person,
                                            size: 40,
                                          )),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(list[index2]['name']),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text('Active: '),
                                                  Text(list[index2]['active']
                                                      ? 'true'
                                                      : 'false'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.pushNamed(
                                                          context, '/Data_Base'),
                                                  child: Text("Ingresar"))
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.edit)),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(Icons.delete)),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              ElevatedButton(
                  onPressed: () => {}, child: Text("agregar Usuario"))
            ],
          ));
        },
      ),
    );
  }
}
