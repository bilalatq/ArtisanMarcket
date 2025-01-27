import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String? _firstName;
  String? _lastName;
  String? _city;
  String? _cin;
  String? _email;
  String? _password;
  bool _obscurePassword = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  bool _isEmailValid(String email) {
    final regex = RegExp(r'^[^@]+@[^@]+\.[a-zA-Z]{2,}\$');
    return regex.hasMatch(email);
  }

  void _handleRegister() async {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      try {
        // Créer un utilisateur avec Firebase Authentication
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email!,
          password: _password!,
        );

        // Récupérer l'ID utilisateur (UID)
        String uid = userCredential.user!.uid;

        // Enregistrer les informations de l'utilisateur dans Firestore
        await _firestore.collection('users').doc(uid).set({
          'firstName': _firstName,
          'lastName': _lastName,
          'city': _city,
          'cin': _cin,
          'email': _email,
          'createdAt': DateTime.now(),
        });

        // Afficher un message de succès
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful!')),
        );

        // Naviguer vers la page d'accueil ou de connexion
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/home');
      } catch (e) {
        // Afficher une erreur si l'enregistrement échoue
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to Register Page'),
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/logo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  _buildFirstNameField(),
                  const SizedBox(height: 16.0),
                  _buildLastNameField(),
                  const SizedBox(height: 16.0),
                  _buildCityField(),
                  const SizedBox(height: 16.0),
                  _buildCinField(),
                  const SizedBox(height: 16.0),
                  _buildEmailField(),
                  const SizedBox(height: 16.0),
                  _buildPasswordField(),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _handleRegister,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 50),
                      backgroundColor: const Color.fromARGB(156, 255, 140, 68),
                    ),
                    child:
                        const Text('Register', style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text('Already have an account? Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField _buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'First Name',
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your first name';
        }
        return null;
      },
      onSaved: (value) => _firstName = value,
    );
  }

  TextFormField _buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Last Name',
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your last name';
        }
        return null;
      },
      onSaved: (value) => _lastName = value,
    );
  }

  TextFormField _buildCityField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'City',
        prefixIcon: const Icon(Icons.location_city),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your city';
        }
        return null;
      },
      onSaved: (value) => _city = value,
    );
  }

  TextFormField _buildCinField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'CIN',
        prefixIcon: const Icon(Icons.credit_card),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your CIN';
        }
        return null;
      },
      onSaved: (value) => _cin = value,
    );
  }

  TextFormField _buildEmailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      keyboardType:
          TextInputType.emailAddress, // Assure un clavier adapté pour l'email
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your email';
        }
        // Regex pour valider un email
        final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
        if (!emailRegex.hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      onSaved: (value) =>
          _email = value?.trim(), // Enregistrer la valeur trimée
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon:
              Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: _togglePasswordVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters long';
        }
        return null;
      },
      onSaved: (value) => _password = value,
    );
  }
}
