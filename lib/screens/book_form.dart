import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biblioteca/models/book_model.dart';
import 'package:flutter_biblioteca/screens/home_screen.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class BookForm extends StatefulWidget {
  final BooksModel? book;
  final User user;
  const BookForm({super.key, this.book, required this.user});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book != null ? 'Editar Livro' : 'Adicionar Livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                FormBuilderTextField(
                  name: 'nome',
                  initialValue: widget.book?.nome ?? '',
                  decoration: const InputDecoration(labelText: 'Nome do Livro'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(3),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'autor',
                  initialValue: widget.book?.autor ?? '',
                  decoration: const InputDecoration(labelText: 'Autor'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'editora',
                  initialValue: widget.book?.editora ?? '',
                  decoration: const InputDecoration(labelText: 'Editora'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'genero',
                  initialValue: widget.book?.genero ?? '',
                  decoration: const InputDecoration(labelText: 'Gênero'),
                  validator: FormBuilderValidators.required(),
                ),
                FormBuilderTextField(
                  name: 'capaUrl',
                  initialValue: widget.book?.capaUrl ?? '',
                  decoration: const InputDecoration(labelText: 'URL da Capa'),
                  validator: FormBuilderValidators.url(),
                ),
                FormBuilderTextField(
                  name: 'anoPublicacao',
                  initialValue: widget.book?.anoPublicacao.toString() ?? '',
                  decoration:
                      const InputDecoration(labelText: 'Ano de Publicação'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.integer(),
                    FormBuilderValidators.max(DateTime.now().year),
                  ]),
                  keyboardType: TextInputType.number,
                ),
                FormBuilderTextField(
                  name: 'quantidadePaginas',
                  initialValue: widget.book?.quantidadePaginas.toString() ?? '',
                  decoration:
                      const InputDecoration(labelText: 'Quantidade de Páginas'),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.integer(),
                  ]),
                  keyboardType: TextInputType.number,
                ),
                FormBuilderTextField(
                  name: 'sinopse',
                  initialValue: widget.book?.sinopse ?? '',
                  decoration: const InputDecoration(labelText: 'Sinopse'),
                  maxLines: 5,
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final formData = _formKey.currentState?.value;

                      if (formData == null) return;

                      if (widget.book == null) {
                        final newBook = BooksModel(
                          id: UniqueKey().toString(), // Ou gere um ID único
                          anoPublicacao: int.parse(formData['anoPublicacao']),
                          autor: formData['autor'],
                          capaUrl: formData['capaUrl'],
                          editora: formData['editora'],
                          genero: formData['genero'],
                          nome: formData['nome'],
                          quantidadePaginas:
                              int.parse(formData['quantidadePaginas']),
                          sinopse: formData['sinopse'],
                          autorId: widget.user.uid,
                        );

                        await firestore
                            .collection('livros')
                            .add(newBook.toMap());

                        Navigator.of(context).pop();
                        Get.offAll(() => HomeScreen(
                              user: widget.user,
                            ));

                        Get.snackbar(
                          'Sucesso',
                          'Livro adicionado com sucesso!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      } else {
                        widget.book?.anoPublicacao =
                            int.parse(formData['anoPublicacao']);
                        widget.book?.autor = formData['autor'];
                        widget.book?.capaUrl = formData['capaUrl'];
                        widget.book?.editora = formData['editora'];
                        widget.book?.genero = formData['genero'];
                        widget.book?.nome = formData['nome'];
                        widget.book?.quantidadePaginas =
                            int.parse(formData['quantidadePaginas']);
                        widget.book?.sinopse = formData['sinopse'];
                        widget.book?.autorId = widget.user.uid;

                        await firestore
                            .collection('livros')
                            .doc(widget.book?.id)
                            .update(widget.book!.toMap());

                        // Get.back(result: true);
                        Navigator.of(context).pop();
                        Get.offAll(() => HomeScreen(
                              user: widget.user,
                            ));

                        Get.snackbar(
                          'Sucesso',
                          'Livro atualizado com sucesso!',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      }
                    }
                  },
                  child: Text(widget.book != null ? 'Atualizar' : 'Adicionar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
