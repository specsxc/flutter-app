import 'package:flutter/material.dart';
import 'package:flutter_app/utils/my_preferences.dart';
import 'package:flutter_app/views/home/home_view.dart';
import 'package:flutter_app/views/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyPreferences.init();
  final isLoggedIn = MyPreferences.isLoggedIn();
  runApp(MyApp(initialView: isLoggedIn ? const HomeView() : const LoginView()));
}

class MyApp extends StatelessWidget {
  final Widget initialView;

  const MyApp({required this.initialView, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project',
      debugShowCheckedModeBanner: false,
      home: initialView,
    );
  }
}
