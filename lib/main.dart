import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoking/home_screen.dart';
import 'package:quit_smoking/services/local_storage.dart';
import 'package:quit_smoking/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await LocalStorage.init();
  await NotificationService.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
