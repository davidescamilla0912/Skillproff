// Pantalla donde el usuario selecciona los cursos de su interés
// al registrarse. Navega a MainScreen al confirmar.
import 'package:flutter/material.dart';
import '../../data/services/backend_service.dart';
import '../../application/usecases/save_category_usecase.dart';
import '../../infrastructure/repositories/session_repository_impl.dart';
import '../../widgets/shared_widgets.dart';
import '../home/main_screen.dart';

class CourseOptionScreen extends StatefulWidget {
  const CourseOptionScreen({super.key});
  @override
  State<CourseOptionScreen> createState() => _CourseOptionScreenState();
}

class _CourseOptionScreenState extends State<CourseOptionScreen> {
  String? _selected;
  final _backend = BackendService();
  late Future<List<String>> _optionsFuture;
  final _sessionRepo = SessionRepositoryImpl();
  late final _saveCategory = SaveCategoryUseCase(_sessionRepo);

  @override
  void initState() {
    super.initState();
    _optionsFuture = _backend.getHabilidades();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              color: Color(0xFF1565C0),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(80),
                  bottomRight: Radius.circular(80)),
            ),
            child: const SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                      'De Los Siguientes Cual\nTe Desempenas Mejor',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.3)),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<String>>(
              future: _optionsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final options = snapshot.data ?? [];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Column(
                    children: [
                      ...options.map((opt) => GestureDetector(
                            onTap: () => setState(() => _selected = opt),
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: _selected == opt
                                        ? const Color(0xFF2196F3)
                                        : const Color(0xFFE0E0E0),
                                    width: _selected == opt ? 1.5 : 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(opt,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: _selected == opt
                                          ? const Color(0xFF2196F3)
                                          : const Color(0xFF212121),
                                      fontWeight: _selected == opt
                                          ? FontWeight.w600
                                          : FontWeight.w400)),
                            ),
                          )),
                      const Spacer(),
                      SPButton(
                        label: 'empezar',
                        onTap: _selected != null
                            ? () async {
                                // Guarda la categoria elegida en shared_preferences
                                await _saveCategory.call(_selected!);
                                if (!context.mounted) return;
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (_) => const MainScreen()),
                                    (r) => false);
                              }
                            : null,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

