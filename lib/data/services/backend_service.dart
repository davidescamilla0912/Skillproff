import '../../core/network/api_service.dart';
import '../models/api_models.dart';

class BackendService {
  final ApiService _api = ApiService();

  // AUTH
  Future<Map<String, dynamic>> login(String email, String password) async {
    final res = await _api.request('/auth/login', method: 'POST', data: {
      'email': email,
      'password': password,
    });
    return res.data; // Esperamos { "token": "...", "user": {...} }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> userData) async {
    final res = await _api.request('/auth/register', method: 'POST', data: userData);
    return res.data;
  }

  // USER
  Future<UserModel> getMe(int userId) async {
    final res = await _api.request('/users/me', method: 'GET', queryParameters: {'user_id': userId});
    return UserModel.fromMap(res.data);
  }

  Future<void> updateMe(int userId, Map<String, dynamic> data) async {
    await _api.request('/users/me', method: 'PUT', queryParameters: {'user_id': userId}, data: data);
  }

  Future<List<Map<String, dynamic>>> getVerifiedSkills(int userId) async {
    final res = await _api.request('/users/me/verified-skills', method: 'GET', queryParameters: {'user_id': userId});
    return List<Map<String, dynamic>>.from(res.data);
  }

  // CORE DATA
  Future<List<Map<String, String>>> getAreas() async {
    final res = await _api.request('/areas', method: 'GET');
    return (res.data as List).map((e) => Map<String, String>.from(e)).toList();
  }

  Future<List<String>> getHabilidades() async {
    final res = await _api.request('/habilidades', method: 'GET');
    return List<String>.from(res.data);
  }

  // COURSES
  Future<List<Course>> getCourses() async {
    try {
      final res = await _api.request('/courses', method: 'GET');
      final dynamic data = res.data;
      List list = [];
      if (data is List) {
        list = data;
      } else if (data is Map && data.containsKey('courses')) {
        list = data['courses'];
      }
      return list.map((c) => Course.fromMap(c)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<Course> getCourseById(String id) async {
    final res = await _api.request('/courses/$id', method: 'GET');
    return Course.fromMap(res.data);
  }

  // JOBS
  Future<List<Job>> getJobs() async {
    try {
      final res = await _api.request('/jobs', method: 'GET');
      final dynamic data = res.data;
      List list = [];
      if (data is List) {
        list = data;
      } else if (data is Map && data.containsKey('jobs')) {
        list = data['jobs'];
      }
      return list.map((j) => Job.fromMap(j)).toList();
    } catch (e) {
      return [];
    }
  }

  // APPLICATIONS
  Future<List<Application>> getApplications(int userId) async {
    final res = await _api.request('/applications', method: 'GET', queryParameters: {'user_id': userId});
    return (res.data as List).map((a) => Application.fromMap(a)).toList();
  }

  Future<void> postApplication(Map<String, dynamic> applicationData) async {
    await _api.request('/applications', method: 'POST', data: applicationData);
  }
}
