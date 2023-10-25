import 'package:chat_demo/domain/models/user.dart';

abstract class ContactRepository {
  Future<List<User>> loadContacts();
  Future<User> getContactDetail({required String contactId});
}
