import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notiday_1/components/decoracao.dart';
import 'package:notiday_1/firebase/criausuario.dart';
import 'package:notiday_1/components/snackbar.dart';




class _RegistrarState extends State<Registrar> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmaSenhaController =
      TextEditingController();
  bool aceito = false;
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;
  bool validado = false;
  final AutenticaUser _autenticaUser = AutenticaUser();

//função de cadastro no firebase, no modo cloud firestore
 
  //função de cadastro do usuário, utilizando o Authentication do firebase
  cadastraUsuarioAuth(){
    String email = _emailController.text;
    String senha = _senhaController.text;
     _autenticaUser.autenticaUsuario(
         email: email,
         senha: senha
       
       ).then(
        (String? erro) {
        if (erro!= null){
        mostrarSnackBar(context: context, texto: erro);
        }else{
          //deu certo
          mostrarSnackBarRegistrar(context: context, texto:  "Cadastro efetuado com sucesso");
          
        }
       },
       );
  }
  //função que irá validar os campos do formulário
   checkedBox() {
    String email = _emailController.text;
    String senha = _senhaController.text;
   
    
    if (_formKey.currentState!.validate()) {
       return validado = true;
    } else {
    
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
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
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              title: const Row(
                children: [
               
                  SizedBox(width: 90.0),
                  Text(
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
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg_recuperasenha.png'),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: Container(
              width: 600,
              height: 800,
              child: Center(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 50),
                            child: Text(
                              'Cadastro',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _nomeController,
                              decoration: getDecorationInput("NOME"),
                              validator: (String? value) {
                                if (value == "") {
                                  return "Campo obrigatório!";
                                }
                                if (value!.length < 3) {
                                  return "Nome inválido!";
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: _sobrenomeController,
                              decoration: getDecorationInput("SOBRENOME"),
                              validator: (String? value) {
                                if (value == "") {
                                  return "Campo obrigatório!";
                                }
                                if (value!.length < 3) {
                                  return "Sobrenome inválido!";
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailController,
                              decoration: getDecorationInput("E-MAIL"),
                              validator: (String? value) {
                                if (value == "") {
                                  return "Campo obrigatório!";
                                }
                                if (value!.length < 5) {
                                  return "E-mail inválido!";
                                }
                                if (!value.contains("@")) {
                                  return "E-mail inválido!";
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _telefoneController,
                              decoration: getDecorationInput("TELEFONE"),
                              validator: (String? value) {
                                if (value == "") {
                                  return "Campo obrigatório!";
                                }
                                if (value!.length < 10) {
                                  return "Telefone inválido!";
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                               keyboardType: TextInputType.text,
                               obscureText: true,
                              controller: _senhaController,
                              decoration: getDecorationInput("SENHA"),
                              validator: (String? value) {
                                if (value == "") {
                                  return "Digite uma senha, contendo letras, números, caracteres!";
                                }
                                if (value!.length < 8) {
                                  return "Senha deve conter mínimo 8 digitos!";
                                }
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                               keyboardType: TextInputType.text,
                               obscureText: true,
                              controller: _confirmaSenhaController,
                              decoration:
                                  getDecorationInput("CONFIRME SUA SENHA"),
                              validator: (String? value) {
                                if (value == "") {
                                  return "Digite uma senha, contendo letras, números, caracteres!";
                                }
                                if (value!.length < 8) {
                                  return "Senha deve conter mínimo 8 digitos!";
                                }
                                if (_senhaController.text !=
                                    _confirmaSenhaController.text) {
                                  return "As senhas não são iguais!";
                                }
                              },
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                  value: aceito,
                                  onChanged: (bool? value) {
                                    checkedBox();
                                    setState(() {
                                      aceito = value ?? false;
                                   
                                    });
                                  }),
                              const Text('Concordo com os Termos e Políticas')
                            ],
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 243, 166, 0),
                              foregroundColor: Colors.black,
                            ),
                            onPressed: validado 
                                ? () {
                                 //  cadastrarUsuario();
                                 cadastraUsuarioAuth();
                                  }
                                : null,
                            child: const Text(
                              'Registrar',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}

class Registrar extends StatefulWidget {
  _RegistrarState createState() {
    return _RegistrarState();
  }
}
