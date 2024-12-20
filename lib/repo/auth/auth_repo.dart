import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      //Регистрируемся, передав email и пароль
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //Если регистрация прошла успешно и юзер не пустой
      if (userCredential.user != null) {
        //Обновляем имя юзеру на то, что ввели при регистрации
        await userCredential.user!.updateDisplayName(name);
      }
    } on FirebaseAuthException catch (e) {
      //Обработка специфичных ошибок, потому что их сообщение странное
      if (e.code == 'weak-password') {
        throw Exception('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
      rethrow;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      //Авторизовываемся
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      //Выходим из аккаунта
      await _firebaseAuth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
