import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String content;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
  });

  @override
  List<Object?> get props => [senderId, receiverId, content];
}
