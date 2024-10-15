import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/User.dart';

part 'AuthStates.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(String message) = _AuthError;
}
