import 'package:chat_demo/domain/models/message.dart';

abstract class MessageRepository {
  Future<List<Message>> loadMessages();

  Future<void> sendMessage();
}
