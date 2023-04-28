part of 'auth_bloc.dart';

abstract class AuthEvent {}

// Event -> action / aksi / tindakan
// 1. AuthEventLogin -> melakukan tindakan login
// 2. AuthEventLogout -> melakukan tindakan logout

class AuthEventLogin extends AuthEvent {
  AuthEventLogin(this.email, this.pass);
  final String email;
  final String pass;
}

class AuthEventLogout extends AuthEvent {}
