import '../../domain/repositories/session_repository.dart';

class GetUserDataUseCase {
  final SessionRepository repository;
  GetUserDataUseCase(this.repository);

  Future<Map<String, String>> call() => repository.getUserData();
}

