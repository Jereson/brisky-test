import 'package:briskit/getit.dart';
import 'package:briskit/routes.dart';
import 'package:briskit/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brisky Demo',
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
      routes: routes,
    );
  }
}
