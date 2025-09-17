import 'package:flutter/material.dart';
import 'package:invertexto/service/invertexto_service.dart';

class PorExtensoPage extends StatefulWidget {
  const PorExtensoPage({super.key});

  @override
  State<PorExtensoPage> createState() => _PorExtensoPageState();
}

class _PorExtensoPageState extends State<PorExtensoPage> {
  String? campo;
  String? resultado;
  final apiService = InvertextoService();
  String? moedaSelecionada = "BRL";
  final List<Map<String, String>> moedas = [
    {"label": "Real (BRL)", "value": "BRL"},
    {"label": "Dólar (USD)", "value": "USD"},
    {"label": "Euro (EUR)", "value": "EUR"},
    {"label": "Libra Esterlina (GBP)", "value": "GBP"},
    {"label": "Iene (JPY)", "value": "JPY"},
    {"label": "Peso Argentino (ARS)", "value": "ARS"},
    {"label": "Peso Mexicano (MXN)", "value": "MXN"},
    {"label": "Peso Uruguaio (UYU)", "value": "UYU"},
    {"label": "Guarani (PYG)", "value": "PYG"},
    {"label": "Boliviano (BOB)", "value": "BOB"},
    {"label": "Peso Chileno (CLP)", "value": "CLP"},
    {"label": "Peso Colombiano (COP)", "value": "COP"},
    {"label": "Peso Cubano (CUP)", "value": "CUP"},
  ];
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
                labelText: "Digite um Número",
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
            DropdownButtonFormField<String>(
              value: moedaSelecionada,
              dropdownColor: Colors.black,
              decoration: InputDecoration(
                labelText: "Selecione a moeda",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              items: moedas.map((moeda) {
                return DropdownMenuItem<String>(
                  value: moeda["value"],
                  child: Text(
                    moeda["label"]!,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  moedaSelecionada = value;
                  campo = campo;
                });
              },
            ),
            Expanded(
              child: campo == null || campo!.isEmpty
                  ? Center(
                      child: Text(
                        "Digite um número válido",
                        style: TextStyle(color: Colors.redAccent, fontSize: 18),
                      ),
                    )
                  : FutureBuilder(
                      future: apiService.convertePorExtenso(
                        campo,
                        moedaSelecionada,
                      ),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return Container(
                              width: 200,
                              height: 200,
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  Colors.white,
                                ),
                                strokeWidth: 5.0,
                              ),
                            );

                          default:
                            if (snapshot.hasError) {
                              return Center(
                                child: Text(
                                  "Erro ao processar: ${snapshot.error}",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 18,
                                  ),
                                ),
                              );
                            } else {
                              return exibeResultado(context, snapshot);
                            }
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
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Text(
        snapshot.data["text"] ?? '',
        style: TextStyle(color: Colors.white, fontSize: 18),
        softWrap: true,
      ),
    );
  }
}
