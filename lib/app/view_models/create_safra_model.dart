import 'dart:convert';

class CreateSafraModel {
  int idSafra;
  String anoSafra;

  CreateSafraModel({this.idSafra, this.anoSafra});

  Map<String, dynamic> toMap() {
    return {
      'id': idSafra,
      'ano_safra': anoSafra,
    };
  }

  factory CreateSafraModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CreateSafraModel(
      idSafra: map['id'] ?? 0,
      anoSafra: map['ano_safra'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateSafraModel.fromJson(String source) =>
      CreateSafraModel.fromMap(json.decode(source));
}
