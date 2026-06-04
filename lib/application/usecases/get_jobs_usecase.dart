import '../../domain/repositories/job_repository.dart';
import '../../domain/entities/entities.dart';

class GetJobsUseCase {
  final JobRepository repository;
  GetJobsUseCase(this.repository);

  List<JobModel> call() => repository.getJobs();
}

