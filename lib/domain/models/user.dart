import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String name;
  final String avatar;
  final String token;

  const User({
    required this.userId,
    required this.name,
    required this.avatar,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["id"],
        name: json["name"],
        avatar: json["avatar"],
        token: json["token"],
      );

  @override
  List<Object?> get props => [userId, name, avatar, token];
}
