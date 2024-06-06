// ignore_for_file: prefer_const_constructors

import 'package:app_look/view/clima_view.dart';
import 'package:app_look/view/login_view.dart';
import 'package:app_look/view/principal_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'view/cadastrar_view.dart';
import 'view/clima2_view.dart';
import 'view/saveimage.dart';

Future<void> main() async {
  //
  // Firebase
  //
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Look',
      //rotas de navegacao
      initialRoute: 'login',
      routes: {
        'login': (context) => LoginView(),
        'cadastrar': (context) => CadastrarView(),
        //'principal': (context) => MyHomePage(),
        'principal': (context) => ClimatePage(),
        'save': (context) => SaveImageScreen(),
      },
    );
  }
}
