part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  factory ChatState.loadingChats() => LoadingChats();
  factory ChatState.loadChats({
    required List<User> users,
  }) =>
      LoadedChats(users: users);
  factory ChatState.failedLoadChats({
    required String message,
  }) =>
      FailedLoadChats(message: message);

  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class LoadingChats extends ChatState {}

final class LoadedChats extends ChatState {
  final List<User> users;

  const LoadedChats({required this.users});

  @override
  List<Object> get props => [users];
}

final class FailedLoadChats extends ChatState {
  final String message;

  const FailedLoadChats({required this.message});

  @override
  List<Object> get props => [message];
}
