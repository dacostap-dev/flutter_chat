import 'package:chat_demo/domain/models/user.dart';

abstract class UserRepository {
  Future<List<User>> loadUsers();
  Future<void> login();

  Future<void> updateToken({
    required String userId,
    required String token,
  });
}
