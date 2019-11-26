import 'package:flutter/material.dart';
import 'package:sicobfilmes/components/componentes_widget.dart';
import 'package:sicobfilmes/model/cores.dart';
import 'package:sicobfilmes/model/filmes.dart';
import 'package:sicobfilmes/screen/detalhe_screen.dart';
import 'package:sicobfilmes/service/filmesService.dart';

class PopularesScreen extends StatefulWidget {
  @override
  _PopularesScreenState createState() => _PopularesScreenState();
}

class _PopularesScreenState extends State<PopularesScreen> {
  List<Filmes> _filmes = [];
  int _pag = 1;
  ScrollController _scrollController = ScrollController();
  bool isPerformingRequest = false;
  bool _dadosRecuperados = false;

  @override
  void initState() {
    super.initState();

    _chamaRecuperaDados();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _chamaRecuperaDados() async {
    _pag = 1;
    await filmes().then((result) async {
      setState(() {
        _dadosRecuperados = true;
      });
    });
  }

  Future<void> filmes() async {
    _filmes = await FilmesService().getFilmes();
  }

  Future<List<Filmes>> _loadMore() async {
    _pag = _pag + 1;
    List<Filmes> _filmesTemp = [];
    _filmesTemp = await FilmesService().getProximaFilmes(_pag.toString());

    return _filmesTemp;
  }

  _getMoreData() async {
    if (!isPerformingRequest) {
      setState(() => isPerformingRequest = true);
      List<Filmes> novosFilmes = [];

      if (_pag >= 500) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(_scrollController.offset - (edge - offsetFromBottom),
              duration: new Duration(milliseconds: 500), curve: Curves.easeOut);
        }
      } else {
        novosFilmes = await _loadMore();
      }

      setState(() {
        _filmes.addAll(novosFilmes);
        isPerformingRequest = false;
      });
    }
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
        controller: _scrollController,
        itemCount: _filmes.length + 1,
        itemBuilder: (context, index) {
          if (index == _filmes.length) {
            return _buildProgressIndicator();
          } else {
            return cardFilmes(_filmes[index], context);
          }
        });
  }

  Widget cardFilmes(Filmes filme, BuildContext context) {
    return InkWell(
      onTap: () async {
        await Navigator.push(context, MaterialPageRoute(builder: (context) => DestalheScreen(filme, false)))
            .then((val) {
          filme.favorito = val;
        });
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

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isPerformingRequest ? 1.0 : 0.0,
          child: new CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Cores.feldspar)),
        ),
      ),
    );
  }
}
