import 'package:flutter/material.dart';

import '../widgets/search_widget.dart';

class Members extends StatelessWidget {
  final excelFile;

  const Members({Key? key, this.excelFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(excelFile: excelFile),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Table(
              border: TableBorder.all(color: Colors.black),
              // columnWidths: const {
              //   0: FixedColumnWidth(30),
              //   1: FixedColumnWidth(200),
              //   2: FixedColumnWidth(90),
              //   3: FixedColumnWidth(30),
              // },
              children: [
                ...List.generate(excelFile.content.length, (index) {
                  return TableRow(children: [
                    for (int i = 0; i < excelFile.getColumnData(excelFile.content[0]).length; i++)
                      Text(excelFile.getColumnData(excelFile.content[index])[i]),
                  ]);
                }),
              ],
            ))
      ],
    );
  }
}
