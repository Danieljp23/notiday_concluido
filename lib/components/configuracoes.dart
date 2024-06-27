import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:notiday_1/main.dart';

void main() {
  runApp(Configuracoes());
}

class Configuracoes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: AudioPlayerPage(),
    );
  }
}

class AudioPlayerPage extends StatefulWidget {
  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  final AudioPlayer _player = AudioPlayer();

  String appVersion = '1.0.0'; // Versão do aplicativo

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  // Inicializa o player e carrega os arquivos de áudio
  Future<void> _initializePlayer() async {
    await _player.setAsset('assets/sounds/som1.mp3');
    await _player.setAsset('assets/sounds/som2.mp3');
    await _player.setAsset('assets/sounds/som5.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                    color: Colors.black,
                  ),
                  SizedBox(width: 40.0),
                  Text(
                    'Configurações',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: PopupMenuButton<String>(
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  _buildMenuItem('Opção 1', 'assets/sounds/som1.mp3'),
                  _buildMenuItem('Opção 2', 'assets/sounds/som2.mp3'),
                  _buildMenuItem('Opção 3', 'assets/sounds/som5.mp3'),
                ],
                onSelected: (String asset) => _playSound(asset),
                child: ElevatedButton(
                  onPressed: null,
                  child: Text('Escolha uma opção de som'),
                ),
              ),
            ),
          ),
          Text(
            'Versão: 0.0.10',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Constrói um item de menu para uma opção de toque
  PopupMenuItem<String> _buildMenuItem(String label, String asset) {
    return PopupMenuItem<String>(
      value: asset,
      child: Text(label),
    );
  }

  // Reproduz o som correspondente ao asset especificado
  Future<void> _playSound(String asset) async {
    await _player.stop();
    await _player.setAsset(asset);
    await _player.play();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}
