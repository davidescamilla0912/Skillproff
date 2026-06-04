// UseCase para inicializar la carga de datos (delegación a course repository)
import '../../domain/repositories/course_repository.dart';

class LoadDataUseCase {
  final CourseRepository repository;
  LoadDataUseCase(this.repository);

  Future<void> call() => repository.loadData();
}

