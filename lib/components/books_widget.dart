import 'package:animated_book_widget/animated_book_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_biblioteca/models/book_model.dart';
import 'package:google_fonts/google_fonts.dart';

/// Widget class example.
class BooksWidgetCard extends StatelessWidget {
  final List<BooksModel> books;

  const BooksWidgetCard({
    required this.horizontalView,
    required this.books,
    super.key,
  });

  final bool horizontalView;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: horizontalView
          ? 225
          : MediaQuery.of(context)
              .size
              .height, // Ajuste a altura conforme necessário
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: horizontalView ? Axis.horizontal : Axis.vertical,
        itemCount: books.length,
        itemBuilder: (_, index) {
          return AnimatedBookWidget(
            size: horizontalView ? Size.fromWidth(160) : Size.fromHeight(700),
            padding: horizontalView
                ? const EdgeInsets.symmetric(horizontal: 5)
                : const EdgeInsets.symmetric(vertical: 5),
            cover: ClipRRect(
              borderRadius:
                  const BorderRadius.horizontal(right: Radius.circular(10)),
              child: Image.network(
                books[index].capaUrl,
                fit: BoxFit.cover,
              ),
            ),
            content: ColoredBox(
              color: const Color(0xFFF1F1F1),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: const Color(0xFF01DFD7),
                    //   child: Image.network(
                    //     books[index].bookAuthorImgUrl,
                    //   ),
                    // ),
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Container(
                          color: Colors.grey[200], // Cor de fundo
                          padding: EdgeInsets.all(
                              20), // Padding em todas as direções
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Livro: " + books[index].nome,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Autor: " + books[index].autor,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Editora: " + books[index].editora,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Ano de publicação: " +
                                      books[index].anoPublicacao.toString(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Gênero: " + books[index].genero,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Total de páginas: " +
                                      books[index].quantidadePaginas.toString(),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                               SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Sobre o livro: ",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              RichText(
                                overflow: TextOverflow.fade,
                                text: TextSpan(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 18,
                                  ),
                                  text: books[index].sinopse,
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
