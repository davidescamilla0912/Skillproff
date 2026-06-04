// Pantalla de resultado exitoso del quiz. Muestra animación
// de felicitación y botón para volver al inicio.
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/models/api_models.dart';
import '../../widgets/shared_widgets.dart';
import '../home/main_screen.dart';

class CourseSuccessScreen extends StatelessWidget {
  final Course course;
  const CourseSuccessScreen({super.key, required this.course});

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
                    color: AppColors.primaryLight, shape: BoxShape.circle),
                child: const Center(
                    child: Text('🏆', style: TextStyle(fontSize: 72)))),
            const SizedBox(height: 32),
            const Text('Congratulations!',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            Text(
                'Haz completado tu prueba de ${course.title}. Ya puedes participar por entrevistas en distintos empleos',
                textAlign: TextAlign.center,
                style: AppTextStyles.body),
            const Spacer(),
            SPButton(
                label: 'Volver Al Inicio',
                onTap: () => Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                    (r) => false)),
            const SizedBox(height: 16),
            const Text('Compartir', style: AppTextStyles.link),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const _SocialIcon(emoji: '💬', color: Color(0xFF25D366)),
              const SizedBox(width: 16),
              const _SocialIcon(emoji: '📸', color: Color(0xFFE1306C)),
              const SizedBox(width: 16),
              const _SocialIcon(emoji: '👤', color: Color(0xFF1877F2)),
              const SizedBox(width: 16),
              const _SocialIcon(emoji: '🐦', color: Color(0xFF1DA1F2)),
            ]),
            const SizedBox(height: 32),
          ]),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final String emoji;
  final Color color;
  const _SocialIcon({required this.emoji, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
            color: color.withOpacity(0.12), shape: BoxShape.circle),
        child:
            Center(child: Text(emoji, style: const TextStyle(fontSize: 20))));
  }
}
