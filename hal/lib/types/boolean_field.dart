import 'package:flutter/material.dart';

class BooleanFieldWidget extends StatefulWidget {
  final Function(bool) onSave;
  final Function() onCancel;

  BooleanFieldWidget({
    required this.onSave,
    required this.onCancel,
  });

  @override
  _BooleanFieldWidgetState createState() => _BooleanFieldWidgetState();
}

class _BooleanFieldWidgetState extends State<BooleanFieldWidget> {
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SwitchListTile(
          title: Text('Booleano'),
          value: value,
          onChanged: (newValue) {
            setState(() {
              value = newValue;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: widget.onCancel,
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () => widget.onSave(value),
              child: Text("Guardar"),
            ),
          ],
        ),
      ],
    );
  }
}