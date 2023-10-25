part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  factory AuthEvent.doLoadUsers() => DoLoadUsers();
  factory AuthEvent.doLogin({required String userId}) =>
      DoLogin(userId: userId);

  @override
  List<Object> get props => [];
}

class DoLoadUsers extends AuthEvent {}

class DoLogin extends AuthEvent {
  final String userId;

  const DoLogin({required this.userId});

  @override
  List<Object> get props => [userId];
}
