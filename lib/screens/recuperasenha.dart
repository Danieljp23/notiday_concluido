import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notiday_1/firebase/criausuario.dart';
import 'package:notiday_1/screens/login.dart';
import 'package:notiday_1/components/decoracao.dart';

class _RecuperaSenhaState extends State<RecuperaSenha> {
  _RecuperaSenhaState createState() {
    return _RecuperaSenhaState();
  }

  final TextEditingController _emailController = TextEditingController();
  AutenticaUser _resetaSenha = AutenticaUser();

  resetaSenha() async {
    String email = _emailController.text;
    _resetaSenha.resetasenha(email: email);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              title: Container(
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Notiday(),
                          ),
                        );
                      },
                      color: Colors.black,
                    ),
                    const SizedBox(width: 90.0),
                    const Text(
                      'Notiday',
                      style: TextStyle(
                          fontFamily: AutofillHints.birthday,
                          fontSize: 30,
                          color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg_recuperasenha.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                 decoration: getDecorationInput("Digite seu E-mail"),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 243, 166, 0),
                        foregroundColor: Colors.black),
                    onPressed: () {
                      resetaSenha();
                    },
                    child: Text('Enviar e-mail'))
              ],
            ),
          ),
        ),
      ),
    );
  }


}

class RecuperaSenha extends StatefulWidget {
  _RecuperaSenhaState createState() {
    return _RecuperaSenhaState();
  }
}
