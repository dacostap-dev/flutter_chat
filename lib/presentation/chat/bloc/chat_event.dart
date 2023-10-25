part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  factory ChatEvent.doLoadChats() => DoLoadChats();
  factory ChatEvent.doLoadContact({
    required String contactId,
  }) =>
      DoLoadContact(contactId: contactId);

  @override
  List<Object> get props => [];
}

final class DoLoadChats extends ChatEvent {}

final class DoLoadContact extends ChatEvent {
  final String contactId;

  const DoLoadContact({required this.contactId});

  @override
  List<Object> get props => [contactId];
}
