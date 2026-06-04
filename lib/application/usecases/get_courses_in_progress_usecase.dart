import '../../domain/repositories/course_repository.dart';
import '../../domain/entities/entities.dart';

class GetCoursesInProgressUseCase {
  final CourseRepository repository;
  GetCoursesInProgressUseCase(this.repository);

  List<CourseModel> call() => repository.getCoursesInProgress();
}

