import 'package:chat_demo/data/repositories/firebase/notification_service.dart';
import 'package:chat_demo/presentation/chat/bloc/chat_bloc.dart';
import 'package:chat_demo/presentation/chat/widgets/contact_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  static const String route = 'chat-page';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final notificationService = NotificationService();

  @override
  void initState() {
    super.initState();

    notificationService.requestPermission();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatBloc>().add(ChatEvent.doLoadChats());
      notificationService.firebaseNotification(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        buildWhen: (previous, current) => switch (current) {
          LoadingChats() => true,
          LoadedChats() => true,
          _ => false,
        },
        builder: (context, state) {
          return switch (state) {
            LoadingChats() => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            LoadedChats(users: final users) => ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                padding: const EdgeInsets.all(4),
                itemBuilder: (context, index) {
                  return ContactWidget(user: users[index]);
                },
                itemCount: users.length,
              ),
            _ => const SizedBox(height: 10),
          };
        },
      ),
    );
  }
}
