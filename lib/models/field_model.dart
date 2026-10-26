import 'dart:convert';

Field1Model field1ModelFromJson(String str) => Field1Model.fromJson(json.decode(str));

String field1ModelToJson(Field1Model data) => json.encode(data.toJson());

class Field1Model {
    final DateTime createdAt;
    final int entryId;
    final String field1;

    Field1Model({
        required this.createdAt,
        required this.entryId,
        required this.field1,
    });

    factory Field1Model.fromJson(Map<String, dynamic> json) => Field1Model(
        createdAt: DateTime.parse(json["created_at"]),
        entryId: json["entry_id"],
        field1: json["field1"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "entry_id": entryId,
        "field1": field1,
    };
}

Field2Model field2ModelFromJson(String str) => Field2Model.fromJson(json.decode(str));

String field2ModelToJson(Field2Model data) => json.encode(data.toJson());

class Field2Model {
    final DateTime createdAt;
    final int entryId;
    final String field2;

    Field2Model({
        required this.createdAt,
        required this.entryId,
        required this.field2,
    });

    factory Field2Model.fromJson(Map<String, dynamic> json) => Field2Model(
        createdAt: DateTime.parse(json["created_at"]),
        entryId: json["entry_id"],
        field2: json["field2"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "entry_id": entryId,
        "field2": field2,
    };
}

Field3Model field3ModelFromJson(String str) => Field3Model.fromJson(json.decode(str));

String field3ModelToJson(Field3Model data) => json.encode(data.toJson());

class Field3Model {
    final DateTime createdAt;
    final int entryId;
    final String field3;

    Field3Model({
        required this.createdAt,
        required this.entryId,
        required this.field3,
    });

    factory Field3Model.fromJson(Map<String, dynamic> json) => Field3Model(
        createdAt: DateTime.parse(json["created_at"]),
        entryId: json["entry_id"],
        field3: json["field3"],
    );

    Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "entry_id": entryId,
        "field3": field3,
    };
}
