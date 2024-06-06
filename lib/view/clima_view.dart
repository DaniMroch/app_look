//import 'package:app_look/view/principalview.dart';
import 'package:app_look/view/principal_view.dart';
import 'package:flutter/material.dart';

class ClimaView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Selecione o Clima'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Clima('Frio'),
              SizedBox(height: 10),
              Clima('Calor'),
              SizedBox(height: 10),
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
                    onPressed: () {
                      Navigator.pushNamed(context, 'save');
                    },
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

class Clima extends StatelessWidget {
  final String clima;

  Clima(this.clima);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      },
      child: Text(clima),
    );
  }
}
