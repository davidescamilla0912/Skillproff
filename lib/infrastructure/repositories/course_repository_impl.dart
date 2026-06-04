// Implementación de infraestructura que delega en `DataService`.
import '../../domain/repositories/course_repository.dart';
import '../../domain/entities/entities.dart';
import '../../services/data_service.dart';

class CourseRepositoryImpl implements CourseRepository {
  final DataService _data = DataService();

  @override
  Future<void> loadData() => _data.loadData();

  @override
  List<CourseModel> getCourses() => _data.getCourses();

  @override
  List<CourseModel> getCoursesInProgress() => _data.getCoursesInProgress();

  @override
  CourseModel? getCourseById(String id) => _data.getCourseById(id);

  @override
  List<QuizQuestion> getPreguntasByCourse(String courseId) =>
      _data.getPreguntasByCourse(courseId);

  @override
  void addCourse(CourseModel course) => _data.addCourse(course);

  @override
  void updateCourseProgress(String courseId, double nuevoProgreso) =>
      _data.updateCourseProgress(courseId, nuevoProgreso);

  @override
  void deleteCourse(String courseId) => _data.deleteCourse(courseId);

  @override
  void likeCourse(String courseId) => _data.likeCourse(courseId);

  @override
  List<Map<String, String>> getSkillCategories() => _data.skillCategories;

  @override
  List<String> getCourseOptions() => _data.courseOptions;
}

