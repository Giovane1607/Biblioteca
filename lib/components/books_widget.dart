import 'package:animated_book_widget/animated_book_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biblioteca/models/book_model.dart';
import 'package:flutter_biblioteca/screens/book_form.dart';
import 'package:flutter_biblioteca/screens/home_screen.dart';
import 'package:flutter_biblioteca/utils/dialog_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

/// Widget class example.
class BooksWidgetCard extends StatelessWidget {
  final List<BooksModel> books;
  final User user;
  const BooksWidgetCard({
    required this.horizontalView,
    required this.books,
    required this.user,
    super.key,
  });

  final bool horizontalView;

  void showErrorMessage(String message) {
      Get.dialog(
        AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }


  @override
  Widget build(BuildContext context) {
    void confirmarExclusaoLivro(String? bookId) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Você tem certeza?"),
            content: const Text("Realmente deseja excluir este livro?"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () {
                  try {
                    FirebaseFirestore.instance
                        .collection('livros')
                        .doc(bookId)
                        .delete()
                        .then((_) {
                      showCustomDialog(
                        title: "Sucesso!",
                        message: "Livro deletado com sucesso!",
                        onConfirm: () {
                          Navigator.of(context).pop();
                          Get.offAll(() => HomeScreen(user: user,));
                        },
                        showCancelButton: false,
                      );
                    }).catchError((error) {
                      showErrorMessage(
                          "Um erro aconteceu ao deletar o animal: `$error`");
                    });
                  } catch (e) {
                    showErrorMessage(
                        "Um erro aconteceu ao deletar o animal: `$e`");
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: const Text("Excluir"),
              ),
            ],
          );
        },
      );
    }

   
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
            size: horizontalView
                ? const Size.fromWidth(160)
                : const Size.fromHeight(700),
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
                    const SizedBox(height: 10),
                    SizedBox(
                      child: Container(
                          color: Colors.grey[200], // Cor de fundo
                          padding: const EdgeInsets.all(
                              20), // Padding em todas as direções
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Livro: ${books[index].nome}",
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
                                  "Autor: ${books[index].autor}",
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
                                  "Editora: ${books[index].editora}",
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
                                  "Ano de publicação: ${books[index].anoPublicacao}",
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
                                  "Gênero: ${books[index].genero}",
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
                                  "Total de páginas: ${books[index].quantidadePaginas}",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
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
                              if (books[index].autorId == user.uid)
                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BookForm(
                                              book: books[index],
                                              user: user,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text('Editar'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                       confirmarExclusaoLivro(books[index].id);
                                      },
                                      child: const Text(
                                        'Deletar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                )
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
