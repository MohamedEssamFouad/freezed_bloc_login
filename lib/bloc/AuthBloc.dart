import 'package:flutter_bloc/flutter_bloc.dart';
import '../Service/AuthService.dart';
import 'AuthEvent.dart';
import 'AuthStates.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(const AuthState.unauthenticated()) {
    on<AuthEvent>((event, emit) async {
      await event.map(
        login: (e) async {
          emit(const AuthState.loading());
          try {
            final user = await authService.login(e.email, e.password);
            emit(AuthState.authenticated(user));
          } catch (e) {
            emit(AuthState.error(e.toString()));
          }
        },
        register: (e) async {
          emit(const AuthState.loading());
          try {
            final user = await authService.register(e.email, e.password);
            emit(AuthState.authenticated(user));
          } catch (e) {
            emit(AuthState.error(e.toString()));
          }
        },
        logout: (e) async {
          emit(const AuthState.loading());
          try {
            await authService.logout();
            emit(const AuthState.unauthenticated());
          } catch (e) {
            emit(AuthState.error(e.toString()));
          }
        },
      );
    });
  }
}
