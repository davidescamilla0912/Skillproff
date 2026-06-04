import '../../domain/repositories/course_repository.dart';

class UpdateCourseProgressUseCase {
  final CourseRepository repository;
  UpdateCourseProgressUseCase(this.repository);

  void call(String courseId, double nuevoProgreso) =>
      repository.updateCourseProgress(courseId, nuevoProgreso);
}

