import 'package:flutter/material.dart';
import 'package:hal/acounts/account_tile.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({super.key, required this.title});

  final String title;

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center( child: 
        Column(
          children: [
            AccountTile(),
            
          ],
        ),
      )
    );
      
      
    
  }
}