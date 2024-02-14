// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:hive/hive.dart';
import '../../db/data_courses.dart';
import '../../db/data_users.dart';

// Service untuk proses registrasi pengguna
class RegisterService {
  static final Box<DataUsersHive> box =
      Hive.box<DataUsersHive>('data_users_box');

  static String registerMessage = '';

  // Method untuk mendaftarkan pengguna baru
  static Future<bool> registerUser(
      String name, String email, String mobile, String password) async {
    // Cek apakah email sudah digunakan sebelumnya
    bool isEmailUsed = box.values.any((user) => user.email == email);

    if (isEmailUsed) {
      // Jika email sudah digunakan, set pesan dan kembalikan false
      registerMessage = 'Email Already Used: $email';
      return false;
    } else {
      // Jika email belum digunakan, buat pengguna baru dan simpan ke Hive
      int idNomax = box.isEmpty
          ? 1
          : box.values
                  .map((user) => int.parse(user.userId))
                  .reduce((a, b) => a > b ? a : b) +
              1;

      DataUsersHive newUser = DataUsersHive(
        userId: idNomax.toString(),
        name: name,
        email: email,
        mobile: mobile,
        password: password,
        fcmToken: 'test_fcm_token',
        status: 1,
      );

      box.add(newUser);
      return true;
    }
  }
}

// Service untuk proses login pengguna
class LoginService {
  static final Box<DataUsersHive> box =
      Hive.box<DataUsersHive>('data_users_box');

  // Method untuk melakukan login pengguna
  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    final user = box.values
        .firstWhere((user) => user.email == email && user.password == password,
            orElse: () => DataUsersHive(
                  userId: '',
                  name: '',
                  email: '',
                  mobile: '',
                  password: '',
                  fcmToken: '',
                  status: 0,
                ));

    if (user.userId.isNotEmpty) {
      // Jika login berhasil, kembalikan data pengguna
      print(user.userId);
      print(user.email);
      print(user.password);
      return {
        'value': 1,
        'message': 'User Successfully LoggedIn',
        'email': user.email,
        'name': user.name,
        'id': user.userId,
        'status': 'success',
      };
    } else {
      // Jika login gagal, kembalikan pesan kegagalan
      return {
        'value': 0,
        'message': 'Failed to LogIn',
        'email': '',
        'name': '',
        'id': '',
        'status': 'failure',
      };
    }
  }
}

// Service untuk manajemen kursus favorit
class FavoriteService {
  static final Box<DataCoursesHive> box =
      Hive.box<DataCoursesHive>('data_courses_box');

  // Method untuk menambahkan kursus ke daftar favorit
  static Future<void> addToFavorites(int itemId) async {
    await box.put(itemId, DataCoursesHive(id: itemId, isFavorite: 'true'));
  }

  // Method untuk menghapus kursus dari daftar favorit
  static Future<void> removeFromFavorites(int itemId) async {
    await box.put(itemId, DataCoursesHive(id: itemId, isFavorite: 'false'));
  }

  // Method untuk mengecek apakah suatu kursus ada di daftar favorit
  static bool isFavorite(int itemId) {
    final dataFromHive = box.get(itemId);
    return dataFromHive?.isFavorite == 'true';
  }
}
