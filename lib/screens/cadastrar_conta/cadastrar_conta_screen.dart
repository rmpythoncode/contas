import 'package:contas/models/conta_model.dart';
import 'package:contas/screens/home/home_screen.dart';
import 'package:contas/services/conta_service.dart';
import 'package:flutter/material.dart';

class CadastroContaScreen extends StatelessWidget {
  final _nomeController = TextEditingController();
  final _valorController = TextEditingController();
  ContaService cs = ContaService();

  CadastroContaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastro de Conta",
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            10,
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomeController,
                  keyboardType: TextInputType.text,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                    labelText: "Nome",
                  ),
                ),
                TextFormField(
                  controller: _valorController,
                  keyboardType: TextInputType.number,
                  cursorHeight: 20,
                  decoration: const InputDecoration(
                    labelText: "Valor",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    bottom: 20,
                  ),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Conta novaConta = Conta(
                          nome: _nomeController.text,
                          valor: double.parse(
                            _valorController.text,
                          ),
                        );
                        cs.adicionarConta(
                          novaConta,
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => HomeScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Cadastrar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
