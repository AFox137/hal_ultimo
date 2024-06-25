class Field {
  String name;
  FieldType type;

  Field({required this.name, required this.type});
}

enum FieldType { Text, Number, Boolean }

class Record {
  Map<String, dynamic> data;

  Record({required this.data});
}


