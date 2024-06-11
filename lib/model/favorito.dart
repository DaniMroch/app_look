class FavoriteImage {
  final String imagePath;

  FavoriteImage(this.imagePath);

  // Converte um objeto FavoriteImage para JSON
  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
    };
  }

  // Converte um JSON para um objeto FavoriteImage
  factory FavoriteImage.fromJson(Map<String, dynamic> json) {
    return FavoriteImage(json['imagePath']);
  }
}
