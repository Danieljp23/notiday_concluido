import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notiday_1/firebase_options.dart';
import 'package:notiday_1/screens/login.dart';
import 'package:notiday_1/screens/inicio.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(
     debugShowCheckedModeBanner: false,
    home: Splash(),
    
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home:const RoteadorTela(),
    );
  }
}

class RoteadorTela extends StatelessWidget {
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(stream: FirebaseAuth.instance.userChanges(),
    builder: (context, snapshot) {
      if(snapshot.hasData){
return Inicio(  user: snapshot.data!,);
      }else{
return const Notiday();
      }
    },
    );
  }
}