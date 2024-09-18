import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_biblioteca/firebase_options.dart';
import 'package:flutter_biblioteca/screens/home_screen.dart';
import 'package:flutter_biblioteca/screens/login_screen.dart';
import 'package:get/get.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Biblioteca',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const RoteadorTelas(),
    );
  }
}
class RoteadorTelas extends StatelessWidget{
  const RoteadorTelas({super.key});
  
  
  @override
  Widget build(BuildContext context){
    return StreamBuilder(stream: FirebaseAuth.instance.userChanges(), builder:(context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(
          child: CircularProgressIndicator() ,
          );
      }else{
        if (snapshot.hasData){
          return HomeScreen(user: snapshot.data!);
        } else{
          return LoginScreen();
        }
      }
    });
  }
}





