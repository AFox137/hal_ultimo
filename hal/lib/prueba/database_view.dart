import 'package:flutter/material.dart';
import 'package:hal/prueba/models.dart';

class DatabaseView extends StatefulWidget {
  final List<Field> fields;

  DatabaseView({required this.fields});

  @override
  _DatabaseViewState createState() => _DatabaseViewState();
}

class _DatabaseViewState extends State<DatabaseView> {
  List<Record> records = [];

  void _addRecord() {
    Map<String, dynamic> newData = {};
    for (var field in widget.fields) {
      if (field.type == FieldType.Text) {
        newData[field.name] = '';
      } else if (field.type == FieldType.Number) {
        newData[field.name] = 0;
      } else if (field.type == FieldType.Boolean) {
        newData[field.name] = false;
      }
    }
    setState(() {
      records.add(Record(data: newData));
    });
  }

  void _editRecord(int index, String fieldName, dynamic newValue) {
    setState(() {
      records[index].data[fieldName] = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Database')),
      body: Column(
        children: [
          ElevatedButton(onPressed: _addRecord, child: Text('Add Record')),
          Expanded(
            child: ListView.builder(
              itemCount: records.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Column(
                      children: widget.fields.map((field) {
                        return Row(
                          children: [
                            Text('${field.name}: '),
                            if (field.type == FieldType.Text)
                              Expanded(
                                child: TextField(
                                  onChanged: (value) =>
                                      _editRecord(index, field.name, value),
                                  controller: TextEditingController(
                                    text: records[index].data[field.name],
                                  ),
                                ),
                              ),
                            if (field.type == FieldType.Number)
                              Expanded(
                                child: TextField(
                                  onChanged: (value) =>
                                      _editRecord(index, field.name, int.tryParse(value) ?? 0),
                                  controller: TextEditingController(
                                    text: records[index].data[field.name].toString(),
                                  ),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            if (field.type == FieldType.Boolean)
                              Switch(
                                value: records[index].data[field.name],
                                onChanged: (value) =>
                                    _editRecord(index, field.name, value),
                              ),
                          ],
                        );
                      }).toList(),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          records.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
