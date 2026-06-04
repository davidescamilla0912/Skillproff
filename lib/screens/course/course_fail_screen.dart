// Pantalla de resultado fallido del quiz. Muestra el puntaje
// obtenido y opción para intentarlo de nuevo.
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/models/api_models.dart';
import '../../widgets/shared_widgets.dart';
import '../home/main_screen.dart';

class CourseFailScreen extends StatelessWidget {
  final Course course;
  const CourseFailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Spacer(),
            Container(
                width: 160,
                height: 160,
                decoration: const BoxDecoration(
                    color: Color(0xFFE3F2FD), shape: BoxShape.circle),
                child: const Center(
                    child: Text('😞', style: TextStyle(fontSize: 72)))),
            const SizedBox(height: 32),
            const Text('Ooops! Sorry',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            const Text('Este curso no lo aprobaste, vuelve a intentarlo',
                textAlign: TextAlign.center, style: AppTextStyles.body),
            const Spacer(),
            SPButton(
                label: 'Intentar De Nuevo',
                onTap: () => Navigator.of(context).pop()),
            const SizedBox(height: 12),
            SPOutlinedButton(
                label: 'Volver Al Inicio',
                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                    (r) => false)),
            const SizedBox(height: 32),
          ]),
        ),
      ),
    );
  }
}
