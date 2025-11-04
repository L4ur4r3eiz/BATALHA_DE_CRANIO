import 'dart:convert';
import 'package:batalha_de_cranios/data/http/execeptions.dart';
import 'package:batalha_de_cranios/data/http/http_usuario.dart';
import 'package:batalha_de_cranios/data/models/perguntas_models.dart';

abstract class IPerguntasRepository {
  Future<List<PerguntaModels>> getPerguntas(); 
}

class PerguntasRepository implements IPerguntasRepository {
  final IHttpUsuario client;
  PerguntasRepository({required this.client});

  @override
  Future<List<PerguntaModels>> getPerguntas() async { 
    final response = await client.get(
      url: 'https://localhost:7149/api/Pergunta');

    if (response.statusCode == 200) {
      final List<PerguntaModels> perguntas = [];
      final dynamic body = jsonDecode(response.body); 

     
      if (body is List) {
        body.map((pergunta) {
          perguntas.add(PerguntaModels.frommap(pergunta));
        }).toList();
      } else if (body is Map && body.containsKey('products')) { 
        body['products'].map((pergunta) {
          perguntas.add(PerguntaModels.frommap(pergunta));
        }).toList();
      } else {
       
        throw Exception('Formato de resposta inesperado da API.');
      }

      return perguntas;
    } else if (response.statusCode == 404) {
      throw NotFoudException('Failed to load perguntas: Perguntas não encontradas.');
    } else {
      
      throw Exception('Falha ao carregar perguntas com status: ${response.statusCode}');
    }
  }
}