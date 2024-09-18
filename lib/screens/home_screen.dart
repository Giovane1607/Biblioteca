import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biblioteca/components/books_widget.dart';
import 'package:flutter_biblioteca/components/menu.dart';
import 'package:flutter_biblioteca/models/book_model.dart';
import 'package:animated_book_widget/animated_book_widget.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool horizontalView = false;

  List<BooksModel> allBooks = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    List<BooksModel> booksList = [];
    var snapshot = await FirebaseFirestore.instance.collection("livros").get();
    booksList =
        snapshot.docs.map((doc) => BooksModel.fromFirestore(doc)).toList();

    setState(() {
      allBooks = booksList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(user: widget.user),
      appBar: AppBar(
        title: Text('Biblioteca'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: (allBooks.isEmpty)
          ? const Center(
              child: Text(
              'Nada por aqui. \nVamos registrar novos livros?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ))
          : ListView(
              padding: EdgeInsets.only(left: 4, right: 4),
              children: List.generate(allBooks.length, (index) {
                BooksModel model = allBooks[index];
                return Dismissible(
                  key: ValueKey<BooksModel>(model),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 12),
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    remove(model);
                  },
                  child: BooksWidgetCard(horizontalView: horizontalView, books: allBooks,),
                  // child: Text("teste"),
                  // Card(
                  //   elevation: 2,
                  //   child: Column(
                  //     children: [
                  //       ListTile(
                  //         onLongPress: () {},
                  //         onTap: () {},
                  //         leading: Icon(
                  //           Icons.list_alt_rounded,
                  //           size: 56,
                  //         ),
                  //         title: Text("Id: ${model.id} Data: ${model.nome} "),
                  //         subtitle: Text(model.sinopse!),
                  //       )
                  //     ],
                  //   ),
                  // ),
                );
              }),
            ),
    );
  }

  void remove(BooksModel model) {}
}
