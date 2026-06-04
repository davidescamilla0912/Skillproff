import '../../domain/repositories/course_repository.dart';
import '../../domain/entities/entities.dart';

class GetCourseByIdUseCase {
  final CourseRepository repository;
  GetCourseByIdUseCase(this.repository);

  CourseModel? call(String id) => repository.getCourseById(id);
}

