import 'package:bloc/bloc.dart';
import 'package:chat_demo/domain/models/user.dart';
import 'package:chat_demo/domain/repositories/users_repository.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;

  ChatBloc(this._chatRepository) : super(ChatInitial()) {
    on<DoLoadChats>(_loadChats);
  }

  _loadChats(DoLoadChats event, Emitter<ChatState> emit) async {
    emit(ChatState.loadingChats());
    final chats = await _chatRepository.loadUsers();
    emit(ChatState.loadChats(users: chats));
  }
}
