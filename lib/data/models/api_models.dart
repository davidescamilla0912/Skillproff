import 'package:flutter/material.dart';

class UserModel {
  final int id;
  final String email;
  final String? name;
  final String? role;

  UserModel({required this.id, required this.email, this.name, this.role});

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        id: map['id'] ?? 0,
        email: map['email'] ?? '',
        name: map['name'],
        role: map['role'],
      );
}

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  factory QuizQuestion.fromMap(Map<String, dynamic> map) => QuizQuestion(
        question: map['question'] ?? '',
        options: List<String>.from(map['options'] ?? []),
        correctIndex: map['correctIndex'] ?? 0,
      );
}

class Course {
  final String id;
  final String title;
  final String description;
  final String category;
  final String tags;
  final String duration;
  final int chapters;
  final int students;
  final int reviews;
  final String level;
  final Color bgColor;
  final String imageUrl;
  final double progress;
  final List<String> syllabus;
  final List<QuizQuestion> questions;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.tags,
    required this.duration,
    required this.chapters,
    required this.students,
    required this.reviews,
    required this.level,
    required this.bgColor,
    required this.imageUrl,
    this.progress = -1,
    this.syllabus = const [],
    this.questions = const [],
  });

  factory Course.fromMap(Map<String, dynamic> map) => Course(
        id: (map['id_curso'] ?? map['id'])?.toString() ?? '',
        title: map['nombre'] ?? map['titulo'] ?? map['title'] ?? 'Sin título',
        description: map['descripcion'] ?? map['description'] ?? '',
        category: map['categoria'] ?? map['category'] ?? '',
        tags: map['tags'] ?? '',
        duration: map['duracion'] ?? map['duration'] ?? '',
        chapters: map['capitulos'] ?? map['chapters'] ?? 0,
        students: map['estudiantes'] ?? map['students'] ?? 0,
        reviews: map['reviews'] ?? 0,
        level: map['nivel'] ?? map['level'] ?? 'Básico',
        bgColor: _parseColor(map['color_fondo'] ?? map['bgColor']),
        imageUrl: map['imagen_url'] ?? map['imageUrl'] ?? '',
        progress: (map['progreso'] as num?)?.toDouble() ?? (map['progress'] as num?)?.toDouble() ?? -1,
        syllabus: List<String>.from(map['temario'] ?? map['syllabus'] ?? []),
        questions: (map['preguntas'] as List?)
                ?.map((q) => QuizQuestion.fromMap(q))
                .toList() ??
            [],
      );

  static Color _parseColor(dynamic value) {
    if (value == null) return const Color(0xFF2196F3);
    try {
      if (value is int) return Color(value);
      String colorStr = value.toString();
      if (colorStr.startsWith('#')) {
        colorStr = colorStr.replaceFirst('#', 'FF');
        return Color(int.parse(colorStr, radix: 16));
      }
      return Color(int.parse(colorStr));
    } catch (e) {
      return const Color(0xFF2196F3);
    }
  }
}

class Job {
  final String id;
  final String company;
  final String title;
  final String timeAgo;
  final int applicants;
  final Color logoColor;
  final String imageUrl;

  Job({
    required this.id,
    required this.company,
    required this.title,
    required this.timeAgo,
    required this.applicants,
    required this.logoColor,
    required this.imageUrl,
  });

  factory Job.fromMap(Map<String, dynamic> map) => Job(
        id: (map['id_empleo'] ?? map['id_empresa'] ?? map['id'])?.toString() ?? '',
        company: map['nombre_empresa'] ?? map['company'] ?? 'Empresa',
        title: map['cargo'] ?? map['title'] ?? 'Cargo',
        timeAgo: map['publicado_hace'] ?? map['timeAgo'] ?? '',
        applicants: map['aplicantes'] ?? map['applicants'] ?? 0,
        logoColor: _parseColor(map['color_logo'] ?? map['logoColor']),
        imageUrl: map['logo_url'] ?? map['imageUrl'] ?? '',
      );

  static Color _parseColor(dynamic value) {
    if (value == null) return const Color(0xFF2196F3);
    try {
      if (value is int) return Color(value);
      String colorStr = value.toString();
      if (colorStr.startsWith('#')) {
        colorStr = colorStr.replaceFirst('#', 'FF');
        return Color(int.parse(colorStr, radix: 16));
      }
      return Color(int.parse(colorStr));
    } catch (e) {
      return const Color(0xFF2196F3);
    }
  }
}

class Application {
  final String id;
  final String jobId;
  final String status;
  final String company;
  final String title;

  Application({
    required this.id,
    required this.jobId,
    required this.status,
    required this.company,
    required this.title,
  });

  factory Application.fromMap(Map<String, dynamic> map) => Application(
        id: map['id']?.toString() ?? '',
        jobId: map['job_id']?.toString() ?? '',
        status: map['status'] ?? 'pending',
        company: map['company'] ?? '',
        title: map['title'] ?? '',
      );
}



