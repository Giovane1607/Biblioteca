import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class BookForm extends StatefulWidget {
  @override
  _BookFormState createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormBuilderState>();
  int _currentStep = 0; // Índice da etapa atual
  File? _selectedImage; // Para armazenar a imagem selecionada
  String? _uploadedImageUrl; // URL da imagem após upload

  final ImagePicker _picker = ImagePicker();

  //inicializa o estado do formulário
  @override
  void initState() {
    super.initState();
  }

  // Função para selecionar uma imagem
  Future<void> _pickImage() async {
    var suporta = _picker.supportsImageSource(ImageSource.gallery);
    print('Suporta: $suporta');
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      await _uploadImageToFirebase();
    }
  }

  // Função para fazer upload da imagem no Firebase Storage
  Future<void> _uploadImageToFirebase() async {
    if (_selectedImage == null) return;

    try {
      // Nome do arquivo no Firebase Storage
      String fileName = 'books/${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName);

      // Fazendo upload da imagem
      UploadTask uploadTask = firebaseStorageRef.putFile(_selectedImage!);
      TaskSnapshot taskSnapshot = await uploadTask;

      // Obtendo a URL da imagem
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      setState(() {
        _uploadedImageUrl = downloadUrl; // Salva a URL da imagem
      });

      print('Image uploaded: $downloadUrl');
    } catch (e) {
      print('Erro ao fazer upload da imagem: $e');
    }
  }

  // Função para avançar ou retroceder no formulário
  void _onStepContinue() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      if (_formKey.currentState?.saveAndValidate() ?? false) {
        final formData = _formKey.currentState?.value;
        print(formData); // Dados do formulário completos

        // Aqui você pode enviar os dados, incluindo o _uploadedImageUrl
        print('URL da capa do livro: $_uploadedImageUrl');
      }
    }
  }

  void _onStepCancel() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário em Etapas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            // Adiciona rolagem para evitar overflow
            child: Stepper(
              type: StepperType.horizontal,
              currentStep: _currentStep,
              onStepContinue: _onStepContinue,
              onStepCancel: _onStepCancel,
              steps: [
                Step(
                  title: const Text('Dados Gerais'),
                  content: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'nome',
                        decoration:
                            const InputDecoration(labelText: 'Nome do Livro'),
                        validator: FormBuilderValidators.required(),
                      ),
                      FormBuilderTextField(
                        name: 'autor',
                        decoration: const InputDecoration(labelText: 'Autor'),
                        validator: FormBuilderValidators.required(),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 0,
                  state: _currentStep == 0
                      ? StepState.editing
                      : StepState.complete,
                ),
                Step(
                  title: const Text('Publicação'),
                  content: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'editora',
                        decoration: const InputDecoration(labelText: 'Editora'),
                        validator: FormBuilderValidators.required(),
                      ),
                      FormBuilderTextField(
                        name: 'anoPublicacao',
                        decoration: const InputDecoration(
                            labelText: 'Ano de Publicação'),
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.integer(),
                          FormBuilderValidators.max(DateTime.now().year),
                        ]),
                      ),
                      const SizedBox(height: 20),

                      // Seção para o usuário escolher a imagem
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text(_selectedImage == null
                            ? 'Selecionar Capa'
                            : 'Trocar Capa'),
                      ),

                      // Mostra uma miniatura da imagem selecionada, se houver
                      if (_selectedImage != null)
                        Image.file(
                          _selectedImage!,
                          height: 150,
                        ),
                    ],
                  ),
                  isActive: _currentStep >= 1,
                  state: _currentStep == 1
                      ? StepState.editing
                      : StepState.complete,
                ),
                Step(
                  title: const Text('Sinopse'),
                  content: Column(
                    children: [
                      FormBuilderTextField(
                        name: 'sinopse',
                        decoration: const InputDecoration(labelText: 'Sinopse'),
                        maxLines: 5,
                        validator: FormBuilderValidators.required(),
                      ),
                    ],
                  ),
                  isActive: _currentStep >= 2,
                  state: _currentStep == 2
                      ? StepState.editing
                      : StepState.complete,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
