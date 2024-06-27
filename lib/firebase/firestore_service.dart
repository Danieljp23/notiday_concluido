import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> saveImageUrl(Object userId, Object imageUrl) async {
    try {
      await _firestore.collection('users').doc(userId as String?).set(
        {'avatarUrl': imageUrl},
        SetOptions(merge: true),
      );
    } catch (error) {
      throw Exception('Erro ao salvar a URL da imagem no Firestore: $error');
    }
  }

  static Future<Object?> getImageUrl(Object userId) async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(userId as String?).get();
      if (documentSnapshot.exists) {
        return documentSnapshot.data();
      } else {
        return null;
      }
    } catch (error) {
      throw Exception('Erro ao obter a URL da imagem do Firestore: $error');
    }
  }
}
// TODO Implement this library.