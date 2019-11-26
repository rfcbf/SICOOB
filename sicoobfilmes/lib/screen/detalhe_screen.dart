import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sicobfilmes/components/raisedGradientButton_widget.dart';
import 'package:sicobfilmes/components/shadowText.dart';
import 'package:sicobfilmes/model/cores.dart';
import 'package:sicobfilmes/model/favoritos.dart';
import 'package:sicobfilmes/model/filmes.dart';
import 'package:sicobfilmes/service/connectionStatus.dart';
import 'package:sicobfilmes/service/filmesService.dart';
import 'package:sicobfilmes/service/funcoes.dart';
import 'package:intl/intl.dart';

class DestalheScreen extends StatefulWidget {
  final Filmes filmes;
  final bool favorito;

  DestalheScreen(this.filmes, this.favorito);

  @override
  _DestalheScreenState createState() => _DestalheScreenState();
}

class _DestalheScreenState extends State<DestalheScreen> {
  bool _favorito = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  StatusConexao _conexao = StatusConexao.getInstance();
  final favoritosDB = Favoritos.instance;

  Filmes _filmes = Filmes();
  bool _dadosRecuperados = false;

  @override
  void initState() {
    super.initState();
    _favorito = widget.filmes.favorito;
    _chamaRecuperaDados();
  }

