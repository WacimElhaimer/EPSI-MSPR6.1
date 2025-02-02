import 'package:flutter/material.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'plant_history_screen.dart';
import 'home_after_login_screen.dart';

// Importez vos autres pages ici

class BasePage extends StatefulWidget {
  final Widget body;
  final int currentIndex;

  const BasePage({
    super.key,
    required this.body,
    required this.currentIndex,
  });

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  void _onNavigationItemTapped(int index) {
    switch (index) {
      case 0:
        // Si ce n'est pas déjà la page d'accueil
        if (widget.currentIndex != 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeAfterLogin()),
          );
        }
        break;
      case 1:
        // Navigation vers PlantHistoryScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PlantHistoryScreen()),
        );
        break;
      case 2:
        // Navigation vers la page Messages
        // Ajoutez votre logique de navigation ici
        break;
      case 3:
        // Navigation vers la page Profil
        // Ajoutez votre logique de navigation ici
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.body,
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: widget.currentIndex,
        onTap: _onNavigationItemTapped,
      ),
    );
  }
}
