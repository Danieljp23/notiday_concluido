import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notiday_1/firebase_options.dart';

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Firebase Storage',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.yellow,
              brightness: Brightness.dark,
            ),
            home: StoragePage(),
          );
        }

        if (snapshot.hasError) {
          return ErrorPage();
        }

        return LoadingPage();
      },
    );
  }
}

class StoragePage extends StatelessWidget {
  const StoragePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Implemente sua página de armazenamento aqui
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Implemente sua página de erro aqui
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Implemente sua página de carregamento aqui
    );
  }
}
