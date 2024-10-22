import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biblioteca/components/books_widget.dart';
import 'package:flutter_biblioteca/components/menu.dart';
import 'package:flutter_biblioteca/models/book_model.dart';
import 'package:flutter_biblioteca/screens/book_form.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool horizontalView = false;

  List<BooksModel> allBooks = [];
  bool isLoading = false;
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
        title: const Text('Biblioteca'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => BookForm(user: widget.user))?.then((value) {});
        },
        child: const Icon(Icons.add),
      ),
      body: BooksWidgetCard(
        horizontalView: horizontalView,
        user: widget.user,
      ),
    );
  }
}