  Future<void> _consultar() async {
    setState(() {
      _dadosRecuperados = false;
    });

    _filmes = await FilmesService().getUnicoFilmes(widget.filmes.id.toString());

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
      key: _scaffoldKey,
      body: Container(color: Cores.diesel, child: _corpo(context)),
      bottomNavigationBar: Container(
        color: Cores.diesel,
        height: 90,
        child: Column(
          children: <Widget>[
            _conexao.hasConnection ? _botaoFavorito(context) : Container(),
          ],
        ),
      ),
    );
  }

  Widget _corpo(BuildContext context) {
    return Column(
      children: <Widget>[
        _cabecalho(context),
        Expanded(
            child: SingleChildScrollView(
          child: Center(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        elevation: 8,
                        color: Cores.bazar,
                        child: Container(
                          height: 80,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Popularidade',
                                style: TextStyle(
                                  color: Cores.diesel,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.filmes.popularity.toString(),
                                style: TextStyle(color: Cores.zircon, fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 8,
                        color: Cores.bazar,
                        child: Container(
                          height: 80,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Votos',
                                style: TextStyle(color: Cores.diesel, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.filmes.voteCount.toString(),
                                style: TextStyle(color: Cores.zircon, fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 8,
                        color: Cores.bazar,
                        child: Container(
                          height: 80,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Tempo',
                                style: TextStyle(color: Cores.diesel, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              _dadosRecuperados
                                  ? Text(
                                      _filmes.runtime.toString() + ' min',
                                      style: TextStyle(color: Cores.zircon, fontSize: 15, fontWeight: FontWeight.bold),
                                    )
                                  : Container(
                                      width: 20,
                                      height: 20,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            valueColor: AlwaysStoppedAnimation<Color>(Cores.feldspar)),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              _dadosRecuperados
                  ? Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        // color: Cores.amarelo,
                        child: _listaGenero(),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Container(
                        width: double.infinity,
                        height: 30,
                        child: Center(
                          child: Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Cores.feldspar)),
                          ),
                        ),
                      ),
                    ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Container(
                  height: 220,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 140,
                        child: Center(
                          child: _poster(context),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text('Título em Português',
                                style: TextStyle(color: Cores.feldspar, fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(widget.filmes.title,
                                textAlign: TextAlign.end,
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(color: Cores.zircon, fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Título Original',
                                style: TextStyle(color: Cores.feldspar, fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(widget.filmes.originalTitle,
                                textAlign: TextAlign.end,
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(color: Cores.zircon, fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Idioma Original',
                                style: TextStyle(color: Cores.feldspar, fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(widget.filmes.originalLanguage,
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Cores.zircon, fontSize: 15, fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Data de Lançamento',
                                style: TextStyle(color: Cores.feldspar, fontSize: 15, fontWeight: FontWeight.bold)),
                            Text(
                                DateFormat('dd/MM/yyyy')
                                    .format(Funcoes.convertStringParaData(widget.filmes.releaseDate)),
                                textAlign: TextAlign.end,
                                style: TextStyle(color: Cores.zircon, fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text('Sumário',
                          style: TextStyle(color: Cores.feldspar, fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.filmes.overview,
                        softWrap: true,
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Cores.zircon, fontSize: 17),
                      ),
                    ],
                  )),
            ],
          )),
        )),
      ],
    );
  }

  Widget _listaGenero() {
    return ListView.builder(
        itemCount: _filmes.generos.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
            child: Container(
                decoration: BoxDecoration(
                  // border: Border.all(width: 0.0, color: Cores.feldspar),
                  color: Cores.bazar,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                width: 130,
                height: 10,
                child: Center(
                    child: Text(
                  _filmes.generos[index].name,
                  style: TextStyle(color: Cores.zircon),
                ))),
          );
        });
  }

  Widget _cabecalho(BuildContext context) {
    return SizedBox(
      child: Container(
          height: MediaQuery.of(context).size.height / 3.5,
          margin: EdgeInsets.only(bottom: 10),
          child: Material(
            elevation: 5,
            clipBehavior: Clip.antiAlias,
            //borderRadius: BorderRadius.only(bottomRight: Radius.circular(70)),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                _imagemFundo(context),
                _botaoFechar(context),
                Positioned(
                  child: _nota(),
                  bottom: (MediaQuery.of(context).size.height / 3.5) / 3.5,
                  right: 10,
                ),
              ],
            ),
          )),
    );
  }

  Widget _nota() {
    return Card(
      elevation: 8,
      color: Colors.brown.withOpacity(0.5),
      child: Container(
        height: 80,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ShadowText(
              'Nota',
              style: TextStyle(color: Cores.zircon, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            ShadowText(
              widget.filmes.voteAverage.toString(),
              style: TextStyle(color: Cores.zircon, fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagemFundo(BuildContext context) {
    return CachedNetworkImage(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3.5,
      imageUrl: "http://image.tmdb.org/t/p/w780" + widget.filmes.backdropPath,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Cores.diesel),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  Widget _poster(BuildContext context) {
    return Hero(
      child: Container(
          width: 100,
          height: 150,
          child: Material(
              elevation: 8,
              shadowColor: Cores.feldspar,
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: "http://image.tmdb.org/t/p/w500" + widget.filmes.posterPath,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Cores.branco),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Cores.branco,
                ),
              ))),
      tag: widget.filmes.id,
    );
  }

  Widget _botaoFechar(BuildContext context) {
    return Positioned(
      top: 35,
      left: -10,
      child: RawMaterialButton(
        elevation: 10,
        shape: CircleBorder(side: BorderSide(color: Cores.branco, width: 1)),
        fillColor: Cores.branco,
        splashColor: Colors.grey,
        textStyle: TextStyle(color: Cores.diesel),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Icon(Icons.arrow_back_ios)],
        ),
        onPressed: () {
          // Navigator.of(context).pop(context, _favorito);
          Navigator.pop(context, _favorito);
        },
      ),
    );
  }

  Widget _botaoFavorito(BuildContext context) {
    return !_favorito
        ? Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            height: 60,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: RaisedGradientButton(
                        texto: Text('Marcar como Favorito',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                          Cores.feldspar,
                          Cores.feldspar,
                        ]),
                        elevation: 3,
                        radius: 10,
                        height: 55,
                        icone: Icon(
                          MaterialCommunityIcons.star,
                          color: Cores.branco,
                          size: 20,
                        ),
                        onPressed: () async {
                          await _inserir(widget.filmes.id);
                          setState(() {
                            _favorito = true;
                          });
                        }),
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            height: 60,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: RaisedGradientButton(
                        texto: Text('Remover dos Favorito',
                            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                        gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
                          Colors.red[500],
                          Colors.red[500],
                        ]),
                        elevation: 3,
                        radius: 10,
                        height: 55,
                        icone: Icon(
                          MaterialCommunityIcons.star,
                          color: Cores.branco,
                          size: 20,
                        ),
                        onPressed: () async {
                          await _remover(widget.filmes.id);

                          setState(() {
                            _favorito = false;
                          });
                        }),
                  ),
                ),
              ],
            ),
          );
  }

  Future<void> _inserir(int idMovie) async {
    Map<String, dynamic> row = {Favoritos.columnIDMovie: idMovie};
    return await favoritosDB.insert(row);
  }

  Future<void> _remover(int idMovie) async {
    return await favoritosDB.delete(idMovie.toString());
  }
}
