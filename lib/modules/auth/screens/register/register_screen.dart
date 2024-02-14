// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import '../../../../api/app_routes.dart';
import '../../../../utils/helpers/hive_service.dart';
import '../../widgets/fullname_widget.dart';
import '../../widgets/phone_widget.dart';
import '../../../../components/button_widget.dart';
import '../../../../components/logo_widget.dart';
import '../../widgets/email_widget.dart';
import '../../widgets/password_widget.dart';

class RegisterScreen extends StatefulWidget {
  final int id;
  final String fullname;
  final String email;
  final String mobile;
  final String password;
  final String fcmToken;
  final int status;

  const RegisterScreen({
    required this.id,
    required this.fullname,
    required this.email,
    required this.mobile,
    required this.password,
    required this.fcmToken,
    required this.status,
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullname = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Register',
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoWidget(),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 24,
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Daftar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: const Text(
                          'Silahkan Register mendapatkan akun dll',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                FullnameWidget(_fullname),
                EmailWidget(_email),
                PhoneWidget(_phoneNumber),
                PasswordWidget(_password),
                ButtonWidget(
                  'Register',
                  24,
                  () {
                    FocusScope.of(context).unfocus();
                    var isValid = _formKey.currentState!.validate();
                    checkRegisterStatus(context, isValid);
                  },
                ),
                if (_isLoading)
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 16,
                      ),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkRegisterStatus(BuildContext context, bool isValid) async {
    print(isValid);
    if (isValid) {
      setState(() => _isLoading = true);

      try {
        final String encryptedPassword =
            sha256.convert(utf8.encode(_password.text)).toString();

        bool registrationSuccessful = await RegisterService.registerUser(
          _fullname.text,
          _email.text,
          _phoneNumber.text,
          encryptedPassword,
        );

        if (registrationSuccessful) {
          await http.post(
            Uri.parse('http://192.168.43.140/project_mobile/database.php'),
            
            body: {
              'name': _fullname.text,
              'email': _email.text,
              'mobile': _phoneNumber.text,
              'password': encryptedPassword,
              'fcm_token': 'test_fcm_token',
            },
          );
          Navigator.pop(context);
          registerToast('User Successfully Registered', Colors.green);
          _navigateToLoginScreen();
        } else if (RegisterService.registerMessage.isNotEmpty) {
          registerToast(RegisterService.registerMessage, Colors.red);
        } else {
          registerToast('User Registration Failed', Colors.red);
        }
      } catch (e) {
        if (e is SocketException) {
          print('Error: Koneksi jaringan terputus.');
        } else {
          print('Error: $e');
        }
        registerToast('Something went wrong', Colors.red);
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void registerToast(String toast, Color color) {
    Fluttertoast.showToast(
      msg: toast,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
    );
  }

  void _navigateToLoginScreen() {
    Navigator.popAndPushNamed(context, AppRoutes.login);
  }
}
