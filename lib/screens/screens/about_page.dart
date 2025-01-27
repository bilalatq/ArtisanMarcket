import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'About the Application',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'This application, ArtisanMarket, is designed to provide a seamless experience for artisans and customers. '
              'It connects people offering artisan services with those in need of these services.',
              style: TextStyle(fontSize: 16.0),
            ),
            const Divider(),
            const Text(
              'Features:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.blue),
              title: Text('Easy registration for artisans and customers'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.blue),
              title: Text('Rating system for artisans based on their services'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.blue),
              title: Text('Negotiable prices for job offers'),
            ),
            const ListTile(
              leading: Icon(Icons.check_circle, color: Colors.blue),
              title: Text('Secure payment system with transaction tracking'),
            ),
            const Divider(),
            const Text(
              'Our Mission:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'To empower artisans by providing a platform to showcase their skills and connect with customers. '
              'We aim to bridge the gap between quality services and those who need them the most.',
              style: TextStyle(fontSize: 16.0),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.blue),
              title: Text('Contact Us'),
              subtitle: Text('Email: support@artisanmarket.com'),
            ),
            ListTile(
              leading: const Icon(Icons.web, color: Colors.blue),
              title: const Text('Visit Our Website'),
              subtitle: const Text('www.artisanmarket.com'),
              onTap: () {
                // Ajoutez une action pour ouvrir le site web si nécessaire
              },
            ),
          ],
        ),
      ),
    );
  }
}
