part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginLoding extends AuthState {}
class LoginSuccess extends AuthState {}
class LoginFaluar extends AuthState {}

class RegisterLoding extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterFaluer extends AuthState {
  String errMaseag;
  RegisterFaluer({required this.errMaseag});
}

