import 'package:flutter/material.dart';

class AjouterProduitPage extends StatefulWidget {
  const AjouterProduitPage({super.key});

  @override
  State<AjouterProduitPage> createState() => _AjouterProduitPageState();
}

class _AjouterProduitPageState extends State<AjouterProduitPage> {
  final _formKey = GlobalKey<FormState>();
  String? _typeProduit;
  String? _description;
  double? _prix;

  void _ajouterProduit() {
    if (_formKey.currentState?.validate() == true) {
      _formKey.currentState?.save();

      // Vérification pour éviter les valeurs nulles
      final produit = {
        'nom': _typeProduit ?? 'Type non spécifié',
        'description': _description ?? 'Description non spécifiée',
        'prix': _prix != null ? '${_prix!.toStringAsFixed(2)}€' : '0.00€',
      };

      // Affichage d'un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Produit ajouté avec succès !')),
      );

      // Retour à la page précédente avec les données du produit
      Navigator.pop(context, produit);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Arrière-plan
          Positioned.fill(
            child: Image.asset(
              'assets/images/logo.jpg', // Image d'arrière-plan
              fit: BoxFit.cover,
            ),
          ),
          // Contenu principal
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  title: const Text(
                    'Ajouter un Produit',
                    style: TextStyle(color: Colors.white),
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Champ pour le type de produit
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Type de produit',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un type de produit';
                              }
                              return null;
                            },
                            onSaved: (value) => _typeProduit = value?.trim(),
                          ),
                          const SizedBox(height: 16.0),

                          // Champ pour la description
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer une description';
                              }
                              return null;
                            },
                            onSaved: (value) => _description = value?.trim(),
                          ),
                          const SizedBox(height: 16.0),

                          // Champ pour le prix
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Prix',
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer un prix';
                              } else if (double.tryParse(value) == null) {
                                return 'Veuillez entrer un prix valide';
                              }
                              return null;
                            },
                            onSaved: (value) => _prix = double.tryParse(value!),
                          ),
                          const SizedBox(height: 16.0),

                          // Bouton Ajouter
                          ElevatedButton(
                            onPressed: _ajouterProduit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(
                                vertical: 14.0,
                                horizontal: 24.0,
                              ),
                              textStyle: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            child: const Text('Ajouter Produit'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
