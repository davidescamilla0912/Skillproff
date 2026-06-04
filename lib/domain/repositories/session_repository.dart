// Puerto (interface) para operaciones de sesión / persistencia local.
abstract class SessionRepository {
  Future<void> saveLogin({
    required String name,
    required String email,
    required String role,
  });

  Future<bool> isLoggedIn();

  Future<Map<String, String>> getUserData();

  Future<void> saveCategory(String category);

  Future<bool> hasOnboarded();

  Future<void> logout();
}

