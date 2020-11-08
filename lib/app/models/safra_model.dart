class SafraModel {
  num id;
  num idUser;
  String anoSafra;
  num custosFixosTotais;
  num manutencoesMaq;

  SafraModel(
      {this.id,
      this.idUser,
      this.anoSafra,
      this.custosFixosTotais,
      this.manutencoesMaq});

  SafraModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    anoSafra = json['ano_safra'];
    custosFixosTotais = json['custos_fixos_totais'];
    manutencoesMaq = json['manutencoes_maq'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['ano_safra'] = this.anoSafra;
    data['custos_fixos_totais'] = this.custosFixosTotais;
    data['manutencoes_maq'] = this.manutencoesMaq;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'id_user': idUser,
      'ano_safra': anoSafra,
      'custos_fixos_totais': custosFixosTotais,
      'manutencoes_maq': manutencoesMaq
    };
  }

  factory SafraModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SafraModel(
        id: map['id'] ?? 0,
        idUser: map['id_user'] ?? '',
        anoSafra: map['ano_safra'] ?? '',
        custosFixosTotais: map['custos_fixos_totais'] ?? '',
        manutencoesMaq: map['manutencoes_maq'] ?? '');
  }
}
