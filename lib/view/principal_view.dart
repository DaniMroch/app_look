// ignore_for_file: prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';

import '../controller/favorito_controller.dart';
import '../controller/login_controller.dart';
import 'pasta_view.dart';

class ClimatePage extends StatelessWidget {
  const ClimatePage({super.key});

  void navigateToMoodPage(BuildContext context, String climate) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoodSelectionPage(climate: climate),
      ),
    );
  }

  /// Funcoes dos botoes Sobre, pasta do usuario , e gerar imagens aleatorias ///
  void sobreDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sobre'),
          content: Text(
              'Este é um aplicativo de moda baseado no humor que tem o objetivo de inspirar os usuarios, e promover a facilidade na hora de decidir um traje, além disso, o uso da cromoterapia (cores que harmonizam) nos trajes pode influenciar o humor e melhorar o astral.Desenvolvido por: Daniela Rocha e Tomas Veiga'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void navigateToMyFolder(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyFolderPage(),
      ),
    );
  }

  void generateRandomImage(BuildContext context) {
    final images = ['alegre', 'triste', 'calmo', 'irritado'];
    final random = Random();
    final randomImage = images[random.nextInt(images.length)];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            MoodScreen(climate: 'aleatório', mood: randomImage),
      ),
    );
  }

  /// Tela para escolher o clima em seguida o humor ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clima'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => sobreDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () => navigateToMyFolder(context),
          ),
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () => generateRandomImage(context),
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              LoginController().logout();
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => navigateToMoodPage(context, 'frio'),
              child: Text('Frio'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => navigateToMoodPage(context, 'calor'),
              child: Text('Calor'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tela para selecionar o humor ///
class MoodSelectionPage extends StatelessWidget {
  final String climate;

  MoodSelectionPage({required this.climate});

  void navigateToMoodScreen(BuildContext context, String mood) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoodScreen(climate: climate, mood: mood),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha seu humor'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => navigateToMoodScreen(context, 'alegre'),
              child: Text('Alegre'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => navigateToMoodScreen(context, 'triste'),
              child: Text('Triste'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => navigateToMoodScreen(context, 'calmo'),
              child: Text('Calmo'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => navigateToMoodScreen(context, 'irritado'),
              child: Text('Irritado'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tela que gera imagem relacionada ao humor ///
class MoodScreen extends StatelessWidget {
  final String climate;
  final String mood;
  final FavoritesController _favoritesController = FavoritesController();

  MoodScreen({required this.climate, required this.mood});

  final Map<String, String> moodImages = {
    'alegre': 'assets/alegre.png',
    'triste': 'assets/triste.png',
    'calmo': 'assets/calmo.png',
    'irritado': 'assets/irritado.png',
  };

  final Map<String, String> moodImagesFrio = {
    'alegre': 'assets/alegre_frio.png',
    'triste': 'assets/triste_frio.png',
    'calmo': 'assets/calmo_frio.png',
    'irritado': 'assets/irritado_frio.png',
  };

  @override
  Widget build(BuildContext context) {
    Map<String, String> selectedMoodImages;

    if (climate == 'frio') {
      selectedMoodImages = moodImagesFrio;
    } else if (climate == 'calor') {
      selectedMoodImages = moodImages;
    } else {
      // Para o caso 'aleatório', escolhemos um conjunto de imagens aleatoriamente
      final random = Random();
      selectedMoodImages = random.nextBool() ? moodImagesFrio : moodImages;
    }
    String imagePath = selectedMoodImages[mood]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Seu humor: $mood'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cores quentes como Vermelho, Laranjado e Amarelo podem estimular criatividade, motivacao e inspiracao.Cores frias como Verde, Azul e Violeta podem transmitir equilibrio, tranquilidade, harmonia',
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
            Text(
              'Clima: $climate',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Image.asset(imagePath),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // trecho para salvar a imagem na pasta

                await _favoritesController.saveFavoriteImage(imagePath);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Imagem salva com sucesso!'),
                  ),
                );
              },
              child: Icon(Icons.favorite),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pasta que armazena as imagens salvas ///
/*class MyFolderPage extends StatelessWidget {
  final FavoritesController _favoritesController = FavoritesController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Pasta'),
      ),
      body: StreamBuilder<List<String>>(
        stream: _favoritesController.getFavoriteImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar imagens'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhuma imagem favoritada.'));
          }

          List<String> favoriteImages = snapshot.data!;

          return ListView.builder(
            itemCount: favoriteImages.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset(favoriteImages[index]),
                title: Text('Imagem Favorita ${index + 1}'),
              );
            },
          );
        },
      ),
    );
  }
}*/
