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
}
