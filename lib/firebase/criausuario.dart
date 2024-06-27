import 'package:firebase_auth/firebase_auth.dart';

class AutenticaUser {
 final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
 Future<String?> autenticaUsuario(
      {
      required String email,
      required String senha,
      }) async {
  try{  
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(
          email: email, password: senha
          );
  return null;
  } on FirebaseAuthException catch(e){
    if(e.code == "e-mail ja esta em uso"){
      return "Cadastro feito com sucesso!";
    }

    return "E-mail já cadastrado!";
   }

 }
 Future <String?> logarUsuarios({
  required String email,
  required String senha,
  
 }) async{
  try{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
 return null;
 }on FirebaseAuthException catch (e) {
return "Erro ao fazer login";
 }
 }
Future<String?> resetasenha({required String email,})async {
  try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return null;
  }on FirebaseAuthException {
    return "falha ao resetar senha!";
  }
}
 Future<void>deslogar() async {
    return _firebaseAuth.signOut();
  }
}
