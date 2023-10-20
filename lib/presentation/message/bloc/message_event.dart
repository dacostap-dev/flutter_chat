part of 'message_bloc.dart';

sealed class MessageEvent extends Equatable {
  const MessageEvent();

  factory MessageEvent.doLoadMessages() => DoLoadMessages();
  factory MessageEvent.doSendMessage({required Message message}) =>
      DoSendMessage(message: message);

  @override
  List<Object> get props => [];
}

class DoLoadMessages extends MessageEvent {}

class DoSendMessage extends MessageEvent {
  final Message message;

  const DoSendMessage({required this.message});

  @override
  List<Object> get props => [message];
}
