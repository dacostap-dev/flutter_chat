import 'package:chat_demo/domain/models/message.dart';
import 'package:chat_demo/domain/repositories/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  @override
  Future<List<Message>> loadMessages() async {
    return [
      const Message(senderId: '1', receiverId: '2', content: 'hola'),
      const Message(senderId: '2', receiverId: '1', content: 'que tal'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
      const Message(senderId: '2', receiverId: '1', content: 'Todo bien?'),
    ];
  }

  @override
  Future<void> sendMessage() async {
    return;
  }
}
