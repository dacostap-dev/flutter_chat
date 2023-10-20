import 'package:chat_demo/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_demo/domain/models/message.dart';
import 'package:chat_demo/domain/models/user.dart';
import 'package:chat_demo/presentation/message/bloc/message_bloc.dart';
import 'package:chat_demo/presentation/message/widgets/message_bubble.dart';

class MessagesPage extends StatefulWidget {
  static const String route = 'messages-page';

  final User contact;

  const MessagesPage({super.key, required this.contact});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<MessageBloc>()
          .add(MessageEvent.doLoadMessages(contactId: widget.contact.userId));
    });
  }

  void newMessageLoaded() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }

    _textController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
      ),
      body: BlocConsumer<MessageBloc, MessageState>(
        listener: (BuildContext context, MessageState state) {
          (switch (state) {
            NewMessageSended() => newMessageLoaded(),
            _ => null,
          });
        },
        buildWhen: (previous, current) => switch (current) {
          NewMessageSended() => false,
          NewMessageLoading() => false,
          _ => true
        },
        builder: (context, state) {
          return switch (state) {
            LoadingMessages() => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            MessagesLoaded(messages: final messages) => ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final isMe =
                      messages[index].senderId == AppConstants.kUserAdminId;
                  return MessageBubble(
                    isMe: isMe,
                    message: messages[index],
                  );
                },
                itemCount: messages.length,
              ),
            _ => const SizedBox(height: 10),
          };
        },
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  final newMessage = Message(
                    senderId: AppConstants.kUserAdminId,
                    receiverId: widget.contact.userId,
                    content: _textController.text,
                  );

                  context
                      .read<MessageBloc>()
                      .add(MessageEvent.doSendMessage(message: newMessage));
                },
                icon: const Icon(Icons.send))
          ],
        ),
      ),
    );
  }
}
