import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Humor Options'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Humor('Happy', 'happy_image.jpg'),
              SizedBox(height: 10),
              Humor('Sad', 'sad_image.jpg'),
              SizedBox(height: 10),
              Humor('Calm', 'calm_image.jpg'),
              SizedBox(height: 10),
              Humor('Irritated', 'irritated_image.jpg'),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.folder),
                    onPressed: () {},
                  ),
                  Text(
              'Minha Pasta',
              style: TextStyle(fontSize: 10),
            ),
                ],
              ),
               
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      // Generate random images (simulated)
                      print('Generating random images...');
                    },
                  ),
                  Text(
              'Gerar aleatorio',
              style: TextStyle(fontSize: 10),
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

class Humor extends StatelessWidget {
  final String humor;
  final String image;

  Humor(this.humor, this.image);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImageScreen(image)),
        );
      },
      child: Text(humor),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String image;

  ImageScreen(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Screen'),
      ),
      body: Center(
        child: Image.asset(image),
      ),
    );
  }
}
