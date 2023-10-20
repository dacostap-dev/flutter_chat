part of 'message_bloc.dart';

sealed class MessageState extends Equatable {
  const MessageState();

  factory MessageState.loadingMessages() => LoadingMessages();
  factory MessageState.loadedMessages({
    required List<Message> messages,
  }) =>
      MessagesLoaded(messages: messages);
  factory MessageState.loadedMessagesFailed({
    required String message,
  }) =>
      MessagesLoadFailed(message: message);

  factory MessageState.loadingNewMessage() => NewMessageLoading();
  factory MessageState.newMessageSended() => NewMessageSended();
  factory MessageState.newMessageSendFailed({
    required String message,
  }) =>
      NewMessageSendFailed(message: message);

  @override
  List<Object> get props => [];
}

final class MessageInitial extends MessageState {}

final class LoadingMessages extends MessageState {}

final class MessagesLoaded extends MessageState {
  final List<Message> messages;

  const MessagesLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

final class MessagesLoadFailed extends MessageState {
  final String message;

  const MessagesLoadFailed({required this.message});

  @override
  List<Object> get props => [message];
}

//New Message
final class NewMessageLoading extends MessageState {}

final class NewMessageSended extends MessageState {}

final class NewMessageSendFailed extends MessageState {
  final String message;

  @override
  List<Object> get props => [message];

  const NewMessageSendFailed({required this.message});
}
