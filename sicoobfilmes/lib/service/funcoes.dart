class Funcoes {
  static DateTime convertStringParaData(String value) {
    int ano = int.parse(value.substring(0, 4));
    int mes = int.parse(value.substring(5, 7));
    int dia = int.parse(value.substring(8, 10));
    return DateTime.utc(ano, mes, dia);
  }
}
