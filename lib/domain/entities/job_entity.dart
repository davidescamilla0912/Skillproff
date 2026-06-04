// Define el modelo JobModel con los datos de una oferta laboral:
// empresa, cargo, salario, color del logo y descripción.
import 'package:flutter/material.dart';

class JobModel {
  String company;
  String title;
  String timeAgo;
  int applicants;
  Color logoColor;
  String emoji;
  String imageUrl;

  JobModel({
    required this.company,
    required this.title,
    required this.timeAgo,
    required this.applicants,
    required this.logoColor,
    required this.emoji,
    required this.imageUrl,
  });
}

