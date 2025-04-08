import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late StorageService storageService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    storageService = StorageService(prefs);
  });

  group('StorageService - Token Management', () {
    test('saveToken devrait stocker le token dans SharedPreferences', () async {
      // Act
      await storageService.saveToken('test_token');
      
      // Assert
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('token'), 'test_token');
    });

    test('getToken devrait retourner le token stocké', () async {
      // Arrange
      await storageService.saveToken('test_token');
      
      // Act
      final token = storageService.getToken();
      
      // Assert
      expect(token, 'test_token');
    });

    test('clearToken devrait supprimer le token', () async {
      // Arrange
      await storageService.saveToken('test_token');
      
      // Act
      await storageService.clearToken();
      
      // Assert
      final token = storageService.getToken();
      expect(token, isNull);
    });
  });

  group('StorageService - User Role Management', () {
    test('saveUserRole devrait stocker le rôle utilisateur', () async {
      // Act
      await storageService.saveUserRole('ADMIN');
      
      // Assert
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('user_role'), 'ADMIN');
    });

    test('getUserRole devrait retourner le rôle utilisateur stocké', () async {
      // Arrange
      await storageService.saveUserRole('ADMIN');
      
      // Act
      final role = storageService.getUserRole();
      
      // Assert
      expect(role, 'ADMIN');
    });
  });

  group('StorageService - User ID Management', () {
    test('setUserId devrait stocker l\'ID utilisateur', () async {
      // Act
      await storageService.setUserId(1);
      
      // Assert
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('user_id'), '1');
    });

    test('getUserId devrait retourner l\'ID utilisateur stocké', () async {
      // Arrange
      await storageService.setUserId(1);
      
      // Act
      final userId = await storageService.getUserId();
      
      // Assert
      expect(userId, 1);
    });
  });
}