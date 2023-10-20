import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userId;
  final String name;

  const User({required this.userId, required this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["id"],
        name: json["name"],
      );

  @override
  List<Object?> get props => [userId, name];
}
