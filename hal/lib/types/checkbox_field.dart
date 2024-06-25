import 'package:flutter/material.dart';

class CheckboxField2 extends StatefulWidget {
  final bool? isChecked;
  final String title;
  final Function(bool?)? onChanged;

  CheckboxField2({
    required this.isChecked,
    required this.title,
    this.onChanged,
  });

  @override
  _CheckboxField2State createState() => _CheckboxField2State();
}

class _CheckboxField2State extends State<CheckboxField2> {
  bool? isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: isChecked,
      onChanged: (value) {
        setState(() {
          isChecked = value;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
    );
  }
}