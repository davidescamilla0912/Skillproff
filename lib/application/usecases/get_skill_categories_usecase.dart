import '../../domain/repositories/course_repository.dart';

class GetSkillCategoriesUseCase {
  final CourseRepository repository;
  GetSkillCategoriesUseCase(this.repository);

  List<Map<String, String>> call() => repository.getSkillCategories();
}

