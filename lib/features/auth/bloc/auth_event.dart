part of 'auth_bloc.dart';

//События авторизации
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

//Событие регистрации с передачей 3х полей
final class AuthRegistered extends AuthEvent {
  const AuthRegistered({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  @override
  List<Object> get props => super.props..addAll([name, email, password]);
}

final class AuthLogged extends AuthEvent {
  const AuthLogged({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => super.props..addAll([email, password]);
}

final class AuthLogoutRequested extends AuthEvent {}
