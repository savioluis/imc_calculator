import 'package:flutter/material.dart';
import 'package:imc_calculator/model/imc_model.dart';

class ImcCard extends StatelessWidget {
  final ImcModel imc;
  final int index;

  const ImcCard({
    super.key,
    required this.imc,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        height: 64,
        // width: MediaQuery.of(context).size.width,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "$index.",
                  style: const TextStyle(fontWeight: FontWeight.normal),
                ),
                const SizedBox(width: 16),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  // color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Peso: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Expanded(
                            child: Text(
                              "${imc.peso} kg",
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Altura: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.fade),
                          ),
                          Expanded(
                            child: Text(
                              "${imc.altura} m",
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 28),
                Container(
                  // color: Colors.yellowAccent,
                  // width: MediaQuery.of(context).size.width * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "IMC: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(imc.valor.toStringAsFixed(2))
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Categoria: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(imc.categoria)
                        ],
                      ),
                    ],
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
