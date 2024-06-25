import 'package:flutter/material.dart';

class DateFieldWidget extends StatefulWidget {
  final Function(DateTime) onSave;
  final Function() onCancel;

  DateFieldWidget({
    required this.onSave,
    required this.onCancel,
  });

  @override
  _DateFieldWidgetState createState() => _DateFieldWidgetState();
}

class _DateFieldWidgetState extends State<DateFieldWidget> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Fecha: ${selectedDate.toLocal()}'.split(' ')[0]),
            Spacer(),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Seleccionar fecha'),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: widget.onCancel,
              child: Text("Cancelar"),
            ),
            ElevatedButton(
              onPressed: () => widget.onSave(selectedDate),
              child: Text("Guardar"),
            ),
          ],
        ),
      ],
    );
  }
}