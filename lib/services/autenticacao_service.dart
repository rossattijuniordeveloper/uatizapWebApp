import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uatizap/utils/meu_snackbar.dart';

class AutenticacaoService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> cadastrarUsuario({
    required String senha,
    required String email,
    required String nome,
    required Uint8List imagemSelecionada,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      //     .then((auth) {
      //   // upload
      //   if (auth != null) {
      //     String? idUsuario = auth.user?.uid;
      //     if (idUsuario != null) {
      //       _uploadImagem(idUsuario, imagemSelecionada);
      //     }
      //   }
      // });
//      await userCredential.user!.updateDisplayName(nome);
      // upload
      String? idUsuario = userCredential.user?.uid;
      if (idUsuario != null) {
        _uploadImagem(idUsuario, imagemSelecionada);
      } else {
        print('erro');
        return 'erro';
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Usuário Cadastrado Anteriormente';
      } else {
        return 'Erro desconhecido: ${e.code}';
      }
    }
  }

  Future<String?> logarUsuarios({
    required String email,
    required String senha,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      // TODO
      print(e.message);
      return e.message;
    }
  }

  Future<void> deslogar() async {
    return _firebaseAuth.signOut();
  }

  void _uploadImagem(String idUsuario, Uint8List arquivoSelecionado) {
    Reference imagemPerfilRef = _storage.ref('imagens/perfil/$idUsuario.jpg');
    UploadTask uploadTask = imagemPerfilRef.putData(arquivoSelecionado);
    uploadTask.whenComplete(() async {
      String linkImagem = await uploadTask.snapshot.ref.getDownloadURL();
      print('Link da imagem: $linkImagem');
    });
  }
}
