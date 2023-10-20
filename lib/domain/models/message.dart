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

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        senderId: json["sender_id"],
        receiverId: json["receiver_id"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "content": content,
      };

  @override
  List<Object?> get props => [senderId, receiverId, content];
}
