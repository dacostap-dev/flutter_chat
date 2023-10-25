import 'package:chat_demo/presentation/auth/pages/login.dart';
import 'package:chat_demo/presentation/chat/pages/chat.dart';
import 'package:chat_demo/presentation/message/pages/message.dart';
import 'package:flutter/material.dart';

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginPage.route:
      return MaterialPageRoute(
        settings: const RouteSettings(name: LoginPage.route),
        builder: (_) => const LoginPage(),
      );
    case ChatPage.route:
      return MaterialPageRoute(
        settings: const RouteSettings(name: ChatPage.route),
        builder: (_) => const ChatPage(),
      );
    case MessagesPage.route:
      final contactId = settings.arguments as String;

      return MaterialPageRoute(
        settings: const RouteSettings(name: MessagesPage.route),
        builder: (_) => MessagesPage(contactId: contactId),
      );
    default:
      throw Exception('Route not found');
  }
}
