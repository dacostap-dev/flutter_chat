import 'package:chat_demo/domain/models/user.dart';
import 'package:chat_demo/domain/repositories/users_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRepositoryFirebaseImpl implements ChatRepository {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<User>> loadUsers() async {
    final docs = await firestore.collection('users').get();
    return docs.docs.map((doc) => User.fromJson(doc.data())).toList();
  }
}
