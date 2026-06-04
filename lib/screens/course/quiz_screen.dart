// Pantalla del quiz de evaluación del curso. Presenta preguntas
// una a una y al terminar navega a éxito o fallo según el puntaje.
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/models/api_models.dart';
import '../../widgets/shared_widgets.dart';
import 'course_success_screen.dart';
import 'course_fail_screen.dart';

class QuizScreen extends StatefulWidget {
  final Course course;
  const QuizScreen({super.key, required this.course});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _current = 0;
  int? _selectedOption;
  int _score = 0;
  bool _answered = false;

  List<QuizQuestion> get _questions => widget.course.questions;

  void _select(int index) {
    if (_answered) return;
    setState(() {
      _selectedOption = index;
      _answered = true;
      if (index == _questions[_current].correctIndex) _score++;
    });
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() {
        _current++;
        _selectedOption = null;
        _answered = false;
      });
    } else {
      final passed = _score >= (_questions.length * 0.6).ceil();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => passed
            ? CourseSuccessScreen(course: widget.course)
            : CourseFailScreen(course: widget.course),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.backgroundGrey,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('No hay preguntas disponibles'),
              const SizedBox(height: 16),
              SPButton(
                label: 'Volver',
                onTap: () => Navigator.of(context).pop(),
                width: 160,
              ),
            ],
          ),
        ),
      );
    }
    final question = _questions[_current];
    final progress = (_current + 1) / _questions.length;

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(Icons.close, color: AppColors.textPrimary),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: AppColors.primaryLight,
                        valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                        minHeight: 8,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text('${_current + 1} de ${_questions.length}', style: AppTextStyles.caption),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(question.question, style: AppTextStyles.heading3),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: question.options.length,
                  itemBuilder: (context, i) {
                    Color bg = Colors.white;
                    Color border = AppColors.border;
                    Color text = AppColors.textPrimary;
                    if (_answered) {
                      if (i == question.correctIndex) {
                        bg = const Color(0xFFE8F5E9);
                        border = Colors.green;
                        text = Colors.green;
                      } else if (i == _selectedOption) {
                        bg = const Color(0xFFFFEBEE);
                        border = Colors.red;
                        text = Colors.red;
                      }
                    } else if (_selectedOption == i) {
                      bg = widget.course.bgColor.withOpacity(0.1);
                      border = widget.course.bgColor;
                      text = widget.course.bgColor;
                    }
                    return GestureDetector(
                      onTap: () => _select(i),
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            )
                          ],
                          border: Border.all(color: border, width: 1.5),
                        ),
                        child: Text(
                          question.options[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 13, color: text, fontWeight: FontWeight.w600),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SPButton(
                label: _current < _questions.length - 1 ? 'Continuar' : 'Finalizar',
                onTap: _answered ? _next : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
