import 'package:flutter/material.dart';
import 'package:flutter_biblioteca/services/auth_service.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();
  final TextEditingController _nomeController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'assets/images/Logo.webp',
                        width: 80,
                        height: 80,
                      ),
                    ),
                    TextField(
                      controller: _nomeController,
                      decoration: const InputDecoration(hintText: 'Nome'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      controller: _senhaController,
                      decoration: const InputDecoration(hintText: 'Senha'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      controller: _confirmaSenhaController,
                      decoration:
                          const InputDecoration(hintText: 'Confirme sua senha'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                        onPressed: () {
                          if (_senhaController.text ==
                              _confirmaSenhaController.text) {
                            authService
                                .cadastrarUsuario(
                              email: _emailController.text,
                              senha: _senhaController.text,
                              nome: _nomeController.text,
                            )
                                .then((String? erro) {
                              if (erro != null) {
                                final snackBar = SnackBar(
                                  content: Text(erro),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                Navigator.pop(context);
                              }
                            });
                          } else {
                            const snackBar = SnackBar(
                              content: Text('As senhas não correspondem'),
                              backgroundColor: Colors.red,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: const Text("Cadastrar")),
                    const SizedBox(height: 16),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
