import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sicobfilmes/components/containerSemInternet_widget.dart';
import 'package:sicobfilmes/model/cores.dart';
import 'package:sicobfilmes/screen/favoritos_screen.dart';
import 'package:sicobfilmes/screen/populares_screen.dart';
import 'package:sicobfilmes/service/connectionStatus.dart';

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  int currentIndex;
  StatusConexao _conexao = StatusConexao.getInstance();

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Widget _scaffold() {
    return Scaffold(
      backgroundColor: Cores.fundoTela,
      appBar: AppBar(
        backgroundColor: Cores.diesel,
        centerTitle: false,
        title: textoTitulo(),
      ),
      body: bodyContainer(context),
      bottomNavigationBar: BubbleBottomBar(
        opacity: .2,
        currentIndex: currentIndex,
        onTap: changePage,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        backgroundColor: Cores.diesel,
        hasNotch: true, //new
        items: <BubbleBottomBarItem>[
          BubbleBottomBarItem(
              backgroundColor: Cores.zircon,
              icon: Icon(
                Icons.dashboard,
                color: Cores.zircon,
              ),
              activeIcon: Icon(
                Icons.dashboard,
                color: Cores.zircon,
              ),
              title: Text(
                "Populares",
                style: TextStyle(color: Cores.zircon),
              )),
          BubbleBottomBarItem(
              backgroundColor: Cores.zircon,
              icon: Icon(
                Icons.star,
                color: Cores.zircon,
              ),
              activeIcon: Icon(
                Icons.star,
                color: Cores.zircon,
              ),
              title: Text(
                "Favoritos",
                style: TextStyle(color: Cores.zircon),
              )),
        ],
      ),
    );
  }

  Widget textoTitulo() {
    return Text("SICOOB Filmes",
        style: TextStyle(color: Cores.zircon, fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal));
  }

  Widget bodyContainer(BuildContext context) {
    switch (currentIndex) {
      case 0:
        if (_conexao.hasConnection) {
          return PopularesScreen();
        } else {
          return SemInternet();
        }
        break;
      case 1:
        if (_conexao.hasConnection) {
          return FavoritosScreen();
        } else {
          return SemInternet();
        }

        break;
    }
    return Container();
  }
}
