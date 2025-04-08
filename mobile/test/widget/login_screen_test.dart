import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/views/login_screen.dart';
import 'package:mobile/views/testable_login_screen.dart';
import 'package:mockito/mockito.dart';
import '../mocks/mock_services.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockStorageService mockStorageService;

  setUp(() {
    mockAuthService = MockAuthService();
    mockStorageService = MockStorageService();
  });

  testWidgets('LoginScreen devrait afficher les champs email et mot de passe', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Assert
    expect(find.text('Connexion'), findsOneWidget);
    expect(find.byType(TextFormField), findsAtLeast(2)); // Au moins 2 champs de formulaire
    expect(find.byType(ElevatedButton), findsOneWidget); // Bouton de connexion
  });

  testWidgets('LoginScreen devrait afficher un message d\'erreur pour un email invalide', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Act
    await tester.enterText(find.byType(TextFormField).first, 'email_invalide');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert
    // Note: Ce test dépend de l'implémentation exacte de la validation dans LoginScreen
    // Si la validation est asynchrone ou si le message d'erreur est différent, ce test pourrait échouer
    expect(find.text('Veuillez entrer un email valide'), findsOneWidget);
  });

  testWidgets('LoginScreen devrait afficher un message d\'erreur pour un mot de passe vide', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    // Act
    await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), '');
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Assert
    // Note: Ce test dépend de l'implémentation exacte de la validation dans LoginScreen
    expect(find.text('Veuillez entrer votre mot de passe'), findsOneWidget);
  });

  testWidgets('TestableLoginScreen devrait afficher un indicateur de chargement pendant la connexion', (WidgetTester tester) async {
    // Arrange
    when(mockAuthService.login(any, any)).thenAnswer((_) async {
      // Simuler un délai pour voir l'indicateur de chargement
      await Future.delayed(const Duration(milliseconds: 100));
      return {'access_token': 'fake_token'};
    });
    
    when(mockAuthService.getCurrentUser(any)).thenAnswer((_) async {
      return {'id': 1, 'role': 'USER'};
    });

    await tester.pumpWidget(
      MaterialApp(
        home: TestableLoginScreen(
          authService: mockAuthService,
          storageService: mockStorageService,
        ),
      ),
    );

    // Remplir le formulaire avec des données valides
    await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    
    // Act - Cliquer sur le bouton de connexion
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // Déclenche l'animation mais pas le délai
    
    // Assert - Vérifier que l'indicateur de chargement est affiché
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    // Compléter l'animation et le délai
    await tester.pumpAndSettle();
    
    // Vérifier que les méthodes mockées ont été appelées
    verify(mockAuthService.login('test@example.com', 'password123')).called(1);
    verify(mockAuthService.getCurrentUser('fake_token')).called(1);
    verify(mockStorageService.saveToken('fake_token')).called(1);
    verify(mockStorageService.saveUserRole('USER')).called(1);
    verify(mockStorageService.setUserId(1)).called(1);
  });
  
  testWidgets('TestableLoginScreen devrait gérer les erreurs de connexion', (WidgetTester tester) async {
    // Arrange
    when(mockAuthService.login(any, any)).thenThrow('Identifiants invalides');

    await tester.pumpWidget(
      MaterialApp(
        home: TestableLoginScreen(
          authService: mockAuthService,
          storageService: mockStorageService,
        ),
      ),
    );

    // Remplir le formulaire avec des données valides
    await tester.enterText(find.byType(TextFormField).first, 'test@example.com');
    await tester.enterText(find.byType(TextFormField).at(1), 'password123');
    
    // Act - Cliquer sur le bouton de connexion
    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();
    
    // Assert - Vérifier que le message d'erreur est affiché
    expect(find.text('Identifiants invalides'), findsOneWidget);
    
    // Vérifier que la méthode mockée a été appelée
    verify(mockAuthService.login('test@example.com', 'password123')).called(1);
  });
}