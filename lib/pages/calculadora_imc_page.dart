// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:imc_calculator/exceptions/altura_invalida_exception.dart';
import 'package:imc_calculator/exceptions/peso_invalido_exception.dart';
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
  String valorIMC = "";

  String? pesoValidator(String? pesoInput) {
    bool pesoValido = RegExp(r"^(?:\d+\.\d*|\.\d+|\d+)$").hasMatch(pesoInput!);

    if (pesoInput.isEmpty || !pesoValido) {
      return PesoInvalidoException().error();
    }
    return null;
  }

  String? alturaValidator(String? alturaInput) {
    bool alturaValido =
        RegExp(r"^(?:\d+\.\d*|\.\d+|\d+)$").hasMatch(alturaInput!);

    if (alturaInput.isEmpty ||
        double.parse(alturaInput) >= 3 ||
        !alturaValido) {
      return AlturaInvalidaException().error();
    }
    return null;
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
                SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formfield.currentState!.validate()) {
                        setState(() {
                          valorIMC = ImcFormula.calcularIMC(
                                  double.parse(pesoController.value.text),
                                  double.parse(alturaController.value.text))
                              .toString();

                          resultadoIMC =
                              ImcFormula.resultadoIMC(double.parse(valorIMC));
                        });

                        print('peso ${pesoController.value.text}');
                        print('altura ${alturaController.value.text}');
                        print(resultadoIMC);

                        pesoController.clear();
                        alturaController.clear();
                      }
                    },
                    child: Text(
                      "Calcular IMC",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Resultado:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(resultadoIMC),
                    Text(valorIMC.toString()),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
