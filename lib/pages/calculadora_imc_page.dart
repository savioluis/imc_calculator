// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:imc_calculator/model/imc_model.dart';
import 'package:imc_calculator/pages/widgets/custom_large_button_widget.dart';
import 'package:imc_calculator/utils/dialogs_util.dart';
import 'package:imc_calculator/utils/imc_formula.dart';
import 'package:imc_calculator/utils/snack_bar_util.dart';

import 'widgets/custom_text_field_widget.dart';

class CalculadoraIMCPage extends StatefulWidget {
  const CalculadoraIMCPage({super.key});

  @override
  State<CalculadoraIMCPage> createState() => _CalculadoraIMCPageState();
}

class _CalculadoraIMCPageState extends State<CalculadoraIMCPage> {
  final _formfield = GlobalKey<FormState>();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();

  String resultadoIMCTela = "";
  double valorIMCTela = -1;
  List<ImcModel> listaImc = [];

  void _formValidate() {
    if (_formfield.currentState!.validate()) {
      double peso = double.parse(pesoController.value.text);
      double altura = double.parse(alturaController.value.text);
      double valorIMC = ImcFormula.calcularIMC(peso, altura);
      String categoriaIMC = ImcFormula.resultadoIMC(valorIMC);

      ImcModel imc = ImcModel(
        valor: valorIMC,
        categoria: categoriaIMC,
        peso: peso,
        altura: altura,
      );

      listaImc.add(imc);

      setState(() {
        valorIMCTela = valorIMC;
        resultadoIMCTela = categoriaIMC;
      });

      print('peso: ${pesoController.value.text}');
      print('altura: ${alturaController.value.text}');
      print(resultadoIMCTela);

      pesoController.clear();
      alturaController.clear();

      SnackBarUtil.infoSnackBar(context, "IMC calculado com sucesso !");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DialogsUtil.showListOfImcs(
            context,
            listaImc,
          );
        },
        backgroundColor: Colors.blueAccent,
        child: Icon(
          Icons.format_list_numbered_rounded,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 96),
          child: Form(
            key: _formfield,
            child: Column(
              children: [
                CustomTextField(
                    textController: pesoController,
                    textFieldType: TextFieldType.peso),
                SizedBox(
                  height: 24,
                ),
                CustomTextField(
                    textController: alturaController,
                    textFieldType: TextFieldType.altura),
                SizedBox(
                  height: 24,
                ),
                CustomLargeButton(
                  onPressed: _formValidate,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  valorIMCTela == -1 ? "" : "Resultado: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(resultadoIMCTela),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(valorIMCTela == -1 ? "" : "IMC: ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(valorIMCTela == -1
                            ? ""
                            : valorIMCTela.toStringAsFixed(2)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
