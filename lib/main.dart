import 'package:bilal_app/screens/screens/about_page.dart';
import 'package:bilal_app/screens/screens/ajouter_produits_page.dart';
import 'package:bilal_app/screens/screens/mode_artisan_page.dart';
import 'package:bilal_app/screens/screens/settings_page.dart';
import 'package:bilal_app/screens/home_page.dart';
import 'package:bilal_app/screens/register_page.dart';
import 'package:bilal_app/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import des options Firebase

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Initialisation avec les options Firebase
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter BilalApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) {
          var username = '';
          return HomePage(
            username: username,
          );
        },
        '/logout': (context) => const LoginPage(),
        '/settings': (context) => const SettingsPage(),
        '/about': (context) => const AboutPage(),
        '/ajouterProduits': (context) => const AjouterProduitPage(),
        '/modeArtisan': (context) => const ModeArtisanPage(),
      },
      initialRoute: '/login',
    );
  }
}
