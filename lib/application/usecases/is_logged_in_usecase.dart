import '../../domain/repositories/session_repository.dart';

class IsLoggedInUseCase {
  final SessionRepository repository;
  IsLoggedInUseCase(this.repository);

  Future<bool> call() => repository.isLoggedIn();
}

