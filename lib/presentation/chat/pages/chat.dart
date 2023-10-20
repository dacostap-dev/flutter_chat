import 'package:chat_demo/presentation/chat/bloc/chat_bloc.dart';
import 'package:chat_demo/presentation/message/pages/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  static const String route = 'chat-page';

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatBloc>().add(ChatEvent.doLoadChats());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return switch (state) {
            LoadingChats() => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            LoadedChats(users: final users) => ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.of(context)
                      .pushNamed(MessagesPage.route, arguments: users[index]),
                  title: Text(users[index].name),
                ),
                itemCount: users.length,
              ),
            _ => const SizedBox(height: 10),
          };
        },
      ),
    );
  }
}