import 'package:chat_demo/domain/models/message.dart';
import 'package:chat_demo/domain/repositories/message_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageRepositoryFirebaseImpl implements MessageRepository {
  final _db = FirebaseFirestore.instance;

  @override
  Future<void> sendMessage({
    required Message message,
  }) async {
    await _db
        .collection('users')
        .doc(message.senderId)
        .collection('chat')
        .doc(message.receiverId)
        .collection('messages')
        .add({
      ...message.toJson(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    await _db
        .collection('users')
        .doc(message.receiverId)
        .collection('chat')
        .doc(message.senderId)
        .collection('messages')
        .add({
      ...message.toJson(),
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Stream<List<Message>> loadMessages({
    required String userId,
    required String receiverId,
  }) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('chat')
        .doc(receiverId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots(includeMetadataChanges: true)
        .asyncMap((snapshot) => snapshot.docs.map((doc) {
              return Message.fromJson(doc.data());
            }).toList());
  }

  @override
  Future<String> getContactToken({required String receiverId}) async {
    final doc = await _db.collection('users').doc(receiverId).get();
    return doc.data()!['token'];
  }
}
