part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthFail extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLogin extends AuthState {
  @override
  List<Object> get props => [];
}