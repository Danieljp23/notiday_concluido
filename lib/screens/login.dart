import 'package:firebase_auth/firebase_auth.dart';
import 'package:notiday_1/components/decoracao.dart';
import 'package:notiday_1/firebase/criausuario.dart';
import 'package:notiday_1/main.dart';
import 'package:notiday_1/screens/recuperasenha.dart';
import 'package:notiday_1/screens/registrar.dart';
import 'package:notiday_1/screens/termos_politicas.dart';
import 'package:notiday_1/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';

//Arquivo main, contendo a classe com nome do app.

//class _NotidayState que recebe por herança a mudança de estado da classe Notiday.
class _NotidayState extends State<Notiday> {
  final AutenticaUser _sign_in = AutenticaUser();
  _NotidayState createState() {
    return _NotidayState();
  }

  TextEditingController _loginController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final AutenticaUser _login = AutenticaUser();
  final bool queroEntrar = true;
//função _permitir valores, faz a atualização através do setState dos valores das variáveis,
// e retorna se o text foi preenchido dentro do TextField..

  login() {
    
    String email = _loginController.text;
    String senha = _senhaController.text;
    
    if (_formKey.currentState!.validate()) {
      if (queroEntrar) {
        _sign_in.logarUsuarios(email:email, senha: senha).then((String ? isErro) {
          if(isErro!=null){
            mostrarSnackBarLogin(context: context, texto: isErro);
          }
            
          
        });
      } else {
        _sign_in.autenticaUsuario(
          email: email,
          senha: senha,
        ).then((String? isErro) {
if(isErro != null){
mostrarSnackBarLogin(context: context, texto: isErro);
}
        },
        );
      }
    } else {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg_recuperasenha.png'),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                Container(
                  width: 400,
                  height: 70,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/logo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 70,
                ),

                //nome do app

                // container para atribuir um padding e assegurar o tamanho dos elementos e conjuntos de widget.
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //padding para adicionar uma borda interna ao elemento de 4 pixels, utilizado em ambos TextField.
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                             keyboardType: TextInputType.emailAddress,
                            controller: _loginController,
                            decoration: getDecorationInput("Login"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextFormField(
                            keyboardType: TextInputType.text,obscureText: true,
                            controller: _senhaController,
                            decoration: getDecorationInput("Senha"),
                          ),
                        ),
                        Row(
                          //mainaxiAligmente para alinhar atraves do spaceEvenly,
                          // que faz alinhamento do centro para extremidade alinhando os espaços cimétricamente.
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            //textbutton que vai direcionar ao e-mail para enviar a nova senha.
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => RecuperaSenha()),
                                );
                              },
                              child: const Text(
                                'Esqueceu sua senha?',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 243, 166, 0),
                                  foregroundColor: Colors.black),
                              onPressed: () {
                                login();
                              },
                              child: const Text(
                                "Entrar",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ), //padding envolvendo elementos de uma row para determinar margens internas de 20 pixels.
               const Padding(
                  padding: EdgeInsets.all(8.0),
                  //row fazendo alinhamento ao fim da tela com 3 elementos
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  ],
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: Colors.black),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Registrar()),
                    );
                  },
                  child: const Text(
                    'REGISTRAR-SE',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFF3A600),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.black),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => TermosPoliticas()),
                      );
                    },
                    child: const Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Text('Termos e Políticas'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Class super
class Notiday extends StatefulWidget {
  const Notiday({super.key});


   @override
  _NotidayState createState() {
    return _NotidayState();
  }
}
class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset("assets/NOTIDAY.gif",
      ),
      logoWidth:120,
      // icone de carregamento
     loaderColor: Colors.white,
      durationInSeconds: 5,
      navigator: const RoteadorTela(), // Aqui colocamos o que deve ser aberto após o Splash
    );
  }
}
