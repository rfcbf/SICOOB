import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sicobfilmes/model/cores.dart';

class Componentes {
  static Widget imagemFundo(String imagem, int id) {
    return CachedNetworkImage(
      imageUrl: "http://image.tmdb.org/t/p/w780$imagem",
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

  static Widget imagemPreta() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black12,
            Colors.black87,
          ],
        ),
      ),
    );
  }

  static Widget poster(String imagem, int id) {
    return Hero(
      child: CachedNetworkImage(
        imageUrl: "http://image.tmdb.org/t/p/w500$imagem",
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
      ),
      tag: id,
    );
  }
}
