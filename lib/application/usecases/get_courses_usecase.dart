import '../../domain/repositories/course_repository.dart';
import '../../domain/entities/entities.dart';

class GetCoursesUseCase {
  final CourseRepository repository;
  GetCoursesUseCase(this.repository);

  List<CourseModel> call() => repository.getCourses();
}

