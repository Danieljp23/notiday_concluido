import 'package:flutter/material.dart';
import 'package:notiday_1/main.dart';


class AJuda extends StatelessWidget {
  final List<String> perguntas = [
    'Como faço para alterar minha senha?',
    'Onde encontro minhas configurações?',
    'Como posso entrar em contato com o suporte?',
    'Qual a versão do aplicativo que estou usando?',
  ];

  final List<String> respostas = [
    'Para alterar sua senha, vá até as configurações de conta.',
    'As configurações podem ser encontradas no menu lateral ou na página do perfil.',
    'Você pode entrar em contato com o suporte através do email suporte@notiday.com.',
    'A versão atual do aplicativo é 2.0.1.',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
                            builder: (context) => MyApp(),
                          ),
                        );
                      },
                      color: Colors.black,
                    ),
                    SizedBox(width: 100.0),
                    Text(
                      'Ajuda',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: perguntas.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ExpansionTile(
                title: Text(
                  perguntas[index],
                  style: TextStyle(fontSize: 18),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      respostas[index],
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(AJuda());
}
