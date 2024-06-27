
import 'dart:core';
import 'package:flutter/material.dart';


//lógica para aparecer o modal das cores
Future<Color?> showpredefinedColors(BuildContext context) async {
  Color? _selectedColor;

  final selectedColor = await showDialog<Color>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Selecione uma cor'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    
                    border: Border.all(color:_selectedColor ?? Colors.white,width: 10),
                  ),
                  child: PaletaCores(
                    onColorSelected: (color, colorName) {
                      setState(() {
                        _selectedColor = color;
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(Colors.transparent);
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(_selectedColor);
            },
            child: const Text('Salvar'),
          ),
        ],
      );
    },
  );
  if (_selectedColor != null) {
    // A cor selecionada foi retornada. Aqui você pode usar o valor.
    return _selectedColor;
  }
}

String getColorName(Color color) {
  if (color == Colors.pink) return 'Rosa';
  if (color == Colors.blue) return 'Azul';
  if (color == const Color.fromARGB(255, 255, 234, 0)) return 'Amarelo';
  if (color == Colors.green) return 'Verde';
  if (color == Colors.purple) return 'Roxo';
  if (color == Colors.red) return 'Vermelho';
  if (color == Colors.orange) return 'Laranja';
  if (color == Colors.grey) return 'Cinza';
  if (color == const Color.fromARGB(255, 0, 243, 215)) return 'Turquesa';
  return 'Cor desconhecida';
}

class PaletaCores extends StatefulWidget {
  final Function(Color, String) onColorSelected;

  const PaletaCores({required this.onColorSelected, super.key});

  @override
  State<PaletaCores> createState() => _PaletaCoresState();
}

class _PaletaCoresState extends State<PaletaCores> {
  List<Color> colors = [
    Colors.pink,
    Colors.blue,
    Color.fromARGB(255, 255, 234, 0),
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.orange,
    Colors.grey,
    const Color.fromARGB(255, 0, 243, 215),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(
        colors.length,
        (index) {
          final colorName = getColorName(colors[index]);
          return GestureDetector(
            onTap: () {
              widget.onColorSelected(colors[index], colorName);
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                color: colors[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
