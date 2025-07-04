import 'package:flutter/material.dart';

void main() => runApp(const MeuApp());

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TelaInicial());
  }
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/deserto.jpg'),
   fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.7,
                child: Image.asset('images/titulo.png', fit: BoxFit.cover),
              ),

              SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TelaPergunta()),
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
                  "COMERÇAR",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 0, 0, 0),
                    shadows: [
                      Shadow(
                        color: const Color.fromARGB(
                          255,
                          240,
                          117,
                          17,
                        ).withOpacity(1),
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

class TelaPergunta extends StatelessWidget {
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
                "Qual é a capital do Brasil?",
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 30),
              Resposta(texto: "Rio de Janeiro"),
              Resposta(texto: "Brasília", correta: true),
              Resposta(texto: "São Paulo"),
              Resposta(texto: "Salvador"),
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
          backgroundColor: correta
              ? Colors.green
              : const Color.fromARGB(255, 243, 152, 33),
        ),
        child: Text(texto),
      ),
    );
  }
}
