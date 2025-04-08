import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/services/auth_service.dart';
import 'package:mobile/services/plant_service.dart';
import 'package:mobile/services/storage_service.dart';

// Cette annotation génère des mocks pour les classes spécifiées
@GenerateMocks([http.Client, AuthService, PlantService, StorageService])
void main() {}