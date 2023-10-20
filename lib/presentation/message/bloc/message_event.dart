part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  factory MessageEvent.doLoadMessages({required String contactId}) =>
      DoLoadMessages(contactId: contactId);
  factory MessageEvent.doSendMessage({required Message message}) =>
      DoSendMessage(message: message);

  @override
  List<Object> get props => [];
}

class DoLoadMessages extends MessageEvent {
  final String contactId;

  const DoLoadMessages({required this.contactId});

  @override
  List<Object> get props => [contactId];
}

class DoSendMessage extends MessageEvent {
  final Message message;

  const DoSendMessage({required this.message});

  @override
  List<Object> get props => [message];
}
