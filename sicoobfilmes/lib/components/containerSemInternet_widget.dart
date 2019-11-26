import 'package:flutter/material.dart';
import 'package:sicobfilmes/model/cores.dart';

class SemInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Cores.fundoTela,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.wifi,
              color: Cores.diesel,
              size: 80,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Sem conexão com a internet.',
              style: TextStyle(color: Cores.diesel, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ));
  }
}
