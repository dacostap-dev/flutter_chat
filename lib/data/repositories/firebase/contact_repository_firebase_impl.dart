import 'package:chat_demo/domain/models/user.dart';
import 'package:chat_demo/domain/repositories/contact_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepositoryFirebaseImpl implements ContactRepository {
  final firestore = FirebaseFirestore.instance;

  @override
  Future<List<User>> loadContacts() async {
    final docs = await firestore.collection('users').get();
    return docs.docs.map((doc) => User.fromJson(doc.data())).toList();
  }

  @override
  Future<User> getContactDetail({required String contactId}) async {
    final doc = await firestore.collection('users').doc(contactId).get();
    return User.fromJson(doc.data()!);
  }
}
