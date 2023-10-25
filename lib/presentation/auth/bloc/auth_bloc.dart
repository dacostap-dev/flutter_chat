import 'package:bloc/bloc.dart';
import 'package:chat_demo/data/repositories/firebase/notification_service.dart';
import 'package:chat_demo/domain/models/user.dart';
import 'package:chat_demo/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;
  final NotificationService _notificationService = NotificationService();
  late String authId;

  AuthBloc(this._userRepository) : super(AuthInitial()) {
    on<DoLoadUsers>(_loadUsers);
    on<DoLogin>(_login);
  }

  _loadUsers(DoLoadUsers event, Emitter<AuthState> emit) async {
    emit(AuthState.loadingUsers());
    final chats = await _userRepository.loadUsers();
    emit(AuthState.loadUsers(users: chats));
  }

  _login(DoLogin event, Emitter<AuthState> emit) async {
    emit(AuthState.loadingLogin());
    await _userRepository.login();
    final token = await _notificationService.getToken();
    authId = event.userId;
    await _userRepository.updateToken(userId: event.userId, token: token);
    emit(AuthState.loginSuccess());
  }
}
