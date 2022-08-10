import 'package:contas/screens/cadastrar_conta/cadastrar_conta_screen.dart';
import 'package:contas/screens/cadastrar_operacao/cadastrar_operacao_screen.dart';
import 'package:contas/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // home: CadastrarOperacaoScreen(
      //   tipoOperacao: "entrada",
      // ),
      // home: CadastroContaScreen(),
      home: HomeScreen(),
    );
  }
}
