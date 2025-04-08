import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/views/home_screen.dart';
import 'package:mobile/views/login_screen.dart';
import 'package:mobile/views/register_screen.dart'; 
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('AccueilPage devrait afficher le titre de l\'application', (WidgetTester tester) async {
    // Arrange
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AccueilPage(),
        ),
      );
    });

    // Assert
    expect(find.text('A\'rosa-je'), findsOneWidget);
  });

  testWidgets('AccueilPage devrait avoir des boutons de connexion et d\'inscription', (WidgetTester tester) async {
    // Arrange
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AccueilPage(),
        ),
      );
    });

    // Assert
    expect(find.text('Connexion'), findsOneWidget);
    expect(find.text('Créer un compte'), findsOneWidget);
  });

  testWidgets('Appuyer sur le bouton de connexion devrait naviguer vers LoginScreen', (WidgetTester tester) async {
    // Arrange
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AccueilPage(),
        ),
      );
    });

    // Act
    await tester.tap(find.text('Connexion'));
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  testWidgets('Appuyer sur le bouton \'Créer un compte\' devrait naviguer vers InscriptionPage', (WidgetTester tester) async {
    // Arrange
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        const MaterialApp(
          home: AccueilPage(),
        ),
      );
    });

    // Act
    await tester.tap(find.text('Créer un compte'));
    await tester.pumpAndSettle();

    // Assert
    expect(find.byType(InscriptionPage), findsOneWidget);
  });
}