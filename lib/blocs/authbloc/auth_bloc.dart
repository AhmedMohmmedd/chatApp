import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoding());
        try {
          final user = await _auth.signInWithEmailAndPassword(
              email: event.email, password: event.password);
          if (user != null) {
            emit(LoginSuccess());
          }
        } catch (e) {
          // print(e);
          emit(LoginFaluar());
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoding());
        try {
          final newuser = await _auth.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          if (newuser != null) {
            emit(RegisterSuccess());
          }
        } on FirebaseAuthException catch (e) {
          // print(e);
          if (e.code == 'weak-password') {
            emit(RegisterFaluer(errMaseag: 'weak-password'));
          } else if (e.code == 'email-already-in-use') {
            emit(RegisterFaluer(errMaseag: ' email already exists'));
          }
        }
      }
    });
    @override
    void onTransition(Transition<AuthEvent, AuthState> transition) {
      super.onTransition(transition);
      print(transition);
    }
  }
}
