import 'package:bloc/bloc.dart';
import 'package:chat_demo/domain/models/user.dart';
import 'package:chat_demo/domain/repositories/contact_repository.dart';
import 'package:chat_demo/presentation/auth/bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ContactRepository _chatRepository;
  final AuthBloc _authBloc;

  ChatBloc(this._chatRepository, this._authBloc) : super(ChatInitial()) {
    on<DoLoadChats>(_loadChats);
    on<DoLoadContact>(_loadContact);
  }

  _loadChats(DoLoadChats event, Emitter<ChatState> emit) async {
    emit(ChatState.loadingChats());
    final chats = await _chatRepository.loadContacts();

    emit(
      ChatState.loadChats(
        users: chats
            .where((element) => element.userId != _authBloc.authId)
            .toList(),
      ),
    );
  }

  _loadContact(DoLoadContact event, Emitter<ChatState> emit) async {
    emit(ChatState.loadingContact());
    final contact = await _chatRepository.getContactDetail(
      contactId: event.contactId,
    );
    emit(ChatState.loadedContact(user: contact));
  }
}
