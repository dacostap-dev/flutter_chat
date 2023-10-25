part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  factory AuthState.loadingUsers() => AuthLoadingUsers();
  factory AuthState.loadUsers({
    required List<User> users,
  }) =>
      AuthLoadedUsers(users: users);
  factory AuthState.failedLoadUsers({
    required String message,
  }) =>
      AuthLoadUsersFailed(message: message);

  factory AuthState.loadingLogin() => AuthLoadingLogin();
  factory AuthState.loginSuccess() => AuthLoginSucced();
  factory AuthState.loginFailed({
    required String message,
  }) =>
      AuthLoginFailed(message: message);

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoadingUsers extends AuthState {}

final class AuthLoadedUsers extends AuthState {
  final List<User> users;

  const AuthLoadedUsers({required this.users});

  @override
  List<Object> get props => [users];
}

final class AuthLoadUsersFailed extends AuthState {
  final String message;

  const AuthLoadUsersFailed({required this.message});

  @override
  List<Object> get props => [message];
}

//LOGIN
final class AuthLoadingLogin extends AuthState {}

final class AuthLoginSucced extends AuthState {}

final class AuthLoginFailed extends AuthState {
  final String message;

  const AuthLoginFailed({required this.message});

  @override
  List<Object> get props => [message];
}
