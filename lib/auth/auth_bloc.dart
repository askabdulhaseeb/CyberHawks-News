import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      if (event is AuthChangeEvent) {
        if (event.isLogin) {
          emit(AuthSuccess());
        } else {
          emit(AuthFail());
        }
      }

      if(event is AuthLoginEvent) {
        emit(AuthLogin());
      }
    });
  }
}
