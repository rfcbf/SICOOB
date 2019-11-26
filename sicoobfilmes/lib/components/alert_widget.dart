import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:sicobfilmes/model/cores.dart';

class AlertaComConexao {
  final BuildContext context;

  AlertaComConexao({this.context});

  void exibir() {
    Flushbar(
      title: 'Conexão restabelecida',
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Cores.diesel,
      isDismissible: false,
      icon: Icon(
        Icons.wifi,
        size: 28.0,
        color: Cores.branco,
      ),
      message: 'Conexão com a internet restabelecida',
      duration: Duration(seconds: 4),
    )..show(context);
  }
}

class AlertaSemConexao {
  final BuildContext context;

  AlertaSemConexao({this.context});

  void exibir() {
    Flushbar(
      title: 'Conexão perdida',
      flushbarStyle: FlushbarStyle.GROUNDED,
      backgroundColor: Cores.vermelho,
      isDismissible: false,
      icon: Icon(
        Icons.wifi,
        size: 28.0,
        color: Cores.branco,
      ),
      message: 'No momento estamos sem conexão com internet.',
      duration: Duration(seconds: 4),
    )..show(context);
  }
}
