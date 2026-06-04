// Puerto (interface) para acceder a cursos desde la capa de dominio.
import '../entities/entities.dart';

abstract class CourseRepository {
  Future<void> loadData();

  List<CourseModel> getCourses();

  List<CourseModel> getCoursesInProgress();

  CourseModel? getCourseById(String id);

  List<QuizQuestion> getPreguntasByCourse(String courseId);

  void addCourse(CourseModel course);

  void updateCourseProgress(String courseId, double nuevoProgreso);

  void deleteCourse(String courseId);

  void likeCourse(String courseId);

  // Opciones de onboarding / categorías
  List<Map<String, String>> getSkillCategories();

  List<String> getCourseOptions();
}

