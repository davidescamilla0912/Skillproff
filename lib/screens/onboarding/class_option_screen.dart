// Pantalla donde el usuario elige su modalidad preferida
// (presencial, virtual, etc.) durante el onboarding.
import 'package:flutter/material.dart';
import '../../application/usecases/get_skill_categories_usecase.dart';
import '../../infrastructure/repositories/course_repository_impl.dart';
import '../../widgets/shared_widgets.dart';
import 'course_option_screen.dart';

class ClassOptionScreen extends StatefulWidget {
  const ClassOptionScreen({super.key});
  @override
  State<ClassOptionScreen> createState() => _ClassOptionScreenState();
}

class _ClassOptionScreenState extends State<ClassOptionScreen> {
  String? _selected;
  final _courseRepo = CourseRepositoryImpl();
  late final _getSkillCategories = GetSkillCategoriesUseCase(_courseRepo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _BlueArc(title: 'De Los Siguientes Cual\nTe Desempenas Mejor'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child: Column(
                children: [
                  ..._getSkillCategories.call().map((cat) => _OptionTile(
                        label: cat['label']!,
                        isSelected: _selected == cat['id'],
                        onTap: () => setState(() => _selected = cat['id']),
                      )),
                  const Spacer(),
                  SPButton(
                    label: 'siguiente',
                    onTap: _selected != null
                        ? () => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (_) => const CourseOptionScreen()))
                        : null,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlueArc extends StatelessWidget {
  final String title;
  const _BlueArc({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
        color: Color(0xFF1565C0),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(80), bottomRight: Radius.circular(80)),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3)),
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _OptionTile(
      {required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: isSelected
                  ? const Color(0xFF2196F3)
                  : const Color(0xFFE0E0E0),
              width: isSelected ? 1.5 : 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                color: isSelected
                    ? const Color(0xFF2196F3)
                    : const Color(0xFF212121),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400)),
      ),
    );
  }
}
