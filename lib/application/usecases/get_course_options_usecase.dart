import '../../domain/repositories/course_repository.dart';

class GetCourseOptionsUseCase {
  final CourseRepository repository;
  GetCourseOptionsUseCase(this.repository);

  List<String> call() => repository.getCourseOptions();
}


