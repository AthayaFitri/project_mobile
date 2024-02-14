// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';

part 'data_users.g.dart';

@HiveType(typeId: 1)
class DataUsersHive extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String mobile;

  @HiveField(4)
  final String password;

  @HiveField(5)
  final String fcmToken;

  @HiveField(6)
  final int status;

  DataUsersHive({
    required this.userId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.password,
    required this.fcmToken,
    required this.status,
  });
}
