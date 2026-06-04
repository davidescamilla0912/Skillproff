import '../../domain/repositories/session_repository.dart';

class SaveCategoryUseCase {
  final SessionRepository repository;
  SaveCategoryUseCase(this.repository);

  Future<void> call(String category) => repository.saveCategory(category);
}

