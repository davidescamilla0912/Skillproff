// Segunda pantalla de bienvenida/onboarding. Presenta la app
// y lleva al usuario a elegir su modalidad de clase.
import 'package:flutter/material.dart';
import '../../widgets/shared_widgets.dart';
import 'class_option_screen.dart';

class Onboarding2Screen extends StatelessWidget {
  const Onboarding2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1565C0),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32)),
              ),
              child: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _Card(
                              child: const Icon(Icons.play_circle_fill,
                                  color: Color(0xFF1565C0), size: 28)),
                          const SizedBox(width: 8),
                          _Card(
                              child: const Icon(Icons.image,
                                  color: Color(0xFF1565C0), size: 28)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: 110,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.person,
                            color: Colors.white, size: 56),
                      ),
                      const SizedBox(height: 12),
                      _Card(
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                            Icon(Icons.chat_bubble_outline,
                                color: Color(0xFF1565C0), size: 14),
                            SizedBox(width: 4),
                            Text('hello!',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w500))
                          ])),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'SkillProof es una plataforma que impulsa a jovenes sin experiencia a demostrar su talento y acceder a sus primeras oportunidades laborales.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, color: Color(0xFF757575), height: 1.6),
                  ),
                  SPButton(
                      label: 'siguiente',
                      onTap: () => Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (_) => const ClassOptionScreen()))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ]),
      child: child,
    );
  }
}
