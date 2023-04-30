import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthStateLogout()) {
    FirebaseAuth auth = FirebaseAuth.instance;

    on<AuthEventLogin>((event, emit) async {
      try {
        emit(AuthStateLoading());
        // fungsi untuk login
        await auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.pass,
        );
        emit(AuthStateLogin());
      } on FirebaseAuthException catch (e) {
        // Error dari Firebase Auth
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        // Error general
        emit(AuthStateError(e.toString()));
      }
    });
    on<AuthEventLogout>((event, emit) async {
      // fungsi untuk logout
      try {
        emit(AuthStateLoading());
        // fungsi untuk logout
        await auth.signOut();
        emit(AuthStateLogout());
      } on FirebaseAuthException catch (e) {
        // Error dari Firebase Auth
        emit(AuthStateError(e.message.toString()));
      } catch (e) {
        // Error general
        emit(AuthStateError(e.toString()));
      }
    });
  }
}
