import 'package:flutter/material.dart';
import 'package:invertexto/view/por_extenso_page.dart';
import 'package:invertexto/view/busca_cep_page.dart';
import 'package:invertexto/view/valida_documento_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
            )
          ],
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Padding(padding: EdgeInsets.all(10.0), 
      child: Column(
        children: <Widget>[
          GestureDetector(
            child: Row(
              children: <Widget>[
                Icon(Icons.edit, color: Colors.white),
                SizedBox(width: 30,),
                Text(
                  "Por Extenso",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => PorExtensoPage()));
            },
          ),
          SizedBox(height: 30,),
          GestureDetector(
            child: Row(
              children: <Widget>[
                Icon(Icons.edit, color: Colors.white),
                SizedBox(width: 30,),
                Text(
                  "Busca Cep",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            onTap: (){
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => BuscaCepPage()));
            },
          ),
          SizedBox(height: 30,),
          GestureDetector(
              child: Row(
                children: const <Widget>[
                  Icon(Icons.verified_user, color: Colors.white),
                  SizedBox(width: 30),
                  Text(
                    "Validador de Documento",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ValidaDocumentoPage()),
                );
              },
            ),
        ],),
        ),
      );
  }
}
