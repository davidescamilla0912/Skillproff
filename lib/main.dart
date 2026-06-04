// Punto de entrada de la app. Configura la orientación,
// la barra de estado y lanza LoginScreen como pantalla inicial.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/auth/login_screen.dart';
import 'screens/home/main_screen.dart';
import 'infrastructure/repositories/course_repository_impl.dart';
import 'infrastructure/repositories/session_repository_impl.dart';
import 'application/usecases/load_data_usecase.dart';
import 'application/usecases/is_logged_in_usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  // Composición: crea implementaciones y usa casos de uso
  final courseRepo = CourseRepositoryImpl();
  final sessionRepo = SessionRepositoryImpl();

  // Carga datos del JSON vía usecase
  await LoadDataUseCase(courseRepo).call();

  // Verifica si ya hay sesion guardada en el celular via usecase
  final bool loggedIn = await IsLoggedInUseCase(sessionRepo).call();

  runApp(SkillProofApp(loggedIn: loggedIn));
}

class SkillProofApp extends StatelessWidget {
  final bool loggedIn;
  const SkillProofApp({super.key, required this.loggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skill Proof',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Roboto',
        primaryColor: const Color(0xFF2196F3),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF212121),
          elevation: 0,
          centerTitle: false,
        ),
      ),
      // Si ya inicio sesion antes va directo al Home, si no va al Login
      home: loggedIn ? const MainScreen() : const LoginScreen(),
    );
  }
}
