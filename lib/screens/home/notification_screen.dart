// Pantalla de notificaciones del usuario. Muestra alertas
// y novedades de cursos o empleos.
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': '!BIENVENIDO!',
        'body': 'Bienvenido a Skillproof tu plataforma de empleo favorita',
        'time': '1 min ago'
      },
      {
        'title': 'continua tu ultima prueba!',
        'body': 'Termina tu prueba de Flask',
        'time': '10 min ago'
      },
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.of(context).pop()),
        title: const Text('Notification', style: AppTextStyles.heading3),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1), child: Divider(height: 1)),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (ctx, i) {
          final n = notifications[i];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.divider))),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.notifications_outlined,
                      color: AppColors.primary, size: 20)),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Expanded(
                          child: Text(n['title']!,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary))),
                      Text(n['time']!,
                          style: const TextStyle(
                              fontSize: 11, color: AppColors.textHint)),
                    ]),
                    const SizedBox(height: 4),
                    Text(n['body']!, style: AppTextStyles.body),
                  ])),
            ]),
          );
        },
      ),
    );
  }
}
