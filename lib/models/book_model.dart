import 'package:cloud_firestore/cloud_firestore.dart';

class BooksModel {
  String id;
  int anoPublicacao;
  String autor;
  String capaUrl;
  String editora;
  String genero;
  String nome;
  int quantidadePaginas;
  String sinopse;

  BooksModel(
      {required this.id,
      required this.anoPublicacao,
      required this.autor,
      required this.capaUrl,
      required this.editora,
      required this.genero,
      required this.nome,
      required this.quantidadePaginas,
      required this.sinopse});

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
    );
  }

  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
      id: json["id"],
      anoPublicacao: json["nome"] ?? '',
      autor: json["autor"] ?? '',
      capaUrl: json["capaUrl"] ?? '',
      editora: json["editora"] ?? '',
      genero: json["genero"] ?? '',
      nome: json["nome"] ?? '',
      quantidadePaginas: json["quantidadePaginas"] ?? '',
      sinopse: json["sinopse"] ?? '',
    );
  }

  @override
  String toString() {
    return 'BooksModel{id: $id, anoPublicacao: $anoPublicacao, autor: $autor, capaUrl: $capaUrl, editora: $editora, genero: $genero, nome: $nome, quantidadePaginas: $quantidadePaginas, sinopse: $sinopse}';
  }

  // BooksModel? copyWith({
  //   String? newNome,
  //   String? newDescricao,
  //   Timestamp? newDataNascimento,
  //   String? newImageUrl,
  //   int? newPorte,
  //   String? newRaca,
  //   bool? newVacinado,
  //   bool? newCastrado,
  //   bool? newFilhos,
  //   String? newTipo,
  //   String? newDoadorId,
  //   String? newDoadorNome,
  //   String? newDoadorTelefone,
  // }) {
  //   return BooksModel(
  //     id: id,
  //     nome: newNome ?? nome,
  //     doadorId: doadorId,
  //     descricao: newDescricao ?? descricao,
  //     dataNascimento: newDataNascimento ?? dataNascimento,
  //     imageUrl: newImageUrl ?? imageUrl,
  //     porte: newPorte ?? porte,
  //     raca: newRaca ?? raca,
  //     vacinado: newVacinado ?? vacinado,
  //     castrado: newCastrado ?? castrado,
  //     filhos: newFilhos ?? filhos,
  //     tipo: newTipo ?? tipo,
  //     doadorNome: newDoadorNome ?? doadorNome,
  //     doadorTelefone: newDoadorTelefone ?? doadorTelefone,
  //   );
  // }
}
