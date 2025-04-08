import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/services/plant_service.dart';
import 'package:http/http.dart' as http;
import '../../mocks/mock_services.mocks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';

void main() {
  late MockClient mockClient;
  late PlantService plantService;

  setUp(() async {
    // Configuration des mocks
    mockClient = MockClient();
    SharedPreferences.setMockInitialValues({
      'token': 'test_token',
      'user_id': '1',
    });
    
    // Initialisation du service de plantes avec le client mock
    plantService = await PlantService.init(client: mockClient);
  });

  group('PlantService - getMyPlants', () {
    test('devrait retourner une liste de plantes quand la requête réussit', () async {
      // Arrange
      final mockResponse = http.Response(
        json.encode([
          {
            'id': 1,
            'nom': 'Rose',
            'espece': 'Rosa',
            'description': 'Une belle rose',
            'photo': 'photos/rose.jpg',
            'owner_id': 1,
          },
          {
            'id': 2,
            'nom': 'Tulipe',
            'espece': 'Tulipa',
            'description': 'Une jolie tulipe',
            'photo': 'photos/tulipe.jpg',
            'owner_id': 1,
          },
        ]),
        200,
      );
      
      // Configure le mock pour retourner la réponse prédéfinie
      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => mockResponse);
      
      // Act
      final plants = await plantService.getMyPlants();
      
      // Assert
      expect(plants.length, 2);
      expect(plants[0].nom, 'Rose');
      expect(plants[1].nom, 'Tulipe');
      
      // Vérifie que le client a été appelé avec les bons paramètres
      verify(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).called(1);
    });

    test('devrait lancer une exception quand la requête échoue', () async {
      // Arrange
      final mockResponse = http.Response(
        json.encode({
          'detail': 'Internal server error',
        }),
        500,
      );
      
      // Configure le mock pour retourner la réponse d'erreur
      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => mockResponse);
      
      // Act & Assert
      expect(() => plantService.getMyPlants(), throwsException);
    });
  });

  group('PlantService - getPlantDetails', () {
    test('devrait retourner les détails d\'une plante quand la requête réussit', () async {
      // Arrange
      final mockResponse = http.Response(
        json.encode({
          'id': 1,
          'nom': 'Rose',
          'espece': 'Rosa',
          'description': 'Une belle rose',
          'photo': 'photos/rose.jpg',
          'owner_id': 1,
        }),
        200,
      );
      
      // Configure le mock pour retourner la réponse prédéfinie
      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => mockResponse);
      
      // Act
      final plant = await plantService.getPlantDetails(1);
      
      // Assert
      expect(plant.id, 1);
      expect(plant.nom, 'Rose');
      expect(plant.espece, 'Rosa');
      
      // Vérifie que le client a été appelé avec les bons paramètres
      verify(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).called(1);
    });
    
    test('devrait lancer une exception quand la requête échoue', () async {
      // Arrange
      final mockResponse = http.Response(
        json.encode({
          'detail': 'Plant not found',
        }),
        404,
      );
      
      // Configure le mock pour retourner la réponse d'erreur
      when(mockClient.get(
        any,
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => mockResponse);
      
      // Act & Assert
      expect(() => plantService.getPlantDetails(999), throwsException);
    });
  });

  group('PlantService - createPlant', () {
    test('devrait créer une plante quand la requête réussit', () async {
      // Arrange
      final mockStreamedResponse = http.StreamedResponse(
        Stream.value(utf8.encode(json.encode({
          'id': 3,
          'nom': 'Orchidée',
          'espece': 'Phalaenopsis',
          'description': 'Une belle orchidée',
          'photo': 'photos/orchidee.jpg',
          'owner_id': 1,
        }))),
        201,
      );
      
      // Configure le mock pour retourner la réponse prédéfinie
      when(mockClient.send(any)).thenAnswer((_) async => mockStreamedResponse);
      
      // Act
      final plant = await plantService.createPlant(
        nom: 'Orchidée',
        espece: 'Phalaenopsis',
        description: 'Une belle orchidée',
      );
      
      // Assert
      expect(plant.id, 3);
      expect(plant.nom, 'Orchidée');
      expect(plant.espece, 'Phalaenopsis');
      
      // Vérifie que le client a été appelé
      verify(mockClient.send(any)).called(1);
    });
    
    test('devrait lancer une exception quand la requête échoue', () async {
      // Arrange
      final mockStreamedResponse = http.StreamedResponse(
        Stream.value(utf8.encode(json.encode({
          'detail': 'Bad request',
        }))),
        400,
      );
      
      // Configure le mock pour retourner la réponse d'erreur
      when(mockClient.send(any)).thenAnswer((_) async => mockStreamedResponse);
      
      // Act & Assert
      expect(() => plantService.createPlant(nom: 'Plante invalide'), throwsException);
    });
  });
}