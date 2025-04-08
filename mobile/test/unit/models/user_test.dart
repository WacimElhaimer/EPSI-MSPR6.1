import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/models/user.dart';

void main() {
  group('User Model', () {
    test('fromJson devrait créer une instance de User à partir d\'un JSON', () {
      // Arrange
      final json = {
        'id': 1,
        'email': 'test@example.com',
        'nom': 'Doe',
        'prenom': 'John',
        'telephone': '0123456789',
        'localisation': 'Paris',
        'role': 'USER',
        'is_verified': true,
      };
      
      // Act
      final user = User.fromJson(json);
      
      // Assert
      expect(user.id, 1);
      expect(user.email, 'test@example.com');
      expect(user.nom, 'Doe');
      expect(user.prenom, 'John');
      expect(user.telephone, '0123456789');
      expect(user.localisation, 'Paris');
      expect(user.role, 'USER');
      expect(user.isVerified, true);
    });

    test('toJson devrait convertir une instance de User en JSON', () {
      // Arrange
      final user = User(
        id: 1,
        email: 'test@example.com',
        nom: 'Doe',
        prenom: 'John',
        telephone: '0123456789',
        localisation: 'Paris',
        role: 'USER',
        isVerified: true,
      );
      
      // Act
      final json = user.toJson();
      
      // Assert
      expect(json['id'], 1);
      expect(json['email'], 'test@example.com');
      expect(json['nom'], 'Doe');
      expect(json['prenom'], 'John');
      expect(json['telephone'], '0123456789');
      expect(json['localisation'], 'Paris');
      expect(json['role'], 'USER');
      expect(json['is_verified'], true);
    });

    test('fromJson devrait gérer les valeurs nulles', () {
      // Arrange
      final json = {
        'id': 1,
        'email': 'test@example.com',
        'nom': 'Doe',
        'prenom': 'John',
        'telephone': null,
        'localisation': null,
        'role': 'USER',
        'is_verified': null,
      };
      
      // Act
      final user = User.fromJson(json);
      
      // Assert
      expect(user.id, 1);
      expect(user.email, 'test@example.com');
      expect(user.nom, 'Doe');
      expect(user.prenom, 'John');
      expect(user.telephone, isNull);
      expect(user.localisation, isNull);
      expect(user.role, 'USER');
      expect(user.isVerified, false); // La valeur par défaut est false
    });
  });
}