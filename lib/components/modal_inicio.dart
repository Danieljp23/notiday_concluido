import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:intl/intl.dart';
import 'package:notiday_1/Objetos/Compromissos.dart';
import 'package:notiday_1/components/decoracao.dart';
import 'package:notiday_1/components/minhas_cores.dart';
import 'package:notiday_1/conection/firestore_servi%C3%A7o.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notiday_1/components/paleta_cores.dart';

// API do cep
void onAddressFromCEP(String cep, Function(String) onAddressFetched) async {
  final url = 'https://viacep.com.br/ws/$cep/json/';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      onAddressFetched(data['logradouro']);
    }
  } catch (e) {}
}

void mostrarModalInicio(BuildContext context, {Compromisso? compromisso}) {
  showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      builder: (context) {
        return TelaCadastroCompromisso(
          onAddressFetched: (String adress) {},
          compromisso: compromisso,
        );
      });
}

class TelaCadastroCompromisso extends StatefulWidget {
  final Function(String) onAddressFetched;

  final Compromisso? compromisso;
  const TelaCadastroCompromisso({
    super.key,
    required this.onAddressFetched,
    required this.compromisso,
  });
  @override
  _TelaCadastroCompromissoState createState() =>
      _TelaCadastroCompromissoState();
}

class _TelaCadastroCompromissoState extends State<TelaCadastroCompromisso> {
  TextEditingController assuntoCTR = TextEditingController();
  TextEditingController horarioCTR = TextEditingController();
  TextEditingController descricaoCTR = TextEditingController();
  TextEditingController dataCTR = TextEditingController();
  TextEditingController enderecoCTR = TextEditingController();
  TextEditingController numeroCasaCTR = TextEditingController();
  TextEditingController cepCTR = TextEditingController();
  TextEditingController periodoCTR = TextEditingController();

  List<String> _periodos = ['Manhã', 'Tarde', 'Noite'];

  Color _colordoCompromisso = Colors.transparent;

  bool isCarregando = false;
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  String _selectedPeriodo = '';

  final _formKey = GlobalKey<FormState>();

  CompromissoServico _compromissoServico = CompromissoServico();

  bool validado = false;

