import 'package:freezed_annotation/freezed_annotation.dart';

part 'AuthEvent.freezed.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login(String email, String password) = _Login;
  const factory AuthEvent.register(String email, String password) = _Register;
  const factory AuthEvent.logout() = _Logout;
}
