import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_mock_app/controller/index_controller.dart';
import 'package:test_mock_app/view/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider<IndexController>(
      create: (context) => IndexController(),
      child: const MaterialApp(
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
