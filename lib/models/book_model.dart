import 'package:cloud_firestore/cloud_firestore.dart';

class BooksModel {
  String? id;
  int anoPublicacao;
  String autor;
  String capaUrl;
  String editora;
  String genero;
  String nome;
  int quantidadePaginas;
  String sinopse;
  String autorId;

  BooksModel({
    this.id,
    required this.anoPublicacao,
    required this.autor,
    required this.capaUrl,
    required this.editora,
    required this.genero,
    required this.nome,
    required this.quantidadePaginas,
    required this.sinopse,
    required this.autorId,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "anoPublicacao": anoPublicacao,
      "autor": autor,
      "capaUrl": capaUrl,
      "editora": editora,
      "genero": genero,
      "nome": nome,
      "quantidadePaginas": quantidadePaginas,
      "sinopse": sinopse,
      "autorId": autorId,
    };
  }

  factory BooksModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BooksModel(
      id: doc.id,
      anoPublicacao: data["anoPublicacao"],
      autor: data["autor"] ?? '',
      capaUrl: data["capaUrl"] ?? '',
      editora: data["editora"] ?? '',
      genero: data["genero"] ?? '',
      nome: data["nome"] ?? '',
      quantidadePaginas: data["quantidadePaginas"],
      sinopse: data["sinopse"] ?? '',
      autorId: data["autorId"],
    );
  }

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
      id: json["id"],
      anoPublicacao: json["anoPublicacao"] ?? 0,
      autor: json["autor"] ?? '',
      capaUrl: json["capaUrl"] ?? '',
      editora: json["editora"] ?? '',
      genero: json["genero"] ?? '',
      nome: json["nome"] ?? '',
      quantidadePaginas: json["quantidadePaginas"] ?? 0,
      sinopse: json["sinopse"] ?? '',
      autorId: json["autorId"] ?? '',
    );
  }

  @override
  String toString() {
    return 'BooksModel{id: $id, anoPublicacao: $anoPublicacao, autor: $autor, capaUrl: $capaUrl, editora: $editora, genero: $genero, nome: $nome, quantidadePaginas: $quantidadePaginas, sinopse: $sinopse}';
  }
}
