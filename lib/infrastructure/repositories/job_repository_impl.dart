// Implementación de infraestructura para empleos que delega en `DataService`.
import '../../domain/repositories/job_repository.dart';
import '../../domain/entities/entities.dart';
import '../../services/data_service.dart';

class JobRepositoryImpl implements JobRepository {
  final DataService _data = DataService();

  @override
  List<JobModel> getJobs() => _data.jobs;

  @override
  JobModel? getJobByCompany(String company) => _data.getJobByCompany(company);

  @override
  void addJob(JobModel job) => _data.addJob(job);

  @override
  void deleteJob(String company) => _data.deleteJob(company);
}

