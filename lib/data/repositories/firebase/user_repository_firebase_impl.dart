import 'package:chat_demo/domain/models/user.dart';
import 'package:chat_demo/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepositoryFirebaseImpl implements UserRepository {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<User>> loadUsers() async {
    final docs = await firestore.collection('users').get();
    return docs.docs.map((doc) => User.fromJson(doc.data())).toList();
  }

  @override
  Future<void> login() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<void> updateToken({
    required String userId,
    required String token,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set({'token': token}, SetOptions(merge: true));
  }
}