  bool isSameDay(DateTime? selected, DateTime day) {
    return selected?.day == day.day &&
        selected?.month == day.month &&
        selected?.year == day.year;
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

  //função que converte para hexadecimal as cores
  String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  void enviarClicado() {
    String assunto = assuntoCTR.text;
    String descricao = descricaoCTR.text;
    String cep = cepCTR.text;
    String endereco = enderecoCTR.text;
    String numeroCasa = numeroCasaCTR.text;
    String horario = horarioCTR.text;
    String data = dataCTR.text;
    String periodo = periodoCTR.text;

    String? corHex;
    if (_colordoCompromisso != null) {
      corHex = colorToHex(
          _colordoCompromisso!); // Convertendo Color para string hexadecimal
    } else {
      corHex = null; // Ou qualquer valor padrão que você queira
    }

    Compromisso compromisso = Compromisso(
      id: const Uuid().v1(),
      assunto: assunto,
      descricao: descricao,
      cep: cep,
      endereco: endereco,
      numeroCasa: numeroCasa,
      horario: horario,
      data: data,
      periodo: periodo,
      cor: corHex,
    );
    if (_formKey.currentState!.validate()) {
      _compromissoServico.adicionarCompromisso(compromisso).then((value) {
        setState(() {
          isCarregando = false;
        });
        Navigator.of(context).popUntil((route) => route.isFirst);
      });
    } else {}
  }

  void _updateSelectedPeriodo(String periodo) {
    setState(() {
      _selectedPeriodo = periodo;
      periodoCTR.text = periodo;
    });
  }

  //Lógica período
  void _showPeriodoOptions(BuildContext context) async {
    final selectedValue = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Selecione o período'),
          content: SingleChildScrollView(
            child: ListBody(
              children: _periodos.map((periodo) {
                return ListTile(
                  title: Text(periodo),
                  onTap: () {
                    setState(() {
                      _selectedPeriodo = periodo;
                      periodoCTR.text = periodo;
                    });
                    Navigator.of(context).pop(periodo);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    if (widget.compromisso != null) {
      assuntoCTR.text = widget.compromisso!.assunto;
      descricaoCTR.text = widget.compromisso!.descricao;
      horarioCTR.text = widget.compromisso!.horario;
      dataCTR.text = widget.compromisso!.data;
      enderecoCTR.text = widget.compromisso!.endereco;
      cepCTR.text = widget.compromisso!.cep;
      numeroCasaCTR.text = widget.compromisso!.numeroCasa;
      periodoCTR.text = widget.compromisso!.periodo;
    }
    super.initState();
  }

//Cadastrar compromisso
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            MinhasCores.azultop,
            MinhasCores.azulmedio,
            MinhasCores.azulbaixo
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height * 0.8,
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "                 Criar Compromisso",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black, // cor do x
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    controller: assuntoCTR,
                    decoration: getDecorationInput(
                      "Assunto",
                    ),
                    validator: (String? value) {
                      if (value == "") {
                        return "Campo obrigatório!";
                      }
                      if (value!.length < 3) {
                        return "Assunto inválido!";
                      }
                    },
                    maxLines: null,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Descrição
                  TextFormField(
                    controller: descricaoCTR,
                    decoration: getDecorationInput(
                      "Descrição",
                    ),
                    validator: (String? value) {
                      if (value == "") {
                        return "Campo obrigatório!";
                      }
                      if (value!.length < 3) {
                        return "Descrição inválida!";
                      }
                    },
                    maxLines: null,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //Cep
                  TextFormField(
                    controller: cepCTR,
                    decoration: getDecorationInput(
                      "CEP",
                    ),
                    validator: (String? value) {
                      if (value == "") {
                        return "Campo obrigatório!";
                      }
                      if (value!.length < 3) {
                        return "CEP inválido!";
                      }
                    },
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (value.length == 8) {
                        onAddressFromCEP(value, (address) {
                          setState(() {
                            enderecoCTR.text = address;
                          });
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ), //Endereço
                  TextFormField(
                    controller: enderecoCTR,
                    decoration: getDecorationInput(
                      "Endereço",
                    ),
                    validator: (String? value) {
                      if (value == "") {
                        return "Campo obrigatório!";
                      }
                      if (value!.length < 3) {
                        return "Endereço inválido!";
                      }
                    },
                    maxLines: null,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //Número
                  TextFormField(
                    controller: numeroCasaCTR,
                    decoration: getDecorationInput(
                      "Número",
                    ),
                    validator: (String? value) {
                      if (value == "") {
                        return "Campo obrigatório!";
                      }
                      if (value!.length < 2) {
                        return "Número inválido!";
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),

              // Hora
              const SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  DatePicker.showTimePicker(
                    context,
                    currentTime: DateTime.now(),
                    onConfirm: (time) {
                      setState(() {
                        horarioCTR.text = DateFormat('HH:mm').format(time);
                      });
                    },
                    locale: LocaleType.pt,
                  );
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: horarioCTR,
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
              const SizedBox(
                height: 10,
              ),
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
                        dataCTR.text =
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
              const SizedBox(height: 35),

              //periodo
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          _showPeriodoOptions(context);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 20,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                _selectedPeriodo.isEmpty
                                    ? 'Periodo'
                                    : _selectedPeriodo,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.arrow_drop_down),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //COR
                    const SizedBox(width: 8),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final cordoCompromisso =
                              await showpredefinedColors(context);
                          if (cordoCompromisso != null) {
                            setState(() {
                              _colordoCompromisso = cordoCompromisso as Color;
                            });
                          }
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(Icons.color_lens),
                              const Text(
                                "Cor",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color:
                                      _colordoCompromisso ?? Colors.transparent,
                                  border: Border.all(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Botão salvar do layout
              ButtonBar(
                mainAxisSize: MainAxisSize.max,
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      enviarClicado();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 243, 166, 0)),
                    child: const Text(
                      'Criar',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}