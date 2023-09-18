// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:imc_calculator/exceptions/altura_invalida_exception.dart';
import 'package:imc_calculator/exceptions/peso_invalido_exception.dart';

enum TextFieldType { altura, peso }

class CustomTextField extends StatelessWidget {
  final TextFieldType textFieldType;
  final TextEditingController textController;

  const CustomTextField({
    Key? key,
    required this.textController,
    required this.textFieldType,
  }) : super(key: key);

  String? pesoValidator(String? pesoInput) {
    bool pesoValido = RegExp(r"^(?:\d+\.\d*|\.\d+|\d+)$").hasMatch(pesoInput!);

    if (pesoInput.isEmpty || !pesoValido) {
      return PesoInvalidoException().message;
    }
    return null;
  }

  String? alturaValidator(String? alturaInput) {
    bool alturaValida =
        RegExp(r"^(?:\d+\.\d*|\.\d+|\d+)$").hasMatch(alturaInput!);
    bool numeroPositivo;

    if (double.tryParse(alturaInput) == null ||
        double.tryParse(alturaInput)! <= 0) {
      numeroPositivo = false;
    } else {
      numeroPositivo = true;
    }

    if (alturaInput.isEmpty || !alturaValida || !numeroPositivo) {
      return AlturaInvalidaException().message;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (textFieldType == TextFieldType.peso) {
      return TextFormField(
        controller: textController,
        validator: (pesoInput) => pesoValidator(pesoInput),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Peso (kg)",
          prefixIcon: Icon(Icons.accessibility_new_rounded),
          labelStyle: TextStyle(fontSize: 14),
          errorStyle: TextStyle(fontSize: 12),
        ),
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
      );
    } else if (textFieldType == TextFieldType.altura) {
      return TextFormField(
        controller: textController,
        validator: (alturaInput) => alturaValidator(alturaInput),
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Altura (m)",
          prefixIcon: Icon(Icons.height_rounded),
          labelStyle: TextStyle(fontSize: 14),
          errorStyle: TextStyle(fontSize: 12),
        ),
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
      );
    } else {
      return Container();
    }
  }
}
