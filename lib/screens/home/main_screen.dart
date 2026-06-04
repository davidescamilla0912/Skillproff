// Pantalla principal con BottomNavigationBar. Gestiona las 3 tabs:
// HomeTab (inicio), CourseTab (cursos) y ProfileScreen (perfil).
import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';
import 'home_tab.dart';
import '../course/course_tab.dart';
import '../profile/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const CourseTab(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _index, children: _screens),
      bottomNavigationBar: SPBottomNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
      ),
    );
  }
}
