import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repo/repo.dart';

part 'auth_event.dart';

part 'auth_state.dart';

//Блок - StateManagent для обработки состояний (чистая архитектура)
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepo authRepo})
      : _authRepo = authRepo,
        super(AuthInitial()) {
    //Сопоставление события с методами, то есть какой метод будет вызываться при работе с событием
    on<AuthRegistered>(_register);
    on<AuthLogged>(_login);
    on<AuthLogoutRequested>(_logout);
  }

  final AuthRepo _authRepo;

  AuthEvent? _lastEvent;
  AuthEvent? get lastEvent => _lastEvent;

  Future<void> _register(
    AuthRegistered event,
    Emitter<AuthState> emit,
  ) async {
    _lastEvent = event;
    //Меняем состояние на "Загружается"
    emit(AuthLoading());

    try {
      //Вызываем метод регистрации в AuthRepo
      await _authRepo.register(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      //Если успешно, меняем состояние на успешно
      emit(AuthSuccess());
    } catch (e) {
      //Если ошибка возникла, меняем на состояние "Ошибка" с передачей этой ошибки
      emit(AuthFailure(error: e));
    }
  }

  //Аналогично и для остальных методов
  Future<void> _login(
    AuthLogged event,
    Emitter<AuthState> emit,
  ) async {
    _lastEvent = event;
    emit(AuthLoading());

    try {
      await _authRepo.login(email: event.email, password: event.password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(error: e));
    }
  }

  Future<void> _logout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    _lastEvent = event;
    emit(AuthLoading());

    try {
      await _authRepo.logout();
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(error: e));
    }
  }
}
