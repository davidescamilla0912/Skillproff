// Pantalla de simulación de entrevista. Guía al usuario
// a través de preguntas típicas de entrevistas laborales.
import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';
import '../home/main_screen.dart';

class EntrevistaScreen extends StatelessWidget {
  const EntrevistaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop()),
          backgroundColor: Colors.white,
          elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Spacer(),
          const SPLogo(fontSize: 32),
          const SizedBox(height: 48),
          const Text(
              'una vez verificadas tus pruebas comenzaras con el proceso de entrevista',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16, color: Color(0xFF757575), height: 1.6)),
          const Spacer(),
          SPButton(
              label: 'back to home',
              onTap: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const MainScreen()),
                  (r) => false)),
          const SizedBox(height: 32),
        ]),
      ),
    );
  }
}
