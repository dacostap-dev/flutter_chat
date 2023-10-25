import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String name;
  final String token;

  const User({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["id"],
        name: json["name"],
        token: json["token"],
      );

  @override
  List<Object?> get props => [userId, name];
}
