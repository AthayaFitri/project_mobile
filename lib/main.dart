// ignore_for_file: unused_local_variable

import 'db/data_courses.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'api/app_routes.dart';
import 'db/data_users.dart';
import 'modules/auth/screens/login/login_screen.dart';
import 'modules/auth/screens/register/register_screen.dart';
import 'modules/home/screens/detail/detail_user_arguments.dart';
import 'modules/home/screens/detail/detail_user_screen.dart';
import 'modules/home/screens/home_screen.dart';
import 'utils/services/local_storage_service.dart';
import 'package:timezone/data/latest.dart' as tzdata;

Future<void> main() async {
  tzdata.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageService.initializePreference();

  // Inisialisasi Hive
  await Hive.initFlutter();

  Hive.registerAdapter(DataCoursesHiveAdapter());
  Hive.registerAdapter(DataUsersHiveAdapter());

  await Hive.openBox<DataCoursesHive>('data_courses_box');
  await Hive.openBox<DataUsersHive>('data_users_box');
  
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Comfortaa',
      ),
      title: 'My Project',
      debugShowCheckedModeBanner: false,
      initialRoute: getInitialRoute(),
      onGenerateRoute: (settings) => configRoute(settings),
    );
  }

  String getInitialRoute() {
    if (LocalStorageService.getStateLogin()) {
      return AppRoutes.home;
    } else {
      return AppRoutes.login;
    }
  }

  Route? configRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return buildRoute(const LoginScreen(), settings: settings);
      case AppRoutes.register:
        return buildRoute(
            const RegisterScreen(
              id: 0,
              fullname: '',
              email: '',
              mobile: '',
              password: '',
              fcmToken: '',
              status: 0,
            ),
            settings: settings);
      case AppRoutes.home:
        return buildRoute(const HomeScreen(), settings: settings);
      case AppRoutes.detailUser:
        final DetailUserArguments args =
            settings.arguments as DetailUserArguments;
        return buildRoute(DetailUserScreen(args), settings: settings);
      default:
        return null;
    }
  }

  MaterialPageRoute buildRoute(Widget child,
          {required RouteSettings settings}) =>
      MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => child,
      );
}
