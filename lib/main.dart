import 'package:flutter/material.dart';
import 'package:imc_calculator/pages/calculadora_imc_page.dart';

void main() {
  runApp(const ImcCalculatorApp());
}

class ImcCalculatorApp extends StatelessWidget {
  const ImcCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: false,
      ),
      home: const CalculadoraIMCPage(),
    );
  }
}
