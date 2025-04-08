import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mobile/main.dart';
import 'package:mobile/views/home_after_login_screen.dart';
import 'package:mobile/views/login_screen.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_services.mocks.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockStorageService mockStorageService;

  setUp(() {
    mockAuthService = MockAuthService();
    mockStorageService = MockStorageService();
    
    // Configure les réponses des mocks
    when(mockAuthService.login(any, any)).thenAnswer((_) async => {
      'access_token': 'fake_token',
    });
    
    when(mockAuthService.getCurrentUser(any)).thenAnswer((_) async => {
      'id': 1,
      'role': 'USER',
      'email': 'test@example.com',
    });
    
    when(mockStorageService.saveToken(any)).thenAnswer((_) async => null);
    when(mockStorageService.saveUserRole(any)).thenAnswer((_) async => null);
    when(mockStorageService.setUserId(any)).thenAnswer((_) async => null);
  });

  testWidgets('Flux de connexion complet - de l\'accueil à la page principale', (WidgetTester tester) async {
    // Note: Ce test nécessiterait de modifier l'application pour accepter des services mockés
    // ou d'utiliser une approche d'injection de dépendances
    
    // Arrange
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(const MyApp());
    });

    // Act & Assert
    // 1. Vérifier que nous sommes sur la page d'accueil
    expect(find.text('A\'rosa-je'), findsOneWidget);
    
    // 2. Appuyer sur le bouton de connexion
    await tester.tap(find.text('Connexion'));
    await tester.pumpAndSettle();
    
    // 3. Vérifier que nous sommes sur la page de connexion
    expect(find.byType(LoginScreen), findsOneWidget);
    
    // 4. Remplir le formulaire de connexion
    // Note: Ces étapes dépendent de l'implémentation exacte de LoginScreen
    // et de la possibilité de mocker les services
    
    // Ce test est un exemple et nécessiterait des modifications de l'application
    // pour être pleinement fonctionnel avec l'injection de dépendances
    // Voici comment on pourrait compléter le test si l'injection était implémentée:
    
  
    // Remplir le formulaire de connexion
    await tester.enterText(find.byType(TextFormField).at(0), 'user@arosaje.fr');
    await tester.enterText(find.byType(TextFormField).at(1), 'epsi691');
    
    // Appuyer sur le bouton de connexion
    await tester.tap(find.text('Connexion'));
    await tester.pumpAndSettle();
    
    // Vérifier que l'authentification a été appelée avec les bons paramètres
    verify(mockAuthService.login('user@arosaje.fr', 'epsi691')).called(1);
    
    // Vérifier que nous sommes redirigés vers la page principale
    expect(find.byType(HomeAfterLogin), findsOneWidget);

  });
}