import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_biblioteca/screens/register_screen.dart';
import 'package:flutter_biblioteca/utils/dialog_utils.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _senhaController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _senhaController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> validaLogin() async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _senhaController.text.trim(),
        );
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'user-not-found':
            showCustomDialog(
              title: 'Oops, tem certeza?',
              message: 'Usuário não encontrado!',
              onConfirm: () {
                Get.back();
              },
              showCancelButton: false,
            );
            break;
          case 'wrong-password':
          case 'invalid-credential':
            showCustomDialog(
              title: 'Oops, tem certeza?',
              message: 'Usuário ou senha incorretos!',
              onConfirm: () {
                Get.back();
              },
              showCancelButton: false,
            );
            break;

          case 'channel-error':
            showCustomDialog(
              title: 'Informações faltando!',
              message: 'Preencha seu e-mail e sua senha!',
              onConfirm: () {
                Get.back();
              },
              showCancelButton: false,
            );
            break;
          case 'INVALID_LOGIN_CREDENTIALS':
            showCustomDialog(
              title: 'Oops, tem certeza?',
              message: 'Usuário ou senha incorretos!',
              onConfirm: () {
                Get.back();
              },
              showCancelButton: false,
            );
            break;
          default:
            showCustomDialog(
              title: 'Oops, não foi possível autenticar!',
              message: 'Ocorreu um erro ao entrar.',
              onConfirm: () {
                Get.back();
              },
              showCancelButton: false,
            );
            break;
        }
      } catch (e) {
        showCustomDialog(
          title: 'Oops, não foi possível autenticar!',
          message: '$e',
          onConfirm: () {
            Get.back();
          },
          showCancelButton: false,
        );
      }
    }

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
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: validaLogin,
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Colors.blue),
                        minimumSize: WidgetStatePropertyAll<Size>(
                            Size(double.infinity, 50)),
                      ),
                      child: Text(
                        'Entrar',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        style: const ButtonStyle(
                          minimumSize: WidgetStatePropertyAll<Size>(
                              Size(double.infinity, 50)),
                          backgroundColor:
                              WidgetStatePropertyAll<Color>(Colors.white),
                          side: WidgetStatePropertyAll(
                            BorderSide(
                              color: Colors.blue, // Cor da borda
                              width: 2.0, // Largura da borda
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: Text('Entrar com Google',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue,
                            ))), //Trocar pela Logo do Google
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()));
                      },
                      child: Text(
                          'Ainda não tem uma conta? Clique aqui para criar',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue.shade700,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
