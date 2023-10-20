import 'package:chat_demo/domain/models/user.dart';
import 'package:chat_demo/presentation/chat/pages/chat.dart';
import 'package:chat_demo/presentation/message/pages/message.dart';
import 'package:flutter/material.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ChatPage.route:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ChatPage.route),
        builder: (_) => const ChatPage(),
      );
    case MessagesPage.route:
      final user = settings.arguments as User;

      return MaterialPageRoute(
        settings: const RouteSettings(name: MessagesPage.route),
        builder: (_) => MessagesPage(contact: user),
      );
    default:
      throw Exception('Route not found');
  }
}
