// Implementación de infraestructura para sesión que delega en `AuthService`.
import '../../domain/repositories/session_repository.dart';
import '../../services/auth_service.dart';

class SessionRepositoryImpl implements SessionRepository {
  @override
  Future<void> saveLogin({required String name, required String email, required String role}) =>
      AuthService.saveLogin(name: name, email: email, role: role);

  @override
  Future<bool> isLoggedIn() => AuthService.isLoggedIn();

  @override
  Future<Map<String, String>> getUserData() => AuthService.getUserData();

  @override
  Future<void> saveCategory(String category) => AuthService.saveCategory(category);

  @override
  Future<bool> hasOnboarded() => AuthService.hasOnboarded();

  @override
  Future<void> logout() => AuthService.logout();
}

