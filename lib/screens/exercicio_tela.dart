import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notiday_1/Objetos/Compromissos.dart';
import 'package:notiday_1/components/decoracao.dart';
import 'package:notiday_1/components/paleta_cores.dart';
import 'package:notiday_1/main.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

String colecao = '';
 Color selectedColor = Colors.white;

class CompromissoTela extends StatefulWidget {
  final Compromisso compromisso;
  CompromissoTela({Key? key, required this.compromisso}) : super(key: key);

  @override
  _CompromissoTelaState createState() => _CompromissoTelaState();
}

class _CompromissoTelaState extends State<CompromissoTela> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _assuntoController = TextEditingController();
  TextEditingController _horarioController = TextEditingController();
  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _enderecoController = TextEditingController();
  TextEditingController _dataController = TextEditingController();
  TextEditingController _corController = TextEditingController();
  TextEditingController _cepController = TextEditingController();
  TextEditingController _numeroCasaController = TextEditingController();


  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String _selectedPeriodo = '';
  Color _colordoCompromisso = Colors.transparent;

  @override
  void initState() {
    super.initState();
    _idController.text = widget.compromisso.id;
    _assuntoController.text = widget.compromisso.assunto;
    _horarioController.text = widget.compromisso.horario;
    _descricaoController.text = widget.compromisso.descricao;
    _enderecoController.text = widget.compromisso.endereco;
    _dataController.text = widget.compromisso.data;
    _corController.text = widget.compromisso.cor!;
    _cepController.text = widget.compromisso.cep;
    _numeroCasaController.text = widget.compromisso.numeroCasa;
    _selectedPeriodo = widget.compromisso.periodo;
  }
