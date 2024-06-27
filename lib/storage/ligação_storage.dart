import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImageToFirebaseStorage(
    File imageFile, String userId) async {
  try {
    // Crie uma referência para o local onde a imagem será armazenada no Firebase Storage
    String fileName =
        'profile_images/$userId/${DateTime.now().millisecondsSinceEpoch}.png';
    Reference storageRef = FirebaseStorage.instance.ref().child(fileName);

    // Faça o upload da imagem para o Firebase Storage
    UploadTask uploadTask = storageRef.putFile(imageFile);

    // Aguarde a conclusão do upload
    TaskSnapshot snapshot = await uploadTask;

    // Verifique se o upload foi concluído com sucesso
    if (snapshot.state == TaskState.success) {
      // Retorne a URL de download da imagem
      return await snapshot.ref.getDownloadURL();
    } else {
      // Se o upload não foi bem-sucedido, retorne null
      print('Erro ao fazer upload da imagem para o Firebase Storage.');
      return null;
    }
  } catch (e) {
    // Se ocorrer algum erro durante o upload, registre o erro e retorne null
    print('Erro ao fazer upload da imagem para o Firebase Storage: $e');
    return null;
  }
}
