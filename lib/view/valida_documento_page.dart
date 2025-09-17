import 'package:flutter/material.dart';
import 'package:invertexto/service/invertexto_service.dart';

class ValidaDocumentoPage extends StatefulWidget {
  const ValidaDocumentoPage({super.key});

  @override
  State<ValidaDocumentoPage> createState() => _ValidaDocumentoPageState();
}

class _ValidaDocumentoPageState extends State<ValidaDocumentoPage> {
  final _controllerDocumento = TextEditingController();
  @override
  void dispose() {
    _controllerDocumento.dispose();
    super.dispose();
  }

  String? resultado;
  final apiService = InvertextoService();
  String? tipoSelecionado;

  final List<Map<String, String?>> tiposDocumento = [
    {"label": "Automático", "value": null},
    {"label": "CPF", "value": "cpf"},
    {"label": "CNPJ", "value": "cnpj"},
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controllerDocumento,
              decoration: const InputDecoration(
                labelText: "Digite o CPF ou CNPJ",
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String?>(
              value: tipoSelecionado,
              items: tiposDocumento.map((doc) {
                return DropdownMenuItem<String?>(
                  value: doc["value"],
                  child: Text(
                    doc["label"]!,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  tipoSelecionado = value;
                });
              },
              decoration: const InputDecoration(
                labelText: "Tipo de Documento (opcional)",
                border: OutlineInputBorder(),
              ),
              dropdownColor: Colors.white,
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: () async {
                final doc = _controllerDocumento.text;
                if (doc.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Digite um documento")),
                  );
                  return;
                }

                try {
                  final resp = await apiService.validarDocumento(
                    doc,
                    tipo: tipoSelecionado,
                  );
                  setState(() {
                    resultado = resp['valid'] == true
                        ? "Documento válido (${resp['type']})"
                        : "ocumento inválido";
                  });
                } catch (e) {
                  setState(() {
                    resultado = "Erro: $e";
                  });
                }
              },
              child: const Text("Validar Documento"),
            ),
            const SizedBox(height: 20),

            if (resultado != null)
              Text(
                resultado!,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
