import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  void navigateToMoodScreen(BuildContext context, String mood) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MoodScreen(mood: mood),
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
              onPressed: () => navigateToMoodScreen(context, 'irritado'),
              child: Text('Irritado'),
            ),
            ElevatedButton(
              onPressed: () => navigateToMoodScreen(context, 'calmo'),
              child: Text('Calmo'),
            ),
          ],
        ),
      ),
    );
  }
}

class MoodScreen extends StatelessWidget {
  final String mood;

  MoodScreen({required this.mood});

  final Map<String, String> moodImages = {
    'alegre': 'assets/alegre.png',
    'triste': 'assets/triste.png',
    'irritado': 'assets/irritado.png',
    'calmo': 'assets/calmo.png'
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seu humor: $mood'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(moodImages[mood]!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode implementar a lógica para salvar a imagem ou estado de humor
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
