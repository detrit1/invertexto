import 'package:flutter/material.dart';
import 'package:invertexto/service/invertexto_service.dart';

class BuscaCepPage extends StatefulWidget {
  const BuscaCepPage({super.key});

  @override
  State<BuscaCepPage> createState() => _BuscaCepPageState();
}

class _BuscaCepPageState extends State<BuscaCepPage> {
  String? campo;
  String? resultado;
  final apiService = InvertextoService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/imgs/logo.png',
              fit: BoxFit.contain,
              height: 40,
            ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Digite um CEP",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.white, fontSize: 18),
              onSubmitted: (value) {
                setState(() {
                  campo = value;
                });
              },
            ),
            Expanded(
              child: campo == null || campo!.isEmpty
                  ? Center(
                      child: Text(
                        "Digite um CEP válido",
                        style: TextStyle(color: Colors.redAccent, fontSize: 18),
                      ),
                    )
                  : FutureBuilder(
                      future: apiService.buscaCep(campo),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                                ConnectionState.waiting ||
                            snapshot.connectionState == ConnectionState.none) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                              strokeWidth: 5.0,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              "Erro ao buscar o CEP: ${snapshot.error}",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return Center(
                            child: Text(
                              "CEP não encontrado",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          return exibeResultado(context, snapshot);
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget exibeResultado(BuildContext context, AsyncSnapshot snapshot) {
    String enderecoCompleto = '';
    if (snapshot.data != null) {
      enderecoCompleto += snapshot.data["street"] ?? "Rua não disponível";
      enderecoCompleto += "\n";
      enderecoCompleto +=
          snapshot.data["neighborhood"] ?? "Bairro não encontrado";
      enderecoCompleto += "\n";
      enderecoCompleto += snapshot.data["city"] ?? "Cidade não encontrada";
      enderecoCompleto += "\n";
      enderecoCompleto += snapshot.data["state"] ?? "Estado não encontrado";
    }
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        enderecoCompleto,
        style: TextStyle(color: Colors.white, fontSize: 18),
        softWrap: true,
      ),
    );
  }
}
