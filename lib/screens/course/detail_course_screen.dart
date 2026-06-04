// Pantalla de detalle de un curso. Muestra imagen, descripción,
// lista de capítulos y botón para iniciar el quiz.
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../data/models/api_models.dart';
import '../../widgets/shared_widgets.dart';
import 'quiz_screen.dart';

class DetailCourseScreen extends StatefulWidget {
  final Course course;
  const DetailCourseScreen({super.key, required this.course});
  @override
  State<DetailCourseScreen> createState() => _DetailCourseScreenState();
}

class _DetailCourseScreenState extends State<DetailCourseScreen> {
  bool _syllabusExpanded = true;

  @override
  Widget build(BuildContext context) {
    final course = widget.course;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(slivers: [
              SliverAppBar(
                  expandedHeight: 180,
                  pinned: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.textPrimary),
                      onPressed: () => Navigator.of(context).pop()),
                  flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                    color: course.bgColor.withOpacity(0.10),
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Image.network(
                        course.imageUrl,
                        fit: BoxFit.contain,
                        errorBuilder: (ctx, e, s) =>
                            Icon(Icons.code, size: 80, color: course.bgColor),
                      ),
                    ),
                  ))),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(),
                        Row(children: [
                          Expanded(
                              child: Text(course.title,
                                  style: AppTextStyles.heading2)),
                          _LevelBadge(level: course.level),
                        ]),
                        const SizedBox(height: 4),
                        Text(course.category,
                            style: const TextStyle(
                                color: AppColors.textSecondary, fontSize: 13)),
                        const SizedBox(height: 16),
                        const Text('Descripcion',
                            style: AppTextStyles.heading3),
                        const SizedBox(height: 8),
                        Text(course.description, style: AppTextStyles.body),
                        const SizedBox(height: 16),
                        const Text('Information',
                            style: AppTextStyles.heading3),
                        const SizedBox(height: 10),
                        Row(children: [
                          _InfoItem(
                              icon: Icons.access_time_outlined,
                              text: course.duration),
                          const SizedBox(width: 20),
                          _InfoItem(
                              icon: Icons.menu_book_outlined,
                              text: '${course.chapters} chapter'),
                        ]),
                        const SizedBox(height: 8),
                        Row(children: [
                          _InfoItem(
                              icon: Icons.people_outline,
                              text: '${course.students} students'),
                          const SizedBox(width: 20),
                          _InfoItem(
                              icon: Icons.star_outline,
                              text: '${course.reviews} reviews'),
                        ]),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () => setState(
                              () => _syllabusExpanded = !_syllabusExpanded),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Sylabus',
                                    style: AppTextStyles.heading3),
                                Icon(
                                    _syllabusExpanded
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: AppColors.textSecondary),
                              ]),
                        ),
                        if (_syllabusExpanded)
                          ...course.syllabus.asMap().entries.map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Row(children: [
                                  Container(
                                      width: 24,
                                      height: 24,
                                      decoration: const BoxDecoration(
                                          color: AppColors.primaryLight,
                                          shape: BoxShape.circle),
                                      child: Center(
                                          child: Text('${e.key + 1}',
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  color: AppColors.primary,
                                                  fontWeight:
                                                      FontWeight.w700)))),
                                  const SizedBox(width: 12),
                                  Text(e.value,
                                      style: AppTextStyles.bodyPrimary),
                                ]),
                              )),
                        const SizedBox(height: 80),
                      ]),
                ),
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.border))),
            child: SPButton(
              label: course.progress > 0 ? 'continuar' : 'empezar',
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => QuizScreen(course: course))),
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelBadge extends StatelessWidget {
  final String level;
  const _LevelBadge({required this.level});
  @override
  Widget build(BuildContext context) {
    final isFree = level.toLowerCase() == 'free';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
          color: isFree ? const Color(0xFFE8F5E9) : AppColors.primaryLight,
          borderRadius: BorderRadius.circular(4)),
      child: Text(level,
          style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isFree ? Colors.green : AppColors.primary)),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoItem({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 16, color: AppColors.textSecondary),
      const SizedBox(width: 6),
      Text(text,
          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
    ]);
  }
}
