// import 'dart:convert';

// class DashboardModel {
//   num id;
//   num idUser;
//   num idSafra;
//   num receitaBrutaTotal;
//   num deducoesImpostosTotal;
//   num receitaLiquidaTotal;
//   num custosVariaveisTotal;
//   num lucroBruto;
//   num gastosFixosOperacionais;
//   num lucroLiquido;
//   num custosDepreciacoes;
//   num lucroSacaMcu;
//   num pontoEquilibrio;
//   num margemSeguranca;

//   DashboardModel(
//       {this.id,
//       this.idUser,
//       this.idSafra,
//       this.receitaBrutaTotal,
//       this.deducoesImpostosTotal,
//       this.receitaLiquidaTotal,
//       this.custosVariaveisTotal,
//       this.lucroBruto,
//       this.gastosFixosOperacionais,
//       this.lucroLiquido,
//       this.custosDepreciacoes,
//       this.lucroSacaMcu,
//       this.pontoEquilibrio,
//       this.margemSeguranca});

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'idUser': idUser,
//       'idSafra': idSafra,
//       'receitaBrutaTotal': receitaBrutaTotal,
//       'deducoesImpostosTotal': deducoesImpostosTotal,
//       'receitaLiquidaTotal': receitaLiquidaTotal,
//       'custosVariaveisTotal': custosVariaveisTotal,
//       'lucroBruto': lucroBruto,
//       'gastosFixosOperacionais': gastosFixosOperacionais,
//       'lucroLiquido': lucroLiquido,
//       'custosDepreciacoes': custosDepreciacoes,
//       'lucroSacaMcu': lucroSacaMcu,
//       'pontoEquilibrio': pontoEquilibrio,
//       'margemSeguranca': margemSeguranca,
//     };
//   }

//   factory DashboardModel.fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return DashboardModel(
//       id: map['id'] ?? 0,
//       idUser: map['idUser'] ?? '',
//       idSafra: map['idSafra'] ?? '',
//       receitaBrutaTotal: map['receitaBrutaTotal'] ?? '',
//       deducoesImpostosTotal: map['deducoesImpostosTotal'] ?? '',
//       receitaLiquidaTotal: map['receitaLiquidaTotal'] ?? '',
//       custosVariaveisTotal: map['custosVariaveisTotal'] ?? '',
//       lucroBruto: map['lucroBruto'] ?? '',
//       gastosFixosOperacionais: map['gastosFixosOperacionais'] ?? '',
//       lucroLiquido: map['lucroLiquido'] ?? '',
//       custosDepreciacoes: map['custosDepreciacoes'] ?? '',
//       lucroSacaMcu: map['lucroSacaMcu'] ?? '',
//       pontoEquilibrio: map['pontoEquilibrio'] ?? '',
//       margemSeguranca: map['margemSeguranca'] ?? '',
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory DashboardModel.fromJson(String source) =>
//       DashboardModel.fromMap(json.decode(source));
// }

// MODEL ACIMA DO VIDEO DO CURSO, MAS NÃO FUNCIONA
// MODEL DEBAIXO E O ANTIGO E FUNCIONA

class DashboardModel {
  num id;
  num idUser;
  num idSafra;
  num receitaBrutaTotal;
  num deducoesImpostosTotal;
  num receitaLiquidaTotal;
  num custosVariaveisTotal;
  num lucroBruto;
  num gastosFixosOperacionais;
  num lucroLiquido;
  num custosDepreciacoes;
  num lucroSacaMcu;
  num pontoEquilibrio;
  num margemSeguranca;

  DashboardModel(
      {this.id,
      this.idUser,
      this.idSafra,
      this.receitaBrutaTotal,
      this.deducoesImpostosTotal,
      this.receitaLiquidaTotal,
      this.custosVariaveisTotal,
      this.lucroBruto,
      this.gastosFixosOperacionais,
      this.lucroLiquido,
      this.custosDepreciacoes,
      this.lucroSacaMcu,
      this.pontoEquilibrio,
      this.margemSeguranca});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['id_user'];
    idSafra = json['id_safra'];
    receitaBrutaTotal = json['receita_bruta_total'];
    deducoesImpostosTotal = json['deducoes_impostos_total'];
    receitaLiquidaTotal = json['receita_liquida_total'];
    custosVariaveisTotal = json['custos_variaveis_total'];
    lucroBruto = json['lucro_bruto'];
    gastosFixosOperacionais = json['gastos_fixos_operacionais'];
    lucroLiquido = json['lucro_liquido'];
    custosDepreciacoes = json['custos_depreciacoes'];
    lucroSacaMcu = json['lucro_saca_mcu'];
    pontoEquilibrio = json['ponto_equilibrio'];
    margemSeguranca = json['margem_seguranca'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_user'] = this.idUser;
    data['id_safra'] = this.idSafra;
    data['receita_bruta_total'] = this.receitaBrutaTotal;
    data['deducoes_impostos_total'] = this.deducoesImpostosTotal;
    data['receita_liquida_total'] = this.receitaLiquidaTotal;
    data['custos_variaveis_total'] = this.custosVariaveisTotal;
    data['lucro_bruto'] = this.lucroBruto;
    data['gastos_fixos_operacionais'] = this.gastosFixosOperacionais;
    data['lucro_liquido'] = this.lucroLiquido;
    data['custos_depreciacoes'] = this.custosDepreciacoes;
    data['lucro_saca_mcu'] = this.lucroSacaMcu;
    data['ponto_equilibrio'] = this.pontoEquilibrio;
    data['margem_seguranca'] = this.margemSeguranca;
    return data;
  }
}

// class HomePageModel {
//   double idUser;
//   double idSafra;
//   double receitaBrutaTotal;
//   double deducoesImpostosTotal;
//   double receitaLiquidaTotal;
//   double custosVariaveisTotal;
//   double lucroBruto;
//   double lucroLiquido;
//   double custosDepreciacoes;
//   double lucroSacaMcu;
//   double pontoEquilibrio;
//   double margemSeguranca;

//   HomePageModel(
//       {this.idUser,
//       this.idSafra,
//       this.receitaBrutaTotal,
//       this.deducoesImpostosTotal,
//       this.receitaLiquidaTotal,
//       this.custosVariaveisTotal,
//       this.lucroBruto,
//       this.lucroLiquido,
//       this.custosDepreciacoes,
//       this.lucroSacaMcu,
//       this.pontoEquilibrio,
//       this.margemSeguranca});

//   static HomePageModel fromMap(Map<String, dynamic> map) {
//     if (map == null) return null;

//     return HomePageModel(
//         idUser: map['id_user'].toInt(),
//         idSafra: map['id_safra'].toInt(),
//         receitaBrutaTotal: map['receita_bruta_total'].toInt(),
//         deducoesImpostosTotal: map['deducoes_impostos_total'].toInt(),
//         receitaLiquidaTotal: map['receita_liquida_total'].toInt(),
//         custosVariaveisTotal: map['custos_variaveis_total'].toInt(),
//         lucroBruto: map['lucro_bruto'].toInt(),
//         lucroLiquido: map['lucro_liquido'].toInt(),
//         custosDepreciacoes: map['custos_depreciacoes'].toInt(),
//         lucroSacaMcu: map['lucro_saca_mcu'].toInt(),
//         pontoEquilibrio: map['ponto_equilibrio'].toInt(),
//         margemSeguranca: map['margem_seguranca'].toInt());
//   }
// }
