import 'package:contas/models/conta_model.dart';
import 'package:contas/models/operacao_model.dart';
import 'package:contas/services/conta_service.dart';
import 'package:contas/services/operacao_service.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class CadastrarOperacaoScreen extends StatefulWidget {
  // const CadastrarOperacaoScreen({Key? key}) : super(key: key);

  late final String tipoOperacao;
  CadastrarOperacaoScreen({required this.tipoOperacao});

  @override
  State<CadastrarOperacaoScreen> createState() =>
      _CadastrarOperacaoScreenState();
}

class _CadastrarOperacaoScreenState extends State<CadastrarOperacaoScreen> {
  final _nomeController = TextEditingController();
  final _resumoController = TextEditingController();
  final _custoController = TextEditingController();
  final _tipoController = TextEditingController();
  final _dataController = TextEditingController();
  ContaService cs = ContaService();
  OperacaoService os = OperacaoService();

  DateTime selectDate = DateTime.now();

  late Future<List> _carregaContas;
  late List<Conta> _conta;

  Conta? _contaSelecionada;

  @override
  void initState() {
    _carregaContas = _getContas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Operação"),
        backgroundColor:
            widget.tipoOperacao == "entrada" ? Colors.blue : Colors.red,
      ),
      body: FutureBuilder(
          future: _carregaContas,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _conta = snapshot.data;

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nomeController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: "nome"),
                        ),
                        TextFormField(
                          controller: _resumoController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(labelText: "resumo"),
                        ),
                        TextFormField(
                          controller: _custoController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: "custo"),
                        ),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _dataController,
                              decoration: InputDecoration(
                                labelText: formatDate(
                                    selectDate, [dd, "/", mm, "/", yyyy]),
                              ),
                            ),
                          ),
                        ),
                        DropdownButtonFormField(
                          value: _contaSelecionada,
                          onChanged: (Conta? conta) {
                            setState(() {
                              _contaSelecionada = conta;
                            });
                          },
                          items: _conta.map((conta) {
                            return DropdownMenuItem(
                              value: conta,
                              child: Text(conta.nome),
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Operacao novaOperacao = Operacao(
                                  nome: _nomeController.text,
                                  resumo: _resumoController.text,
                                  data: selectDate.toString(),
                                  tipo: widget.tipoOperacao,
                                  conta: _contaSelecionada!.id,
                                  custo: double.parse(_custoController.text),
                                );
                                os.addOperacao(novaOperacao);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: widget.tipoOperacao == "entrada"
                                    ? Colors.blue
                                    : Colors.red,
                              ),
                              child: Text("Cadastrar"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  Future<List> _getContas() async {
    return await cs.getAllContas();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectDate,
      firstDate: DateTime(2022, 01),
      lastDate: DateTime(2030, 12),
    );

    if (picked != null && picked != selectDate) {
      setState(() {
        selectDate = picked;
      });
    }
  }
}
