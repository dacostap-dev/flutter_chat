import 'package:chat_demo/domain/models/user.dart';

abstract class ChatRepository {
  Future<List<User>> loadUsers();
}
