import 'package:bloc/bloc.dart';
import 'package:chat_demo/core/constants.dart';
import 'package:chat_demo/data/repositories/firebase/notification_service.dart';
import 'package:chat_demo/domain/models/message.dart';
import 'package:chat_demo/domain/repositories/message_repository.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;

  final notificationService = NotificationService();

  MessageBloc(this._messageRepository) : super(MessageInitial()) {
    on<DoLoadMessages>(_loadMessages);
    on<DoSendMessage>(_sendMessage);
  }

  _loadMessages(DoLoadMessages event, Emitter<MessageState> emit) async {
    //Para Stream
    print(event.contactId);

    await emit.forEach(
        _messageRepository.loadMessages(
          userId: AppConstants.kUserAdminId,
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
    // await Future.delayed(const Duration(seconds: 1));
    await _messageRepository.sendMessage(
      message: event.message,
    );

    final token = await notificationService.getToken();

    print(token);

    await notificationService.sendNotification(
      body: event.message.content,
      receiverToken: token,
    );

    emit(MessageState.newMessageSended());
  }
}
