import 'package:chat_demo/domain/models/message.dart';
import 'package:chat_demo/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  @override
  Future<void> sendMessage({
    required Message message,
  }) async {
    return;
  }

  @override
  Stream<List<Message>> loadMessages({
    required String userId,
    required String receiverId,
  }) {
    // TODO: implement loadMessages
    throw UnimplementedError();
  }

  @override
  Future<String> getContactToken({required String receiverId}) {
    // TODO: implement getContactToken
    throw UnimplementedError();
  }
}
