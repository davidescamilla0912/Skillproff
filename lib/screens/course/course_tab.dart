import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../domain/entities/entities.dart';
import '../../application/usecases/get_courses_usecase.dart';
import '../../infrastructure/repositories/course_repository_impl.dart';
import '../course/detail_course_screen.dart';

class CourseTab extends StatelessWidget {
  const CourseTab({super.key});

  @override
  Widget build(BuildContext context) {
    final courseRepo = CourseRepositoryImpl();
    final courses = GetCoursesUseCase(courseRepo).call();

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Course', style: AppTextStyles.heading2),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1), child: Divider(height: 1)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: courses.length,
        itemBuilder: (context, i) {
          final course = courses[i];
          return _CourseListCard(
            course: course,
            onView: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => DetailCourseScreen(course: course))),
            onIgnore: () {},
          );
        },
      ),
    );
  }
}

class _CourseListCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback onView;
  final VoidCallback onIgnore;
  const _CourseListCard(
      {required this.course, required this.onView, required this.onIgnore});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.border)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                  color: course.bgColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: Image.network(course.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (ctx, e, s) =>
                          Icon(Icons.code, color: course.bgColor)))),
          const SizedBox(width: 12),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                    child: Text(course.title,
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600))),
                _SPChip(label: course.level),
              ]),
              const SizedBox(height: 2),
              Text(course.category,
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.textSecondary)),
              const SizedBox(height: 6),
              Row(children: [
                _InfoRow(
                    icon: Icons.access_time_outlined, text: course.duration),
                const SizedBox(width: 12),
                _InfoRow(
                    icon: Icons.people_outline,
                    text: '${course.students} students'),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                _ActionBtn(label: 'Ver', onTap: onView),
                const SizedBox(width: 8),
                _ActionBtn(label: 'Ignorar', onTap: onIgnore, outlined: true),
              ]),
            ]),
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool outlined;
  const _ActionBtn(
      {required this.label, required this.onTap, this.outlined = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
            color: outlined ? Colors.transparent : AppColors.primary,
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(6)),
        child: Text(label,
            style: TextStyle(
                fontSize: 12,
                color: outlined ? AppColors.primary : Colors.white,
                fontWeight: FontWeight.w500)),
      ),
    );
  }
}

class _SPChip extends StatelessWidget {
  final String label;
  const _SPChip({required this.label});
  @override
  Widget build(BuildContext context) {
    final isFree = label.toLowerCase() == 'free';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: isFree ? const Color(0xFFE8F5E9) : AppColors.primaryLight,
          borderRadius: BorderRadius.circular(4)),
      child: Text(label,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: isFree ? Colors.green : AppColors.primary)),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 13, color: AppColors.textSecondary),
      const SizedBox(width: 3),
      Text(text,
          style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
    ]);
  }
}
