import 'package:bloc/bloc.dart';
import 'package:chat_demo/data/repositories/firebase/notification_service.dart';
import 'package:chat_demo/domain/models/message.dart';
import 'package:chat_demo/domain/repositories/message_repository.dart';
import 'package:chat_demo/presentation/auth/bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;
  final AuthBloc _authBloc;

  final notificationService = NotificationService();

  MessageBloc(this._messageRepository, this._authBloc)
      : super(MessageInitial()) {
    on<DoLoadMessages>(_loadMessages);
    on<DoSendMessage>(_sendMessage);
  }

  _loadMessages(DoLoadMessages event, Emitter<MessageState> emit) async {
    //Para Stream
    print(event.contactId);

    await emit.forEach(
        _messageRepository.loadMessages(
          userId: _authBloc.authId,
          receiverId: event.contactId,
        ), onData: (data) {
      print(data);
      return MessageState.loadedMessages(messages: data);
    }, onError: (error, _) {
      return MessageState.loadedMessagesFailed(message: error.toString());
    });
  }

  _sendMessage(DoSendMessage event, Emitter<MessageState> emit) async {
    emit(MessageState.loadingNewMessage());
    await _messageRepository.sendMessage(
      message: event.message,
    );

    final token = event.receiverToken;
    await notificationService.sendNotification(
      body: event.message.content,
      receiverToken: token,
      senderId: event.message.senderId,
    );

    emit(MessageState.newMessageSended());
  }

  Future<String> getReceiverToken(String receiverId) async {
    return await _messageRepository.getContactToken(receiverId: receiverId);
  }
}
