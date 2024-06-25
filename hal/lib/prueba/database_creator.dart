import 'package:flutter/material.dart';
import 'package:hal/types/boolean_field.dart';
import 'package:hal/types/checkbox_field.dart';
import 'package:hal/types/date_field.dart';
import 'package:hal/types/number_field.dart';
import 'package:hal/types/text_field.dart';


enum FieldType { Text, Number, Boolean, Date }

class Field {
  FieldType type;
  String name;
  dynamic value;

  Field({
    required this.type,
    required this.name,
    this.value,
  });
}

class DatabaseCreator extends StatefulWidget {
  @override
  _DatabaseCreatorState createState() => _DatabaseCreatorState();
}

class _DatabaseCreatorState extends State<DatabaseCreator> {
  List<Field> fields = [];
  final TextEditingController _nameController = TextEditingController();
  FieldType? _selectedType;
  TextEditingController _fieldController = TextEditingController();
  int? _editingIndex;
  bool _showFieldTypeSelection = false;

  Widget _buildFieldForm() {
    switch (_selectedType) {
      case FieldType.Text:
        return TextFieldWidget(
          controller: _fieldController,
          onSave: (value) {
            setState(() {
              if (_editingIndex != null) {
                fields[_editingIndex!] = Field(type: _selectedType!, name: 'Text', value: value);
                _editingIndex = null;
              } else {
                fields.add(Field(type: _selectedType!, name: 'Text', value: value));
              }
              _selectedType = null;
              _fieldController.clear();
              _showFieldTypeSelection = false;
            });
          },
          onCancel: () {
            setState(() {
              _selectedType = null;
              _fieldController.clear();
              _showFieldTypeSelection = false;
            });
          },
        );
      case FieldType.Number:
        return NumberFieldWidget(
          controller: _fieldController,
          onSave: (value) {
            setState(() {
              if (_editingIndex != null) {
                fields[_editingIndex!] = Field(type: _selectedType!, name: 'Number', value: int.parse(value));
                _editingIndex = null;
              } else {
                fields.add(Field(type: _selectedType!, name: 'Number', value: int.parse(value)));
              }
              _selectedType = null;
              _fieldController.clear();
              _showFieldTypeSelection = false;
            });
          },
          onCancel: () {
            setState(() {
              _selectedType = null;
              _fieldController.clear();
              _showFieldTypeSelection = false;
            });
          },
        );
      case FieldType.Boolean:
        return BooleanFieldWidget(
          onSave: (value) {
            setState(() {
              if (_editingIndex != null) {
                fields[_editingIndex!] = Field(type: _selectedType!, name: 'Boolean', value: value);
                _editingIndex = null;
              } else {
                fields.add(Field(type: _selectedType!, name: 'Boolean', value: value));
              }
              _selectedType = null;
              _showFieldTypeSelection = false;
            });
          },
          onCancel: () {
            setState(() {
              _selectedType = null;
              _showFieldTypeSelection = false;
            });
          },
        );
      case FieldType.Date:
        return DateFieldWidget(
          onSave: (value) {
            setState(() {
              if (_editingIndex != null) {
                fields[_editingIndex!] = Field(type: _selectedType!, name: 'Date', value: value);
                _editingIndex = null;
              } else {
                fields.add(Field(type: _selectedType!, name: 'Date', value: value));
              }
              _selectedType = null;
              _showFieldTypeSelection = false;
            });
          },
          onCancel: () {
            setState(() {
              _selectedType = null;
              _showFieldTypeSelection = false;
            });
          },
        );
      default:
        return Container();
    }
  }

  void _addField() {
    setState(() {
      _showFieldTypeSelection = true;
    });
  }

  void _editField(int index) {
    setState(() {
      _selectedType = fields[index].type;
      _fieldController.text = fields[index].value.toString();
      _editingIndex = index;
      _showFieldTypeSelection = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Base de datos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 80,
                color: Colors.amberAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.stacked_line_chart),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: "Nombre de Base de datos",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.keyboard_control),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                color: Colors.blueGrey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      alignment: WrapAlignment.end,
                      children: [Text('Campos')],
                    ),
                    ElevatedButton(
                      onPressed: _addField,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Icon(Icons.add), Text("Agregar Campo")],
                      ),
                    ),
                    if (_showFieldTypeSelection) ...[
                      DropdownButton<FieldType>(
                        hint: Text("Seleccione tipo de campo"),
                        value: _selectedType,
                        onChanged: (FieldType? newValue) {
                          setState(() {
                            _selectedType = newValue;
                          });
                        },
                        items: FieldType.values.map((FieldType type) {
                          return DropdownMenuItem<FieldType>(
                            value: type,
                            child: Text(type.toString().split('.').last),
                          );
                        }).toList(),
                      ),
                      _buildFieldForm(),
                    ],
                    Expanded(
                      child: ListView.builder(
                        itemCount: fields.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${fields[index].name} (${fields[index].type.toString().split('.').last})'),
                            subtitle: Text('Valor: ${fields[index].value.toString()}'),
                            trailing: IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editField(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
