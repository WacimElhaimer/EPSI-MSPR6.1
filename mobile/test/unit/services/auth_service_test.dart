import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import '../../mocks/mock_services.mocks.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late MockClient mockClient;
  late AuthService authService; // Ajout de l'instance AuthService

  setUp(() async {
    mockClient = MockClient();
    SharedPreferences.setMockInitialValues({});
    authService = await AuthService.getInstance();
  });

  group('AuthService - login', () {
    test('devrait retourner les données utilisateur quand la requête réussit', () async {
      // Arrange
      final mockResponse = http.Response(
        json.encode({
          'access_token': 'test_token',
          'token_type': 'bearer',
        }),
        200,
      );
      
      when(mockClient.post(
        Uri.parse('${AuthService.baseUrl}/auth/login'),
        headers: anyNamed('headers'),
        body: {
          'username': 'user@arosaje.fr',
          'password': 'epsi691'
        },
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await authService.login('user@arosaje.fr', 'epsi691');

      // Assert
      expect(result['access_token'], equals('test_token'));
      expect(result['token_type'], equals('bearer'));
      
      verify(mockClient.post(
        Uri.parse('${AuthService.baseUrl}/auth/login'),
        headers: any,
        body: json.encode({
          'email': 'user@arosaje.fr',
          'password': 'epsi691'
        }),
      )).called(1);
    });

    test('devrait lancer une exception quand la requête échoue', () async {
      // Arrange
      final mockResponse = http.Response(
        json.encode({
          'detail': 'Invalid credentials',
        }),
        401,
      );
      
      when(mockClient.post(
        Uri.parse('${AuthService.baseUrl}/auth/login'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
        () => authService.login('test@example.com', 'wrong_password'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('AuthService - register', () {
    test('devrait retourner les données utilisateur quand l\'inscription réussit', () async {
      // Arrange
      final mockResponse = http.Response(
        json.encode({
          'id': 1,
          'email': 'test@example.com',
          'nom': 'Test',
          'prenom': 'User',
          'role': 'USER',
        }),
        200,
      );
      
      when(mockClient.post(
        Uri.parse('${AuthService.baseUrl}/auth/register'),
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await authService.register(
        email: 'test@example.com',
        password: 'password123',
        nom: 'Test',
        prenom: 'User',
        telephone: '0123456789',
        role: 'USER'
      );

      // Assert
      expect(result['email'], equals('test@example.com'));
      expect(result['nom'], equals('Test'));
      expect(result['prenom'], equals('User'));
      expect(result['role'], equals('USER'));
    });
  });

  group('AuthService - getCurrentUser', () {
    test('devrait retourner les informations de l\'utilisateur quand la requête réussit', () async {
      // Arrange
      final mockResponse = http.Response(
        json.encode({
          'id': 1,
          'email': 'test@example.com',
          'nom': 'Test',
          'prenom': 'User',
          'role': 'USER',
        }),
        200,
      );
      
      when(mockClient.get(
        Uri.parse('${AuthService.baseUrl}/auth/me'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async => mockResponse);

      // Act
      final result = await authService.getCurrentUser('test_token');

      // Assert
      expect(result['email'], equals('test@example.com'));
      expect(result['id'], equals(1));
      expect(result['role'], equals('USER'));
    });
  });
}
