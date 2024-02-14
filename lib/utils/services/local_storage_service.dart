// ignore_for_file: unused_element

import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api_constants.dart';

enum LoginStatus {
  //untuk identifikasi status login
  notSignIn,
  signIn,
}

LoginStatus _loginStatus = LoginStatus.notSignIn;

class LocalStorageService {
  static SharedPreferences? _preferences; // objek penyimpanan lokal

  static Future initializePreference() async {
    _preferences = await SharedPreferences
        .getInstance(); // inisialisasi objek dengan instance dari shared_preferences
  }

  static Future setStateLogin(bool state) async => await _preferences?.setBool(
      AppConstants.loginStateKey,
      state); //menyimpan status login ke dalam penyimpanan lokal berdasarkan nilai boolean

  static bool getStateLogin() =>
      _preferences?.getBool(AppConstants.loginStateKey) ??
      false; //mengambil status login dari penyimpanan lokal. Jika tidak ada data, defaultnya adalah false

  static Future saveUserData(String email, String name, String id) async {
    //menyimpan informasi pengguna (email, nama, dan ID) ke dalam penyimpanan lokal
    await _preferences?.setString('email', email);
    await _preferences?.setString('name', name);
    await _preferences?.setString('id', id);
  }

// mengambil data pengguna dari penyimpanan lokal. Jika data tidak tersedia, mengembalikan string kosong
  static String getUserEmail() => _preferences?.getString('email') ?? '';
  static String getUserName() => _preferences?.getString('name') ?? '';
  static String getUserId() => _preferences?.getString('id') ?? '';

  static Future clearUserData() async {
    // menghapus informasi pengguna (email, nama, dan ID) dari penyimpanan lokal
    await _preferences?.remove('email');
    await _preferences?.remove('name');
    await _preferences?.remove('id');
  }

  static Future<void> signOut() async {
    // menginisialisasi penyimpanan lokal dan mengubah status login menjadi false, serta menghapus informasi pengguna dari penyimpanan lokal
    await initializePreference();
    await _preferences?.setBool(AppConstants.loginStateKey, false);
    await _preferences?.remove("email");
    await _preferences?.remove("name");
    await _preferences?.remove("id");
  }
}
