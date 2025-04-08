import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/models/plant.dart';

void main() {
  group('Plant Model', () {
    test('fromJson devrait créer une instance de Plant à partir d\'un JSON', () {
      // Arrange
      final json = {
        'id': 1,
        'nom': 'Rose',
        'espece': 'Rosa',
        'description': 'Une belle rose',
        'photo': 'photos/rose.jpg',
        'owner_id': 2,
      };
      
      // Act
      final plant = Plant.fromJson(json);
      
      // Assert
      expect(plant.id, 1);
      expect(plant.nom, 'Rose');
      expect(plant.espece, 'Rosa');
      expect(plant.description, 'Une belle rose');
      expect(plant.photo, 'photos/rose.jpg');
      expect(plant.ownerId, 2);
    });

    test('toJson devrait convertir une instance de Plant en JSON', () {
      // Arrange
      final plant = Plant(
        id: 1,
        nom: 'Rose',
        espece: 'Rosa',
        description: 'Une belle rose',
        photo: 'photos/rose.jpg',
        ownerId: 2,
      );
      
      // Act
      final json = plant.toJson();
      
      // Assert
      expect(json['id'], 1);
      expect(json['nom'], 'Rose');
      expect(json['espece'], 'Rosa');
      expect(json['description'], 'Une belle rose');
      expect(json['photo'], 'photos/rose.jpg');
      expect(json['owner_id'], 2);
    });

    test('fromJson devrait gérer les valeurs nulles', () {
      // Arrange
      final json = {
        'id': 1,
        'nom': 'Rose',
        'espece': null,
        'description': null,
        'photo': null,
        'owner_id': null,
      };
      
      // Act
      final plant = Plant.fromJson(json);
      
      // Assert
      expect(plant.id, 1);
      expect(plant.nom, 'Rose');
      expect(plant.espece, isNull);
      expect(plant.description, isNull);
      expect(plant.photo, isNull);
      expect(plant.ownerId, isNull);
    });
  });
}