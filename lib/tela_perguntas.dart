import 'package:flutter/material.dart';
import 'pergunta_loader.dart';
import 'main.dart';

class TelaPergunta extends StatefulWidget {
  @override
  State<TelaPergunta> createState() => _TelaPerguntaState();
}

class _TelaPerguntaState extends State<TelaPergunta> {
  List<Pergunta> perguntas = [];
  int perguntaAtual = 0;
  int pontuacao = 0;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregar();
  }

  void carregar() async {
    perguntas = await carregarPerguntas();
    perguntas.shuffle();
    setState(() {
      carregando = false;
    });
  }

  void responder(String respostaSelecionada) {
    if (respostaSelecionada == perguntas[perguntaAtual].resposta) {
      setState(() {
        pontuacao++;
      });
    }

    if (perguntaAtual + 1 < perguntas.length) {
      setState(() {
        perguntaAtual++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              Resultado(pontuacao: pontuacao, total: perguntas.length),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final pergunta = perguntas[perguntaAtual];

    return Scaffold(
      appBar: AppBar(
        title: Text("Pergunta ${perguntaAtual + 1}"),
        backgroundColor: const Color.fromARGB(255, 243, 152, 33),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/deserto.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("💀 Pontos: ", style: TextStyle(fontSize: 16)),
                        Text(
                          "$pontuacao",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  pergunta.pergunta,
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                SizedBox(height: 30),
                ...pergunta.opcoes.map(
                  (opcao) => Resposta(
                    texto: opcao,
                    aoResponder: () => responder(opcao),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Resposta extends StatelessWidget {
  final String texto;
  final VoidCallback aoResponder;

  const Resposta({required this.texto, required this.aoResponder});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton(
        onPressed: aoResponder,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 243, 152, 33),
          padding: EdgeInsets.all(16),
        ),
        child: Text(texto),
      ),
    );
  }
}

class Resultado extends StatelessWidget {
  final int pontuacao;
  final int total;

  const Resultado({required this.pontuacao, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Resultado"),
        backgroundColor: const Color.fromARGB(255, 243, 152, 33),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/deserto.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Você acertou $pontuacao de $total perguntas!",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaInicial()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 152, 33),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                  minimumSize: Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 10,
                ),
                child: Text(
                  "RECOMEÇAR",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 240, 117, 17),
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
