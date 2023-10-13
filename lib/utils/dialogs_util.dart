import 'package:flutter/material.dart';
import 'package:imc_calculator/model/imc_model.dart';
import 'package:imc_calculator/pages/widgets/custom_text_field_widget.dart';
import 'package:imc_calculator/pages/widgets/imc_card.dart';

class DialogsUtil {
  static void showListOfImcs(
    BuildContext context,
    List<ImcModel> list,
  ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actionsPadding: EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: const Text(
              "LISTA DE IMC",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            content: list.isEmpty
                ? const Text(
                    "Nenhum IMC foi calculado ainda 🙄",
                    textAlign: TextAlign.center,
                  )
                : Container(
                    // color: Colors.yellowAccent,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: ListView.separated(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ImcCard(
                          imc: list[index],
                          index: index + 1,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
                    ),
                  ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Fechar",
                    style: TextStyle(fontSize: 16),
                  )),
            ],
          );
        });
  }
}
