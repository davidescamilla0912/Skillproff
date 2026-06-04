// Servicio de datos: carga cursos y empleos desde los assets JSON.
// Es la única fuente de datos de la app (simula un repositorio).
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../domain/entities/entities.dart';

// Servicio que simula un backend (trabaja con JSON + memoria)

class DataService {
  // "Base de datos
  List<CourseModel> courses = [];
  List<QuizQuestion> preguntas = [];
  List<JobModel> jobs = [];
  List<Map<String, String>> skillCategories = [];
  List<String> courseOptions = [];

  bool loaded = false; // Controla si ya cargamos el JSON

  // Singleton: una sola instancia en toda la app
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  // Inicializa los datos desde el JSON
  Future<void> loadData() async {
    if (loaded) return;

    // Carga el archivo JSON desde assets
    final String jsonString =
        await rootBundle.loadString('assets/data/courses.json');

    final data = jsonDecode(jsonString);

    // Cargar cursos
    courses = (data['courses'] as List)
        .map((c) => CourseModel(
              id: c['id'],
              title: c['title'],
              category: c['category'],
              tags: c['tags'],
              duration: c['duration'],
              chapters: c['chapters'],
              students: c['students'],
              reviews: c['reviews'],
              level: c['level'],
              bgColor: Color(int.parse(c['bgColor'])),
              emoji: c['emoji'],
              imageUrl: c['imageUrl'] ?? '',
              description: c['description'],
              progress: (c['progress'] as num).toDouble(),
              syllabus: List<String>.from(c['syllabus']),
            ))
        .toList();

    // Cargar preguntas
    preguntas = (data['preguntas'] as List)
        .map((q) => QuizQuestion(
              courseId: q['course_id'],
              question: q['question'],
              options: List<String>.from(q['options']),
              correctIndex: q['correctIndex'],
            ))
        .toList();

    // Asignar preguntas a cada curso por relación course_id
    for (final course in courses) {
      course.questions =
          preguntas.where((q) => q.courseId == course.id).toList();
    }

    // Cargar empleos
    jobs = (data['jobs'] as List)
        .map((j) => JobModel(
              company: j['company'],
              title: j['title'],
              timeAgo: j['timeAgo'],
              applicants: j['applicants'],
              logoColor: Color(int.parse(j['logoColor'])),
              emoji: j['emoji'],
              imageUrl: j['imageUrl'] ?? '',
            ))
        .toList();

    // Cargar categorías de habilidades
    skillCategories = (data['skillCategories'] as List)
        .map((c) => {'label': c['label'] as String, 'id': c['id'] as String})
        .toList();

    // Cargar opciones de curso
    courseOptions =
        (data['courseOptions'] as List).map((o) => o as String).toList();

    loaded = true;
  }

  // READ → obtener todos los cursos
  List<CourseModel> getCourses() => courses;

  // READ → obtener cursos en progreso
  List<CourseModel> getCoursesInProgress() {
    return courses.where((c) => c.progress > 0).toList();
  }

  // READ → obtener curso por ID
  CourseModel? getCourseById(String id) {
    try {
      return courses.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  // READ → obtener preguntas de un curso
  List<QuizQuestion> getPreguntasByCourse(String courseId) {
    return preguntas.where((q) => q.courseId == courseId).toList();
  }

  // READ → obtener empleo por empresa
  JobModel? getJobByCompany(String company) {
    try {
      return jobs.firstWhere((j) => j.company == company);
    } catch (_) {
      return null;
    }
  }

  // CREATE → agregar curso
  void addCourse(CourseModel course) {
    courses.add(course);
  }

  // CREATE → agregar empleo
  void addJob(JobModel job) {
    jobs.add(job);
  }

  // UPDATE → editar progreso de un curso
  void updateCourseProgress(String courseId, double nuevoProgreso) {
    final index = courses.indexWhere((c) => c.id == courseId);
    if (index != -1) {
      courses[index].progress = nuevoProgreso;
    }
  }

  // DELETE → eliminar curso
  void deleteCourse(String courseId) {
    courses.removeWhere((c) => c.id == courseId);
    // También eliminar sus preguntas relacionadas
    preguntas.removeWhere((q) => q.courseId == courseId);
  }

  // DELETE → eliminar empleo
  void deleteJob(String company) {
    jobs.removeWhere((j) => j.company == company);
  }

  // LIKE → marcar curso como favorito
  void likeCourse(String courseId) {
    final course = courses.firstWhere((c) => c.id == courseId,
        orElse: () => throw Exception('Curso no encontrado'));
    // Si progress es -1 (no iniciado), lo marca como visto (0.0)
    if (course.progress < 0) {
      course.progress = 0.0;
    }
  }
}
