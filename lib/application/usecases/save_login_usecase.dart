import '../../domain/repositories/session_repository.dart';

class SaveLoginUseCase {
  final SessionRepository repository;
  SaveLoginUseCase(this.repository);

  Future<void> call({required String name, required String email, required String role}) =>
      repository.saveLogin(name: name, email: email, role: role);
}

