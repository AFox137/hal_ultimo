import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSave;
  final Function() onCancel;

  TextFieldWidget({
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Texto",
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onCancel,
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () => onSave(controller.text),
              child: Text("Guardar"),
            ),
          ],
        ),
      ],
    );
  }
}
