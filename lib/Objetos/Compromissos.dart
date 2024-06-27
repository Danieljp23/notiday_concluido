class Compromisso {
  String id;
  String assunto;
  String descricao;
  String cep;
  String endereco;
  String numeroCasa;
  String horario;
  String data;
  String periodo;
  String? cor;

  Compromisso(
      {required this.id,
      required this.assunto,
      required this.descricao,
      required this.cep,
      required this.endereco,
      required this.numeroCasa,
      required this.horario,
      required this.data,
      required this.periodo,
      required this.cor});
  Compromisso.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        assunto = map["assunto"],
        descricao = map["descricao"],
        cep = map["cep"],
        endereco = map["endereco"],
        numeroCasa = map["numeroCasa"],
        horario = map["horario"],
        data = map["data"],
        periodo = map["periodo"],
        cor = map["cor"];
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "assunto": assunto,
      "descricao": descricao,
      "cep": cep,
      "endereco": endereco,
      "numeroCasa": numeroCasa,
      "horario": horario,
      "data": data,
      "periodo": periodo,
      "cor": cor,
    };
  }
}
