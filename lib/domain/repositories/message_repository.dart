import 'package:chat_demo/domain/models/message.dart';

abstract class MessageRepository {
  Stream<List<Message>> loadMessages({
    required String userId,
    required String receiverId,
  });

  Future<void> sendMessage({
    required Message message,
  });

  Future<String> getContactToken({
    required String receiverId,
  });
}
