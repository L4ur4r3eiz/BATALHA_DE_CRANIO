import 'dart:convert';
import 'package:flutter/services.dart';

class Pergunta {
  final String pergunta;
  final List<String> opcoes;
  final String resposta;

  Pergunta({
    required this.pergunta,
    required this.opcoes,
    required this.resposta,
  });

  factory Pergunta.fromJson(Map<String, dynamic> json) {
    return Pergunta(
      pergunta: json['pergunta'],
      opcoes: List<String>.from(json['opcoes']),
      resposta: json['resposta'],
    );
  }
}

Future<List<Pergunta>> carregarPerguntas() async {
  final String jsonString = await rootBundle.loadString('assets/perguntas.json');
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((e) => Pergunta.fromJson(e)).toList();
}
