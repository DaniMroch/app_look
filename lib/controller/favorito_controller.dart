import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavoritesController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> saveFavoriteImage(String imagePath) async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    DocumentReference userDoc = _firestore.collection('usuarios').doc(user.uid);

    await userDoc.set({
      'imagens_favoritas': FieldValue.arrayUnion([imagePath])
    }, SetOptions(merge: true));
  }

  Future<void> deleteFavoriteImage(String imagePath) async {
    final User? user = _auth.currentUser;
    if (user == null) return;

    DocumentReference userDoc = _firestore.collection('usuarios').doc(user.uid);

    await userDoc.update({
      'imagens_favoritas': FieldValue.arrayRemove([imagePath])
    });
  }

//stream
  Future<List<String>> getFavoriteImages() async {
    final User? user = _auth.currentUser;
    if (user == null) return [];

    DocumentSnapshot snapshot =
        await _firestore.collection('usuarios').doc(user.uid).get();
    if (snapshot.exists && snapshot.data() != null) {
      var data = snapshot.data() as Map<String, dynamic>;
      List<dynamic> favorites = data['imagens_favoritas'] ?? [];
      return List<String>.from(favorites);
    } else {
      return [];
    }
  }
}
   /* final User? user = _auth.currentUser;
    if (user == null) return Stream.value([]);

    return _firestore
        .collection('usuarios')
        .doc(user.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        var data = snapshot.data()!;
        List<dynamic> favorites = data['imagens_favoritas'] ?? [];
        return favorites.cast<String>();
      } else {
        return [];
      }
    });
  }
}*/
