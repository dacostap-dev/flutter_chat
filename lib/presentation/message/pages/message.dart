import 'package:chat_demo/presentation/auth/bloc/auth_bloc.dart';
import 'package:chat_demo/presentation/chat/bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_demo/domain/models/message.dart';
import 'package:chat_demo/presentation/message/bloc/message_bloc.dart';
import 'package:chat_demo/presentation/message/widgets/message_bubble.dart';

class MessagesPage extends StatefulWidget {
  static const String route = 'messages-page';

  final String contactId;

  const MessagesPage({super.key, required this.contactId});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final _scrollController = ScrollController();
  final _textController = TextEditingController();

  String? receiverToken;

  @override
  void initState() {
    super.initState();

    _getContactToken();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<ChatBloc>()
          .add(ChatEvent.doLoadContact(contactId: widget.contactId));
      context
          .read<MessageBloc>()
          .add(MessageEvent.doLoadMessages(contactId: widget.contactId));
    });
  }

  _getContactToken() async {
    receiverToken =
        await context.read<MessageBloc>().getReceiverToken(widget.contactId);
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return switch (state) {
              LoadingContactDetail() => AppBar(
                  title:
                      const Center(child: CircularProgressIndicator.adaptive()),
                ),
              LoadedContactDetail() => AppBar(
                  title: Text(state.user.name),
                ),
              FailedLoadContactDetail(message: final message) => AppBar(
                  title: Text(message),
                ),
              _ => AppBar()
            };
          },
        ),
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
            LoadingMessages() =>
              const Center(child: CircularProgressIndicator.adaptive()),
            MessagesLoaded(messages: final messages) => ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final isMe = messages[index].senderId ==
                      context.read<AuthBloc>().authId;
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
                  senderId: context.read<AuthBloc>().authId,
                  receiverId: widget.contactId,
                  content: _textController.text,
                );

                context.read<MessageBloc>().add(MessageEvent.doSendMessage(
                      message: newMessage,
                      receiverToken: receiverToken ?? '',
                    ));
              },
              icon: const Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }
}
