part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  factory ChatEvent.doLoadChats() => DoLoadChats();

  @override
  List<Object> get props => [];
}

final class DoLoadChats extends ChatEvent {}
