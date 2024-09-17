import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biblioteca/components/menu.dart';
import 'package:flutter_biblioteca/models/book.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Books> listBooks = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
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
      body: (listBooks.isEmpty)
          ? const Center(
              child: Text(
              'Nada por aqui. \nVamos registrar novos livros?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ))
          : ListView(
              padding: EdgeInsets.only(left: 4, right: 4),
              children: List.generate(listBooks.length, (index) {
                Books model = listBooks[index];
                return Dismissible(
                  key: ValueKey<Books>(model),
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
                  child: Card(
                    elevation: 2,
                    child: Column(
                      children: [
                        ListTile(
                          onLongPress: () {},
                          onTap: () {},
                          leading: Icon(
                            Icons.list_alt_rounded,
                            size: 56,
                          ),
                          title: Text("Id: ${model.id} Data: ${model.data} "),
                          subtitle: Text(model.descricao!),
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
    );
  }
  void remove(Books model) {}
}


