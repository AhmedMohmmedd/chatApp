import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final _auth = FirebaseAuth.instance;

  Future<void> sinUser(
      {required String email, required String password}) async {
    emit(LoginLoding());
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        emit(LoginSuccess());
      }
    } catch (e) {
      // print(e);
      emit(LoginFaluar());
    }
  }
}