void _onCepChanged() {
    final cep = _cepController.text;
    if (cep.length == 8) { // Verifique se o CEP tem 8 dígitos
      onAddressFromCEP(cep, (endereco) {
        setState(() {
          _enderecoController.text = endereco ?? 'Endereço não encontrado';
        });
      });
    }
  }

  void onAddressFromCEP(String cep, Function(String?) onAddressFetched) async {
    final url = 'https://viacep.com.br/ws/$cep/json/';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        onAddressFetched(data['logradouro']);
      } else {
        print('Erro ao localizar o endereço');
        onAddressFetched(null);
      }
    } catch (e) {
      print('Erro: $e');
      onAddressFetched(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _selectedColor;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 243, 166, 0),
      appBar: AppBar(
        title: Container(
          padding: const EdgeInsets.all(90),
          child: TextField(
            controller: _assuntoController,
            readOnly: true, // Define o TextField como somente leitura
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 72,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(32),
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              // Salvar as alterações
              _salvarAlteracoes(context);
            },
            child: Icon(Icons.save),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              // Excluir o compromisso
              _excluirCompromisso(context);
            },
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
          ),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ListView(
          children: [
            const Text(
              "Assunto:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _assuntoController,
              maxLines: null,
              decoration: getDecorationInput("Nome")
            ),
            const SizedBox(height: 16),
            const Text(
              "Descrição:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _descricaoController,
              maxLines: null,
              decoration: getDecorationInput("Digite a descrição do compromisso")
            ),
             const SizedBox(height: 16),
           
          const SizedBox(height: 8),
          TextField(
            keyboardType: TextInputType.number,
             onChanged: (value) {
                    if (value.length == 8) {
                      onAddressFromCEP(value, (address) {
                        setState(() {
                          _enderecoController.text = address!;
                        });
                      });
                    }
                  },
            controller: _cepController,
            maxLines: 1,
            decoration: getDecorationInput("CEP:")
          ),
          const SizedBox(height: 16),
          const Text(
            "Endereço:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _enderecoController,
            maxLines: null,
            decoration: getDecorationInput("Digite o endereço do compromisso")
            ),
            const SizedBox(height: 16),
            const Text(
              "Numero:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
           TextField(
              controller: _numeroCasaController,
              maxLines: null,
              keyboardType: TextInputType.number,
              decoration: getDecorationInput("Digite o numero do compromisso")
            ),
            const SizedBox(height: 16),
            const Text(
              "Horario:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
          GestureDetector(
                onTap: () {
                  DatePicker.showTimePicker(
                    context,
                    currentTime: DateTime.now(),
                    onConfirm: (time) {
                      setState(() {
                        _horarioController.text = DateFormat('HH:mm').format(time);
                      });
                    },
                    locale: LocaleType.pt,
                  );
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _horarioController,
                    decoration: const InputDecoration(
                      hintText: "Hora",
                      prefixIcon: Icon(Icons.access_time, color: Colors.black),
                    ),
                    validator: (String? value) {
                      if (value == "") {
                        return "Campo obrigatório!";
                      }
                      if (value!.length < 3) {
                        return "Hora inválida!";
                      }
                    },
                    keyboardType: TextInputType.datetime,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              "Data:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
         Container(
                margin: const EdgeInsets.only(left: 14),
                child: GestureDetector(
                  onTap: () async {
                    final DateTime? selectedDate =
                        await showModalBottomSheet<DateTime>(
                      context: context,
                      isDismissible: false,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              padding: const EdgeInsets.all(32),
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TableCalendar(
                                    firstDay: DateTime.utc(2010, 10, 16),
                                    lastDay: DateTime.utc(2030, 3, 14),
                                    focusedDay: DateTime.now(),
                                    selectedDayPredicate: (day) {
                                      return isSameDay(_selectedDay, day);
                                    },
                                    onDaySelected: (selectedDay, focusedDay) {
                                      setState(() {
                                        _selectedDay = selectedDay;
                                      });
                                    },
                                    calendarFormat: _calendarFormat,
                                    onFormatChanged: (format) {
                                      setState(() {
                                        _calendarFormat = format;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  //Botão enviar dentro do calendário
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context, _selectedDay);
                                    },
                                    child: const Text('Enviar'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _selectedDay = selectedDate;
                        _dataController.text =
                            DateFormat('dd/MM/yyyy').format(selectedDate);
                      });
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month),
                      const SizedBox(width: 8),
                      Text(
                        _selectedDay != null
                            ? DateFormat('dd/MM/yyyy').format(_selectedDay!)
                            : 'Selecione a data',
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),
            const Text(
              "Período:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedPeriodo.isNotEmpty ? _selectedPeriodo : null,
              items: ['Manhã', 'Tarde', 'Noite'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedPeriodo = newValue!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                  hintText: "Escolha o periodo do  compromisso",
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 8),
                const Text(
              " Editar Cor:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
             InkWell(
               onTap: ()async {
                 final cordoCompromisso = await
                   showpredefinedColors(context);
                 if (cordoCompromisso != null) {
                   setState(() {
                     _colordoCompromisso = cordoCompromisso as Color;
                   });
                 }
               },
               child: Container(
                 height: 40,width: 40,
                 padding: const EdgeInsets.symmetric(
                     vertical: 10.0, horizontal: 12.0),
                 decoration: BoxDecoration(
                   border: Border.all(color: Colors.black),
                   borderRadius: BorderRadius.circular(8.0),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     const SizedBox(width: 5),
                     Container(
                       width: 20,
                       height: 20,
                       decoration: BoxDecoration(
                         color: _colordoCompromisso ??
                             Colors.transparent,
                         border: Border.all(color: Colors.grey),
                       ),
                     ),
                     const Icon(Icons.arrow_drop_down),
                   ],
                 ),
               ),
             ),
          ],
        ),
      ),
    );
  }
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
  void _salvarAlteracoes(BuildContext context) async {
    try {
      // Obtém uma referência para a coleção 'compromissos' no Firestore
      CollectionReference compromissos = FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid);
          String? corHex;
    if (_colordoCompromisso != null) {
      corHex = colorToHex(
          _colordoCompromisso!); // Convertendo Color para string hexadecimal
    } else {
      corHex = null; // Ou qualquer valor padrão que você queira
    }

      // Salva os dados do compromisso no Firestore
      await compromissos.doc(widget.compromisso.id).update({
        'assunto': _assuntoController.text,
        'horario': _horarioController.text,
        'descricao': _descricaoController.text,
        'endereco': _enderecoController.text,
        'id': _idController.text,
        'cep': _cepController.text,
        'numeroCasa': _numeroCasaController.text,
        'data': _dataController.text,
        'periodo': _selectedPeriodo,
        'cor': corHex,
      }).then((_) {
        // Exibe uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Alterações salvas com sucesso!'),
        ));
        // Retorna para a página inicial
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MyApp(),
        ));
      }).catchError((error) {
        // Exibe uma mensagem de erro se houver algum problema ao salvar os dados
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro ao salvar as alterações: $error'),
          backgroundColor: Colors.red,
        ));
      });
    } catch (e) {
      // Exibe uma mensagem de erro se houver algum problema ao salvar os dados
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao salvar as alterações: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _excluirCompromisso(BuildContext context) async {
    try {
      // Obtém uma referência para a coleção 'compromissos' no Firestore
      CollectionReference compromissos = FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid);

      // Exclui o compromisso do Firestore
      await compromissos.doc(widget.compromisso.id).delete().then((_) {
        // Exibe uma mensagem de sucesso
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Compromisso excluído com sucesso!'),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).pop();
      }).catchError((error) {
        // Exibe uma mensagem de erro se houver algum problema ao excluir o compromisso
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Erro ao excluir o compromisso: $error'),
          backgroundColor: Colors.red,
        ));
      });
    } catch (e) {
      // Exibe uma mensagem de erro se houver algum problema ao excluir o compromisso
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao excluir o compromisso: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void dispose() {
    _assuntoController.dispose();
    _horarioController.dispose();
    _descricaoController.dispose();
    _enderecoController.dispose();
    _cepController.dispose();
    _dataController.dispose();
    _numeroCasaController.dispose();
    _corController.dispose();
    super.dispose();
  }


    // Defina uma cor padrão inicial

// Verifique se o valor retornado não é nulo antes de usá-lo


  

  


Future<String> getCollectionsForCurrentUser() async {
  // Verifique se há um usuário autenticado
  String colecao = '';
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    // Acesse o Firestore e consulte as coleções do usuário atual
    QuerySnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('collections')
        .get();

    // Itere sobre os documentos retornados e imprima o nome das coleções
    userDoc.docs.forEach((doc) {
      colecao = doc.id;
    });
  }

  print('oiee $colecao');
  return colecao;
  
}
}



  
