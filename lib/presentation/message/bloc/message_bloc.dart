import 'package:bloc/bloc.dart';
import 'package:chat_demo/domain/models/message.dart';
import 'package:chat_demo/domain/repositories/message_repository.dart';
import 'package:equatable/equatable.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository _messageRepository;

  MessageBloc(this._messageRepository) : super(MessageInitial()) {
    on<DoLoadMessages>(_loadMessages);
    on<DoSendMessage>(_sendMessage);
  }

  _loadMessages(DoLoadMessages event, Emitter<MessageState> emit) async {
    emit(MessageState.loadingMessages());
    final messages = await _messageRepository.loadMessages();
    emit(MessageState.loadedMessages(messages: messages));
  }

  _sendMessage(DoSendMessage event, Emitter<MessageState> emit) async {
    emit(MessageState.loadingNewMessage());
    await _messageRepository.loadMessages();
    emit(MessageState.newMessageSended());
  }
}
