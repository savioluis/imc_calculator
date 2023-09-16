// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:imc_calculator/exceptions/altura_invalida_exception.dart';
import 'package:imc_calculator/exceptions/peso_invalido_exception.dart';
import 'package:imc_calculator/utils/imc_formula.dart';

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

  String? pesoValidator(String? pesoInput) {
    bool pesoValido = RegExp(r"^(?:\d+\.\d*|\.\d+|\d+)$").hasMatch(pesoInput!);

    if (pesoInput.isEmpty || !pesoValido) {
      return PesoInvalidoException().error();
    }
    return null;
  }

  String? alturaValidator(String? alturaInput) {
    bool alturaValido = RegExp(r"^(?:\d+\.\d*|\.\d+|\d+)$").hasMatch(alturaInput!);

    if (alturaInput.isEmpty || double.parse(alturaInput) >= 3 || !alturaValido) {
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
                TextFormField(
                  controller: pesoController,
                  validator: (pesoInput) => pesoValidator(pesoInput),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Peso (kg)",
                    prefixIcon: Icon(Icons.accessibility_new_rounded),
                    labelStyle: TextStyle(fontSize: 14),
                    errorStyle: TextStyle(fontSize: 12),
                  ),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: alturaController,
                  validator: (alturaInput) => alturaValidator(alturaInput),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Altura (m)",
                    prefixIcon: Icon(Icons.height_rounded),
                    labelStyle: TextStyle(fontSize: 14),
                    errorStyle: TextStyle(fontSize: 12),
                  ),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                ),
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
                          resultadoIMC = ImcFormula.resultadoIMC(
                              double.parse(pesoController.value.text),
                              double.parse(alturaController.value.text));
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
                Text(
                  resultadoIMC,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
