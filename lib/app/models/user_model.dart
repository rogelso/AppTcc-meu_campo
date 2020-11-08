import 'dart:convert';

class UserModel {
  String token;
  int id;
  String nome;
  String sobrenome;
  String email;
  String cidade;
  String uf;

  UserModel({
    this.token,
    this.id,
    this.nome,
    this.sobrenome,
    this.email,
    this.cidade,
    this.uf,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'id': id,
      'nome': nome,
      'sobrenome': sobrenome,
      'email': email,
      'cidade': cidade,
      'uf': uf,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      token: map['token'],
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      sobrenome: map['sobrenome'] ?? '',
      email: map['email'] ?? '',
      cidade: map['cidade'] ?? '',
      uf: map['uf'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
