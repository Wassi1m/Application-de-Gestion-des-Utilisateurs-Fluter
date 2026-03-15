import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';       // 🔹 Import Firebase
import 'firebase_options.dart';                           // 🔹 Options générées par flutterfire
import 'package:mon_projet/screens/view_users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();            // 🔹 Nécessaire pour async avant runApp
  await Firebase.initializeApp(                          // 🔹 Initialise Firebase
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @overrid
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion des Utilisateurs by wassim',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewUsers(),
    );
  }
}