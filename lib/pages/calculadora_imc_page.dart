// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:imc_calculator/exceptions/altura_invalida_exception.dart';
import 'package:imc_calculator/exceptions/peso_invalido_exception.dart';
import 'package:imc_calculator/pages/widgets/custom_large_button_widget.dart';
import 'package:imc_calculator/utils/imc_formula.dart';

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

  String resultadoIMC = "";
  double valorIMC = 0.0;

  void _formValidate() {
    if (_formfield.currentState!.validate()) {
      setState(() {
        valorIMC = ImcFormula.calcularIMC(
            double.parse(pesoController.value.text),
            double.parse(alturaController.value.text));

        resultadoIMC = ImcFormula.resultadoIMC(valorIMC);
      });

      print('peso: ${pesoController.value.text}');
      print('altura: ${alturaController.value.text}');
      print(resultadoIMC);

      pesoController.clear();
      alturaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
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
                  valorIMC == 0.0 ? "" : "Resultado: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(resultadoIMC),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          valorIMC == 0.0 ? "" : "IMC: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                            valorIMC == 0.0 ? "" : valorIMC.toStringAsFixed(2)),
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
