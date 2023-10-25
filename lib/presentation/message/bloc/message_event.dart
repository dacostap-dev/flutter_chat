part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  factory MessageEvent.doLoadMessages({
    required String contactId,
  }) =>
      DoLoadMessages(contactId: contactId);
  factory MessageEvent.doSendMessage({
    required Message message,
    required String receiverToken,
  }) =>
      DoSendMessage(message: message, receiverToken: receiverToken);

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
  final String receiverToken;

  const DoSendMessage({
    required this.message,
    required this.receiverToken,
  });

  @override
  List<Object> get props => [message];
}
