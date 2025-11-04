import 'package:batalha_de_cranios/data/models/perguntas_models.dart';
import 'package:flutter/material.dart';

class PerguntaStore {
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  final ValueNotifier<List<PerguntaModels>> perguntas =
      ValueNotifier<List<PerguntaModels>>([]);

  final ValueNotifier<String> erroMessage = ValueNotifier<String>('');

  getPerguntas() async {
    isLoading.value = true;
    erroMessage.value = '';

    try {
      await Future.delayed(Duration(seconds: 2));
      final perguntasCarregadas = [
        PerguntaModels(
          pergunta: 'Qual é a capital da França?',
          respostas: ['Paris', 'Londres', 'Berlim', 'Madrid'],
          respostaCerta: 'Paris',
        ),
        PerguntaModels(
          pergunta: 'Qual é o maior planeta do sistema solar?',
          respostas: ['Terra', 'Júpiter', 'Saturno', 'Marte'],
          respostaCerta: 'Júpiter',
        ),
      ];

      perguntas.value = perguntasCarregadas;
    } catch (e) {
      erroMessage.value = 'Erro ao carregar perguntas: $e';
    } finally {
      isLoading.value = false;
    }
  }
}
