import 'package:contas/models/operacao_model.dart';
import 'package:contas/utils/db_util.dart';

class OperacaoService {
  List<Operacao> _operacaoList = [];

  void addOperacao(Operacao operacao) {
    DbUtil.insertData('operacao', operacao.toMap());
  }

  Future<List> getAllOperacoes() async {
    final dataList = await DbUtil.getData('operacao');
    _operacaoList =
        dataList.map((operacoes) => Operacao.fromMap(operacoes)).toList();
    return _operacaoList;
  }
}
