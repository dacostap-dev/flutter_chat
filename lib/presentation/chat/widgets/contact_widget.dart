import 'package:chat_demo/domain/models/user.dart';
import 'package:chat_demo/presentation/chat/widgets/custom_avatar.dart';
import 'package:chat_demo/presentation/message/pages/message.dart';
import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  final User user;
  static const double avatarHeight = 55;
  static const double avatarWidth = 55;

  const ContactWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).pushNamed(
        MessagesPage.route,
        arguments: user.userId,
      ),
      leading: CustomAvatar(
        avatarUrl: user.avatar,
        avatarHeight: avatarHeight,
        avatarWidth: avatarWidth,
      ),
      title: Text(user.name),
    );
  }
}
