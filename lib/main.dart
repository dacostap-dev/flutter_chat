import 'package:chat_demo/core/router.dart';
import 'package:chat_demo/data/repositories/firebase/message_repository_firebase_impl.dart';
import 'package:chat_demo/data/repositories/firebase/user_repository_firebase_impl.dart';

import 'package:chat_demo/domain/repositories/message_repository.dart';
import 'package:chat_demo/domain/repositories/users_repository.dart';
import 'package:chat_demo/firebase_options.dart';
import 'package:chat_demo/presentation/chat/bloc/chat_bloc.dart';
import 'package:chat_demo/presentation/chat/pages/chat.dart';
import 'package:chat_demo/presentation/message/bloc/message_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChatRepository>(
          create: (context) => ChatRepositoryFirebaseImpl(),
        ),
        RepositoryProvider<MessageRepository>(
          create: (context) => MessageRepositoryFirebaseImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ChatBloc(context.read()),
          ),
          BlocProvider(
            create: (context) => MessageBloc(context.read()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            useMaterial3: true,
          ),
          onGenerateRoute: onGenerateRoute,
          initialRoute: ChatPage.route,
        ),
      ),
    );
  }
}
