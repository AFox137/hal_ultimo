import 'package:flutter/material.dart';

class NumberFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSave;
  final Function() onCancel;

  NumberFieldWidget({
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
            hintText: "Número",
          ),
          keyboardType: TextInputType.number,
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
