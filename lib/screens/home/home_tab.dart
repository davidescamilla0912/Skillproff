// Tab de inicio. Muestra barra de búsqueda, cursos en progreso,
// carrusel de recomendados con auto-scroll cada 3 seg, y empleos.
import 'dart:async';
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../domain/entities/entities.dart';
import '../../application/usecases/get_courses_usecase.dart';
import '../../application/usecases/get_courses_in_progress_usecase.dart';
import '../../application/usecases/get_jobs_usecase.dart';
import '../../infrastructure/repositories/course_repository_impl.dart';
import '../../infrastructure/repositories/job_repository_impl.dart';
import '../course/detail_course_screen.dart';
import 'notification_screen.dart';
import 'empresa_detail_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final courseRepo = CourseRepositoryImpl();
    final jobRepo = JobRepositoryImpl();
    final inProgress = GetCoursesInProgressUseCase(courseRepo).call();
    final allCourses = GetCoursesUseCase(courseRepo).call();
    final sampleJobs = GetJobsUseCase(jobRepo).call();

    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            if (inProgress.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Text('Continuar', style: AppTextStyles.heading3),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: inProgress.length,
                    itemBuilder: (ctx, i) => _ContinueCard(
                      course: inProgress[i],
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>
                              DetailCourseScreen(course: inProgress[i]))),
                    ),
                  ),
                ),
              ),
            ],
            SliverToBoxAdapter(child: _buildTabs()),
            SliverToBoxAdapter(
              child: _CourseCarousel(
                courses: allCourses,
                onTap: (course) => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => DetailCourseScreen(course: course))),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Empleos', style: AppTextStyles.heading3),
                    TextButton(
                        onPressed: () {},
                        child:
                            const Text('Ver Todo', style: AppTextStyles.link)),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => _JobCard(
                  job: sampleJobs[i],
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => EmpresaDetailScreen(job: sampleJobs[i]))),
                ),
                childCount: sampleJobs.length,
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('¿En qué deseas postularte hoy?',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary)),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const NotificationScreen())),
                child: const Icon(Icons.notifications_outlined,
                    color: AppColors.textSecondary, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            height: 42,
            decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.border)),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Buscar prueba...',
                hintStyle: TextStyle(fontSize: 14, color: AppColors.textHint),
                prefixIcon:
                    Icon(Icons.search, color: AppColors.textHint, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 11),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          _TabLabel(label: 'Recomendado', isSelected: true),
          const SizedBox(width: 20),
          _TabLabel(label: 'Nuevo', isSelected: false),
          const SizedBox(width: 20),
          _TabLabel(label: 'Recientes', isSelected: false),
        ],
      ),
    );
  }
}

class _CourseCarousel extends StatefulWidget {
  final List<CourseModel> courses;
  final void Function(CourseModel) onTap;
  const _CourseCarousel({required this.courses, required this.onTap});

  @override
  State<_CourseCarousel> createState() => _CourseCarouselState();
}

class _CourseCarouselState extends State<_CourseCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.82);
  int _current = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || widget.courses.isEmpty) return;
      final next = (_current + 1) % widget.courses.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          SizedBox(
            height: 220,
            child: GestureDetector(
              onHorizontalDragUpdate: (_) {},
              child: PageView.builder(
                controller: _controller,
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: widget.courses.length,
                onPageChanged: (i) => setState(() => _current = i),
                itemBuilder: (ctx, i) {
                  final course = widget.courses[i];
                  final isActive = i == _current;
                  return AnimatedScale(
                    scale: isActive ? 1.0 : 0.93,
                    duration: const Duration(milliseconds: 250),
                    child: _CarouselCard(
                      course: course,
                      onTap: () => widget.onTap(course),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.courses.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: i == _current ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: i == _current ? AppColors.primary : AppColors.border,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CarouselCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback onTap;
  const _CarouselCard({required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                height: 130,
                width: double.infinity,
                color: course.bgColor.withOpacity(0.12),
                child: Image.network(
                  course.imageUrl,
                  fit: BoxFit.contain,
                  loadingBuilder: (ctx, child, progress) {
                    if (progress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: course.bgColor,
                        value: progress.expectedTotalBytes != null
                            ? progress.cumulativeBytesLoaded /
                                progress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (c, e, s) =>
                      Icon(Icons.code, size: 64, color: course.bgColor),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(course.title,
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 2),
                        Text(course.tags,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: onTap,
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        child: const Text('Ver',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.primary)),
                      ),
                      const SizedBox(width: 12),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                        child: const Text('Discuss',
                            style: TextStyle(
                                fontSize: 13, color: AppColors.primary)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  final CourseModel course;
  final VoidCallback onTap;
  const _ContinueCard({required this.course, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 44,
                height: 44,
                color: course.bgColor.withOpacity(0.12),
                padding: const EdgeInsets.all(6),
                child: Image.network(course.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) =>
                        Icon(Icons.code, color: course.bgColor, size: 20)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(course.title,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                      value: course.progress,
                      backgroundColor: AppColors.primaryLight,
                      valueColor:
                          const AlwaysStoppedAnimation(AppColors.primary),
                      minHeight: 4,
                      borderRadius: BorderRadius.circular(2)),
                  const SizedBox(height: 2),
                  Text(
                      '${(course.progress * course.chapters).round()}/${course.chapters} capítulos',
                      style: const TextStyle(
                          fontSize: 10, color: AppColors.textHint)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback? onTap;
  const _JobCard({required this.job, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 52,
                height: 52,
                color: Colors.white,
                padding: const EdgeInsets.all(6),
                child: Image.network(job.imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (c, e, s) =>
                        Icon(Icons.business, color: job.logoColor, size: 28)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(job.company,
                      style: const TextStyle(
                          fontSize: 13, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 2),
                  Text(job.title,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 6),
                  Row(children: [
                    const Icon(Icons.access_time,
                        size: 12, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text(job.timeAgo,
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textHint)),
                    const SizedBox(width: 12),
                    const Icon(Icons.people_outline,
                        size: 12, color: AppColors.textHint),
                    const SizedBox(width: 4),
                    Text('${job.applicants} aplicantes',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.textHint)),
                  ]),
                ])),
          ],
        ),
      ),
    );
  }
}

class _TabLabel extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _TabLabel({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label,
            style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? AppColors.textPrimary
                    : AppColors.textSecondary)),
        if (isSelected) ...[
          const SizedBox(height: 4),
          Container(height: 2, width: 24, color: AppColors.primary),
        ],
      ],
    );
  }
}
