import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); // 5 onglets
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arrière-plan
          Positioned.fill(
            child: Image.asset(
              'assets/images/logo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Contenu principal
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: const Text(
                  'Home Page',
                  style: TextStyle(color: Colors.white),
                ),
                leading: IconButton(
                  onPressed: () => _logout(context),
                  icon: const Icon(Icons.logout, color: Colors.white),
                ),
                actions: [
                  PopupMenuButton<String>(
                    onSelected: (String value) {
                      // Navigation vers les pages associées au menu
                      switch (value) {
                        case 'settings':
                          Navigator.pushNamed(context, '/settings');
                          break;
                        case 'about':
                          Navigator.pushNamed(context, '/about');
                          break;
                        case 'my products':
                          Navigator.pushNamed(context, '/ajouterProduits');
                          break;
                        case 'mode artisan':
                          Navigator.pushNamed(context, '/modeArtisan');
                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                          value: 'settings',
                          child: Text('Settings'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'about',
                          child: Text('About'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'my products',
                          child: Text('My Products'),
                        ),
                        const PopupMenuItem<String>(
                          value: 'mode artisan',
                          child: Text('Mode Artisan'),
                        ),
                      ];
                    },
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    // TabBar
                    TabBar(
                      controller: _tabController,
                      labelColor: const Color.fromARGB(255, 187, 85, 22),
                      unselectedLabelColor:
                          const Color.fromARGB(255, 164, 84, 38),
                      indicatorColor: Colors.orange,
                      tabs: const [
                        Tab(text: 'Tapis'),
                        Tab(text: 'Bracelet'),
                        Tab(text: 'Sac'),
                        Tab(text: 'Housse'),
                        Tab(text: 'Accessoire'),
                      ],
                    ),
                    // Contenu des onglets
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          // Liste de produits dans le premier onglet (Tapis)
                          ListView(
                            children: const [
                              WidgetProduct(
                                imagePath: 'assets/images/tapis.jpg',
                                price: '50€',
                                description: 'Tapis en laine fait main',
                              ),
                              WidgetProduct(
                                imagePath: 'assets/images/tapis01.jpg',
                                price: '45€',
                                description: 'Tapis artisanal en coton',
                              ),
                              WidgetProduct(
                                imagePath: 'assets/images/tapisss.jpg',
                                price: '55€',
                                description: 'Tapis coloré fait main',
                              ),
                            ],
                          ),
                          // Liste de produits pour les autres onglets (Bracelet, Sac, etc.)
                          ListView(
                            children: const [
                              WidgetProduct(
                                imagePath: 'assets/images/bracelet01.jpg',
                                price: '20€',
                                description: 'Bracelet artisanal en cuir',
                              ),
                              WidgetProduct(
                                imagePath: 'assets/images/bracelet.jpg',
                                price: '25€',
                                description: 'Bracelet en perles',
                              ),
                            ],
                          ),
                          ListView(
                            children: const [
                              WidgetProduct(
                                imagePath: 'assets/images/sac.jpg',
                                price: '70€',
                                description: 'Sac en cuir élégant',
                              ),
                            ],
                          ),
                          ListView(
                            children: const [
                              WidgetProduct(
                                imagePath: 'assets/images/housse.jpg',
                                price: '30€',
                                description: 'Housse de coussin brodée',
                              ),
                            ],
                          ),
                          ListView(
                            children: const [
                              WidgetProduct(
                                imagePath: 'assets/images/accessoire.jpg',
                                price: '15€',
                                description: 'Accessoire unique fait main',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget pour afficher un produit
class WidgetProduct extends StatelessWidget {
  final String imagePath;
  final String price;
  final String description;

  const WidgetProduct({
    super.key,
    required this.imagePath,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0), // Réduction du padding
      margin: const EdgeInsets.symmetric(
          vertical: 8.0), // Espacement entre les produits
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Coins arrondis
        ),
        elevation: 3, // Ombre réduite pour un design plus compact
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.asset(
                imagePath,
                height: 150, // Réduction de la hauteur de l'image
                width: double.infinity,
                fit: BoxFit.cover, // Image totalement visible
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0), // Padding autour du texte
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16.0, // Taille du texte
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                      height: 8.0), // Espacement entre description et prix
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 14.0, // Taille du texte du prix
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
