import 'dart:math';
import 'package:flutter/material.dart';

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

  void showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sobre'),
          content:
              Text('Este é um aplicativo de humor. Escolha seu clima e humor.'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Escolha o clima'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () => showAboutDialog(context),
          ),
          IconButton(
            icon: Icon(Icons.folder),
            onPressed: () => navigateToMyFolder(context),
          ),
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () => generateRandomImage(context),
          ),
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
            ElevatedButton(
              onPressed: () => navigateToMoodScreen(context, 'triste'),
              child: Text('Triste'),
            ),
            ElevatedButton(
              onPressed: () => navigateToMoodScreen(context, 'calmo'),
              child: Text('Calmo'),
            ),
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

class MoodScreen extends StatelessWidget {
  final String climate;
  final String mood;

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
    'irritado': 'assets/irritado.png',
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Seu humor: $mood'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Clima: $climate',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Image.asset(selectedMoodImages[mood]!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement logic to save the mood or state
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Humor salvo com sucesso!'),
                  ),
                );
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyFolderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Placeholder for the user's saved images folder
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Pasta'),
      ),
      body: Center(
        child: Text('Aqui estarão as imagens salvas do usuário.'),
      ),
    );
  }
}
