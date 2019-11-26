import 'package:flutter/material.dart';
import 'package:sicobfilmes/components/componentes_widget.dart';
import 'package:sicobfilmes/model/cores.dart';
import 'package:sicobfilmes/model/favoritos.dart';
import 'package:sicobfilmes/model/filmes.dart';
import 'package:sicobfilmes/screen/detalhe_screen.dart';
import 'package:sicobfilmes/service/filmesService.dart';

class FavoritosScreen extends StatefulWidget {
  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  final favoritosDB = Favoritos.instance;

  List<Filmes> _filmes = [];
  bool _dadosRecuperados = false;

  @override
  void initState() {
    super.initState();
    _chamaRecuperaDados();
  }

  Future<void> _consultar() async {
    _filmes = [];

    setState(() {
      _dadosRecuperados = false;
    });

    final todasLinhas = await favoritosDB.queryAllRows();

    for (var i = 0; i <= todasLinhas.length - 1; i++) {
      Filmes filme = await FilmesService().getUnicoFilmes(todasLinhas[i]['idMovie'].toString());
      _filmes.add(filme);
    }
    return _filmes;
  }

  Future<void> _chamaRecuperaDados() async {
    return await _consultar().then((result) {
      setState(() {
        _dadosRecuperados = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Cores.diesel,
      body: _dadosRecuperados
          ? _buildTela(context)
          : Container(
              child: Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Cores.feldspar)),
              ),
            ),
    );
  }

  Widget _buildTela(BuildContext context) {
    return _buildList();
  }

  Widget _buildList() {
    return ListView.builder(
        itemCount: _filmes.length,
        itemBuilder: (context, index) {
          return cardFilmes(_filmes[index], context);
        });
  }

  Widget cardFilmes(Filmes filme, BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => DestalheScreen(filme, false)));
        _chamaRecuperaDados();
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.fromLTRB(8, 8, 8, 0),
        color: Cores.diesel,
        child: Container(
          height: 200,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Componentes.imagemFundo(filme.backdropPath, filme.id),
              Componentes.imagemPreta(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                      width: 100,
                      height: 150,
                      child: Material(
                        elevation: 8,
                        shadowColor: Cores.feldspar,
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                        child: Componentes.poster(filme.posterPath, filme.id),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  filme.voteAverage.toString(),
                                  style: TextStyle(color: Cores.branco, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                filme.favorito
                                    ? Icon(
                                        Icons.star,
                                        color: Cores.branco,
                                        size: 25,
                                      )
                                    : Container(
                                        width: 25,
                                        height: 25,
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: 80,
                            ),
                            Text(
                              filme.title,
                              maxLines: 2,
                              style: TextStyle(color: Cores.branco, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 15,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
