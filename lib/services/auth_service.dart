import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Claves — nombres de variables guardadas en el celular
  static const String _keyIsLoggedIn = 'isLoggedIn';
  static const String _keyUserName   = 'userName';
  static const String _keyUserEmail  = 'userEmail';
  static const String _keyUserRole   = 'userRole';
  static const String _keyOnboarded  = 'onboarded';
  static const String _keyCategory   = 'category';

  // Singleton: una sola instancia en toda la app
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  // GUARDAR sesion al hacer Login
  static Future<void> saveLogin({
    required String name,
    required String email,
    required String role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsLoggedIn, true);
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserEmail, email);
    await prefs.setString(_keyUserRole, role);
  }

  // LEER si ya inicio sesion
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  // LEER datos del usuario guardados
  static Future<Map<String, String>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name':  prefs.getString(_keyUserName)  ?? 'Usuario',
      'email': prefs.getString(_keyUserEmail) ?? '',
      'role':  prefs.getString(_keyUserRole)  ?? 'student',
    };
  }

  // GUARDAR categoria elegida en onboarding
  static Future<void> saveCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyCategory, category);
    await prefs.setBool(_keyOnboarded, true);
  }

  // LEER si ya hizo el onboarding
  static Future<bool> hasOnboarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyOnboarded) ?? false;
  }

  // CERRAR sesion — borra todo
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
