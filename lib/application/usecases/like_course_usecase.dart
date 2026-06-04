import '../../domain/repositories/course_repository.dart';

class LikeCourseUseCase {
  final CourseRepository repository;
  LikeCourseUseCase(this.repository);

  void call(String courseId) => repository.likeCourse(courseId);
}

