import 'package:chat_demo/presentation/auth/bloc/auth_bloc.dart';
import 'package:chat_demo/presentation/chat/pages/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static const String route = 'login-page';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? groupValue;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthBloc>().add(AuthEvent.doLoadUsers());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) => switch (state) {
        AuthLoginSucced() => Navigator.pushNamedAndRemoveUntil(
            context, ChatPage.route, (_) => false),
        _ => null,
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            Text(
              'Login',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'Que usuario eres?',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Expanded(
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) => switch (current) {
                  AuthLoadingUsers() => true,
                  AuthLoadedUsers() => true,
                  AuthLoadUsersFailed() => true,
                  _ => false,
                },
                builder: (context, state) {
                  print(state);
                  return switch (state) {
                    AuthLoadingUsers() =>
                      const Center(child: CircularProgressIndicator.adaptive()),
                    AuthLoadedUsers(users: final users) => ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) => RadioListTile<String>(
                          title: Text(users[index].name),
                          value: users[index].userId,
                          groupValue: groupValue,
                          onChanged: (value) {
                            groupValue = value;
                            setState(() {});
                          },
                        ),
                      ),
                    AuthLoadUsersFailed(message: final message) =>
                      Text(message),
                    _ => const SizedBox(),
                  };
                },
              ),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return switch (state) {
                  AuthLoadingLogin() => const ElevatedButton(
                      onPressed: null,
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  _ => ElevatedButton(
                      onPressed: groupValue != null
                          ? () {
                              print(groupValue);
                              context
                                  .read<AuthBloc>()
                                  .add(AuthEvent.doLogin(userId: groupValue!));
                            }
                          : null,
                      child: const Text('Continuar'),
                    ),
                };
              },
            ),
          ],
        ),
      ),
    );
  }
}
