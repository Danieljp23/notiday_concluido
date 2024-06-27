import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notiday_1/Objetos/Compromissos.dart';
import 'package:notiday_1/conection/firestore_servi%C3%A7o.dart';
import 'package:notiday_1/firebase/criausuario.dart';
import 'package:notiday_1/main.dart';
import 'package:notiday_1/components/modal_inicio.dart';
import 'package:notiday_1/screens/ajuda.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notiday_1/components/carrousel.dart';

import 'package:notiday_1/screens/exercicio_tela.dart';

class Inicio extends StatefulWidget {
  final User user;
  const Inicio({Key? key, required this.user}) : super(key: key);

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final CompromissoServico servico = CompromissoServico();
  final AutenticaUser deslogar = AutenticaUser();

  // Lista de fotos e índice selecionado
  List<String> avatars = [
    'assets/avatar/avatar1.jpg',
    'assets/avatar/avatar2.jpg', // Corrigido o caminho para assets
    'assets/avatar/avatar3.jpg',
    'assets/avatar/avatar4.jpg',
    // Adicione mais caminhos para as suas fotos aqui
  ];

  String? fotoSelecionada;

  bool _ordenarPorOrdemAlfabetica = true;

  get _scaffoldKey => null;

  Color hexToColor(String hexString) {
    // Remove o '#' se estiver presente
    hexString = hexString.replaceFirst('#', '');

    try {
      // Adiciona o valor alfa (opacidade) se não estiver presente na string
      if (hexString.length == 6) {
        hexString = 'FF$hexString';
      }

      // Converte a string hexadecimal para um inteiro
      int hexValue = int.parse(hexString, radix: 16);

      // Cria uma cor a partir do valor inteiro
      return Color(hexValue);
    } catch (e) {
      // Imprime o erro e retorna uma cor padrão (transparente)
      print('Error parsing color: $e');
      return Colors.transparent;
    }
  }

  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            title: Row(
             mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _ordenarPorOrdemAlfabetica = !_ordenarPorOrdemAlfabetica;
                        });
                      },
                      icon: Icon(_ordenarPorOrdemAlfabetica
                          ? Icons.sort_by_alpha
                          : Icons.sort_by_alpha_outlined),
                    ),
                  ],
                ),
          
                Row(
               
                  children: [
                    const Text(
                      '            Notiday',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
               
              ],
            ),
          ),
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Opções',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Selecione uma Foto'),
                            content: Container(
                              width: double.maxFinite,
                              child: GridView.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 10.0,
                                shrinkWrap: true,
                                children: avatars.map((avatarPath) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        fotoSelecionada = avatarPath;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(avatarPath),
                                      radius: 40.0,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: fotoSelecionada != null
                          ? AssetImage(fotoSelecionada!)
                          : null,
                      radius: 40.0,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Ajuda'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AJuda(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Sair do App'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                    (route) => false,
                  );
                } catch (e) {
                  print("Erro ao deslogar: $e");
                }
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_recuperasenha.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: StreamBuilder(
          stream: servico.conectarStreamCompromisso(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData &&
                  snapshot.data != null &&
                  snapshot.data!.docs.isNotEmpty) {
                List<Compromisso> listacompromisso = [];
                for (var doc in snapshot.data!.docs) {
                  listacompromisso.add(
                    Compromisso.fromMap(
                      doc.data(),
                    ),
                  );
                }
                if (_ordenarPorOrdemAlfabetica) {
                  listacompromisso
                      .sort((a, b) => a.assunto.compareTo(b.assunto));
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        itemCount: listacompromisso.length,
                        separatorBuilder: (context, index) => const Divider(color: Colors.transparent,),
                        itemBuilder: (context, index) {
                          Compromisso compromisso = listacompromisso[index];
                          Color corCompromissso = hexToColor(compromisso.cor!);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>CompromissoTela(
                                    compromisso: compromisso,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 60,
                              margin: const EdgeInsets.symmetric(
                                vertical: 8,
                                horizontal: 32,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          compromisso.assunto,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: corCompromissso,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            bottomRight: Radius.circular(16)),
                                      ),
                                      height: 30,
                                      width: 150,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          compromisso.data,
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                        Text(compromisso.horario),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 240,
                      child: Container(
                        width: 1000,
                        height: 1000,
                        child: Carrossel(),
                      ),
                    ),
                  ],
                );
              } else {
                return  Center(
                  child:Image.asset("assets/Nao.png"),
                );
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mostrarModalInicio(context);
        },
        backgroundColor: Color.fromARGB(255, 243, 166, 0),
        foregroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
