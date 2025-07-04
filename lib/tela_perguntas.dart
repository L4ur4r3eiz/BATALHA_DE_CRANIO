import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

Future<GerenciadorQuiz> carregarPerguntas() async {
  final String response = await rootBundle.loadString('assets/perguntas.json');
  final List<dynamic> data = await json.decode(response);
  return GerenciadorQuiz.fromJson(data);
}


class TelaPergunta extends StatefulWidget {
  @override
  _TelaPerguntaState createState() => _TelaPerguntaState();
}

class _TelaPerguntaState extends State<TelaPergunta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 152, 33),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color.fromARGB(255, 250, 117, 8),
          ),
          onPressed: () => Navigator.pop(context),
          // Volta pra tela anterior
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/deserto.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "A senha numérica do cofre eletrônico de Beto é composta por 5 algarismos distintos. Beto esqueceu sua senha, porém se lembra de que os 3 primeiros algarismos são ímpares e os dois últimos são pares. Nessas condições, o número máximo de tentativas de que Beto precisa para acessar seu cofre é igual",
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              SizedBox(height: 30),
              
              Resposta(texto: "100."),
              SizedBox(height: 15),
              Resposta(texto: "1 200.", correta: true),
              SizedBox(height: 15),
              Resposta(texto: "640."),
              SizedBox(height: 15),
              Resposta(texto: "1 000."),
              SizedBox(height: 15),
              Resposta(texto: "480"),
  
              
            ],
          ),
        ),
      ),
    );
  }
}

class Resposta extends StatelessWidget {
  final String texto;
  final bool correta;

  const Resposta({required this.texto, this.correta = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
           padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  minimumSize: Size(200, 60),
          backgroundColor: correta
              ? const Color.fromARGB(255, 243, 152, 33)
              : const Color.fromARGB(255, 243, 152, 33),
        ),
        child: Text(texto),
      ),
    );
  }
}

class PerguntaQuiz {
  final String pergunta;
  final List<String> opcoes;
  final String resposta;

  PerguntaQuiz({
    required this.pergunta,
    required this.opcoes,
    required this.resposta,
  });

  factory PerguntaQuiz.fromJson(Map<String, dynamic> json) {
    return PerguntaQuiz(
      pergunta: json['pergunta'],
      opcoes: List<String>.from(json['opcoes']),
      resposta: json['resposta'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pergunta': pergunta,
      'opcoes': opcoes,
      'resposta': resposta,
    };
  }

  bool respostaEstaCorreta(String respostaUsuario) {
    return respostaUsuario == resposta;
  }

  List<String> opcoesEmbaralhadas() {
    final listaEmbaralhada = List<String>.from(opcoes);
    listaEmbaralhada.shuffle();
    return listaEmbaralhada;
  }
}

class GerenciadorQuiz {
  final List<PerguntaQuiz> perguntas;

  GerenciadorQuiz({required this.perguntas});

  factory GerenciadorQuiz.fromJson(List<dynamic> jsonList) {
    return GerenciadorQuiz(
      perguntas: jsonList.map((json) => PerguntaQuiz.fromJson(json)).toList(),
    );
  }

  int get totalPerguntas => perguntas.length;

  PerguntaQuiz getPergunta(int index) {
    return perguntas[index];
  }

  void embaralharPerguntas() {
    perguntas.shuffle();
  }
}
