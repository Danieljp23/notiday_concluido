
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notiday_1/Objetos/Compromissos.dart';


class CompromissoServico {
  String userId;
  CompromissoServico() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarCompromisso(Compromisso compromisso) async {
    return await _firestore
        .collection(userId)
        .doc(compromisso.id)
        .set(compromisso.toMap());
  }
  // no dart o termo Stream arremete a abrir um tunel e analisar em tempo real
 //função que pede toda vez que o usuário esta logado um print da coleção do firestore, de acordo com o Id logado
 Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamCompromisso() {
  return  _firestore.collection(userId).snapshots();
  }
}