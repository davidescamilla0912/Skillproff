// Define el modelo CourseModel con los datos de un curso:
// id, título, imagen, color, capítulos completados y preguntas del quiz.
import 'package:flutter/material.dart';
import 'quiz_question_entity.dart';

class CourseModel {
  String id;
  String title;
  String category;
  String tags;
  String duration;
  int chapters;
  int students;
  int reviews;
  String level;
  Color bgColor;
  String emoji;
  String imageUrl;
  String description;
  double progress;
  List<String> syllabus;
  List<QuizQuestion> questions;

  CourseModel({
    required this.id,
    required this.title,
    required this.category,
    required this.tags,
    required this.duration,
    required this.chapters,
    required this.students,
    required this.reviews,
    required this.level,
    required this.bgColor,
    required this.emoji,
    required this.imageUrl,
    required this.description,
    this.progress = -1,
    this.syllabus = const [],
    this.questions = const [],
  });
}

