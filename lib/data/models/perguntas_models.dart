class PerguntaModels{
  final String pergunta;
  final List<String> respostas;
  final String respostaCerta;

  PerguntaModels({
    required this.pergunta,
    required this.respostas,
    required this.respostaCerta,
  });


   

    PerguntaModels.frommap(Map<String, dynamic> map) 
      : pergunta = map['pergunta'],
        respostas = List<String>.from(map['respostas']),
        respostaCerta = map['resposta_certa'];
}