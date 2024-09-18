import 'package:flutter/material.dart';
import 'package:flutter_biblioteca/screens/register_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16),
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
                    SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(hintText: 'E-mail'),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      obscureText: true,
                      controller: _senhaController,
                      decoration: InputDecoration(hintText: 'Senha'),
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Entrar',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Colors.blue),
                        minimumSize: WidgetStatePropertyAll<Size>(
                            Size(double.infinity, 50)),
                      ),
                    ),
                    SizedBox(height: 10),
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
                    SizedBox(height: 16),
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
