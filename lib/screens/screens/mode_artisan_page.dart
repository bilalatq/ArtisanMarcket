import 'package:bilal_app/screens/screens/ajouter_produits_page.dart';
import 'package:flutter/material.dart';

class ModeArtisanPage extends StatefulWidget {
  const ModeArtisanPage({super.key});

  @override
  State<ModeArtisanPage> createState() => _ModeArtisanPageState();
}

class _ModeArtisanPageState extends State<ModeArtisanPage> {
  final List<Map<String, dynamic>> _produits = [
    {'nom': 'Tapis', 'description': 'Tapis en laine fait main', 'prix': '50€'},
    {
      'nom': 'Bracelet',
      'description': 'Bracelet artisanal en cuir',
      'prix': '20€'
    },
    {'nom': 'Sac', 'description': 'Sac en cuir élégant', 'prix': '70€'},
  ];

  final Map<String, dynamic> _artisanProfile = {
    'nom': 'ATIK ',
    'prenom': 'BILAL',
    'solde': '1500€',
    'evaluation': '4.5/5',
  };

  void _navigateToAjouterProduit() async {
    final newProduct = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AjouterProduitPage()),
    );

    if (newProduct != null) {
      setState(() {
        _produits.add(newProduct);
      });
    }
  }

  void _editProduit(Map<String, dynamic> produit) {
    TextEditingController nameController =
        TextEditingController(text: produit['nom']);
    TextEditingController descriptionController =
        TextEditingController(text: produit['description']);
    TextEditingController priceController =
        TextEditingController(text: produit['prix']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Modifier le produit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nom')),
            TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description')),
            TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Prix'),
                keyboardType: TextInputType.number),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler')),
          TextButton(
            onPressed: () {
              setState(() {
                produit['nom'] = nameController.text;
                produit['description'] = descriptionController.text;
                produit['prix'] = priceController.text;
              });
              Navigator.pop(context);
            },
            child: const Text('Enregistrer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Mode Artisan',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                          title: Text('Nom: ${_artisanProfile['nom']}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16))),
                      ListTile(
                          title: Text('Prénom: ${_artisanProfile['prenom']}',
                              style: const TextStyle(fontSize: 14))),
                      ListTile(
                          title: Text('Solde: ${_artisanProfile['solde']}',
                              style: const TextStyle(fontSize: 14))),
                      ListTile(
                          title: Text(
                              'Évaluation: ${_artisanProfile['evaluation']}',
                              style: const TextStyle(fontSize: 14))),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAjouterProduit,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      body: Stack(
        children: [
          /// 🔹 **Image de fond couvrant tout l'écran**
          Positioned.fill(
            child: Image.asset(
              'assets/images/logo.jpg',
              fit: BoxFit.cover, // ✅ Couvre tout l'écran
            ),
          ),

          /// 🔹 **Contenu au premier plan**
          SizedBox.expand(
            child: Container(
              color: Colors.white.withAlpha((255 * 0.85)
                  .toInt()), // ✅ Fond semi-transparent pour lisibilité
              child: Column(
                children: [
                  const SizedBox(height: 80.0), // ✅ Espacement sous l'AppBar
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                              maxWidth:
                                  800), // ✅ Ajuste la largeur max pour éviter l'espace vide
                          child: DataTable(
                            headingRowColor: WidgetStateProperty.all(Colors.grey
                                .withAlpha((255 * 0.7)
                                    .toInt())), // ✅ En-tête semi-transparent
                            dataRowColor: WidgetStateProperty.all(Colors.white
                                .withAlpha((255 * 0.5)
                                    .toInt())), // ✅ Fond des lignes semi-transparent
                            columns: const [
                              DataColumn(
                                  label: Text('Nom',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14))),
                              DataColumn(
                                  label: Text('Description',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14))),
                              DataColumn(
                                  label: Text('Prix',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14))),
                              DataColumn(
                                  label: Text('Action',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14))),
                            ],
                            rows: _produits.map((produit) {
                              return DataRow(cells: [
                                DataCell(Text(produit['nom'])),
                                DataCell(Text(produit['description'])),
                                DataCell(Text(produit['prix'])),
                                DataCell(
                                  IconButton(
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue),
                                    onPressed: () => _editProduit(produit),
                                  ),
                                ),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
