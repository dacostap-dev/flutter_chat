import 'package:chat_demo/domain/models/user.dart';
import 'package:chat_demo/domain/repositories/users_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<List<User>> loadUsers() async {
    return [
      const User(userId: '1', name: 'Daniel'),
      const User(userId: '2', name: 'Juan'),
    ];
  }
}
