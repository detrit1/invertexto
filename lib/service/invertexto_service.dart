import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class InvertextoService {
  final String _token = "21564|uRD3QLx6XtEKiR0muXVFSWrEx11yE4A0";

  Future<Map<String, dynamic>> convertePorExtenso(String? valor, String? moeda) async{
    try{
      final uri = Uri.parse("https://api.invertexto.com/v1/number-to-words?token=${_token}&number=${valor}.50&language=pt&currency=${moeda}");
      final response = await http.get(uri);
      if(response.statusCode == 200){
        return json.decode(response.body);
      }
      else{
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    }on SocketException{
      throw Exception('Erro de conexão com a internet.');
    }catch(e){
      rethrow;
    }
  }

  Future<Map<String, dynamic>> buscaCep(String? valor) async{
    try{
      final uri = Uri.parse("https://api.invertexto.com/v1/cep/${valor}?token=${_token}");
      final response = await http.get(uri);
      if(response.statusCode == 200){
        return json.decode(response.body);
      }
      else{
        throw Exception('Erro ${response.statusCode}: ${response.body}');
      }
    }on SocketException{
      throw Exception('Erro de conexão com a internet.');
    }catch(e){
      rethrow;
    }
  }

  Future<Map<String, dynamic>> validarDocumento(String documento, {String? tipo}) async {
  try {
    final uri = Uri.parse(
      "https://api.invertexto.com/v1/validator"
      "?token=$_token"
      "&value=$documento"
      "${tipo != null ? "&type=$tipo" : ""}"
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ${response.statusCode}: ${response.body}');
    }
  } on SocketException {
    throw Exception('Erro de conexão com a internet.');
  } catch (e) {
    rethrow;
  }
}
}
