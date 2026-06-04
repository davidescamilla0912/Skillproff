// Centraliza los colores, estilos de texto y el ThemeData global
// de la app. Cambia aquí para afectar toda la paleta visual.
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFFE3F2FD);
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundGrey = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textLink = Color(0xFF2196F3);
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color darkHeader = Color(0xFF1565C0);
}

class AppTextStyles {
  static const TextStyle heading2 = TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle heading3 = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary);
  static const TextStyle body =
      TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5);
  static const TextStyle bodyPrimary =
      TextStyle(fontSize: 14, color: AppColors.textPrimary, height: 1.5);
  static const TextStyle caption =
      TextStyle(fontSize: 12, color: AppColors.textSecondary);
  static const TextStyle buttonText =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white);
  static const TextStyle link = TextStyle(
      fontSize: 14, color: AppColors.primary, fontWeight: FontWeight.w500);
}
