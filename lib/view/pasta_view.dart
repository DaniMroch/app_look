import 'package:app_look/controller/favorito_controller.dart';
import 'package:flutter/material.dart';

class MyFolderPage extends StatefulWidget {
  @override
  _MyFolderPageState createState() => _MyFolderPageState();
}

class _MyFolderPageState extends State<MyFolderPage> {
  final FavoritesController _favoritesService = FavoritesController();
  final TextEditingController _searchController = TextEditingController();
  int? _searchIndex;
  late Future<List<String>> _favoriteImages;

  @override
  void initState() {
    super.initState();
    _favoriteImages = _favoritesService.getFavoriteImages();
  }

  void _deleteImage(String imagePath) async {
    await _favoritesService.deleteFavoriteImage(imagePath);
    setState(() {
      _favoriteImages = _favoritesService.getFavoriteImages();
    });
  }

  void _searchImage() {
    setState(() {
      _searchIndex = int.tryParse(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Pasta'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Pesquisar por índice',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchImage,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: _favoriteImages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao carregar imagens'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhuma imagem favoritada.'));
                }

                List<String> favoriteImages = snapshot.data!;

                if (_searchIndex != null &&
                    (_searchIndex! < 0 ||
                        _searchIndex! >= favoriteImages.length)) {
                  return Center(child: Text('Índice fora de alcance'));
                }

                return ListView.builder(
                  itemCount: _searchIndex == null ? favoriteImages.length : 1,
                  itemBuilder: (context, index) {
                    if (_searchIndex != null) {
                      index = _searchIndex!;
                    }
                    return ListTile(
                      leading: Image.asset(favoriteImages[index]),
                      title: Text('Imagem Favorita ${index}'),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteImage(favoriteImages[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
