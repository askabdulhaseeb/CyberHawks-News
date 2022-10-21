part of 'auth_bloc.dart';
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthChangeEvent extends AuthEvent {
  final bool isLogin;

  AuthChangeEvent({this.isLogin = false});

  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {


  @override
  List<Object?> get props => [];

  AuthLoginEvent();
}
