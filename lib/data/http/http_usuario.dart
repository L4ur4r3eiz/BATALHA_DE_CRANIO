import 'package:http/http.dart' as http;

abstract class IHttpUsuario {
 Future get({required String url});
}

class HttpUsuario implements IHttpUsuario {
  final client = http.Client();


  @override
  Future get({required String url}) async{ 
    return await client.get(Uri.parse(url));
  } 
  }
