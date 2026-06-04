// Puerto (interface) para acceder a empleos desde la capa de dominio.
import '../entities/entities.dart';

abstract class JobRepository {
  List<JobModel> getJobs();

  JobModel? getJobByCompany(String company);

  void addJob(JobModel job);

  void deleteJob(String company);
}

