// Define el modelo QuizQuestion: pregunta, opciones de respuesta
// y la respuesta correcta para el quiz de cada curso.
// Modelo de pregunta del quiz
class QuizQuestion {
  String courseId;
  String question;
  List<String> options;
  int correctIndex;

  QuizQuestion({
    required this.courseId,
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

