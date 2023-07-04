import 'package:flutter/material.dart';

class SelectFileScreen extends StatelessWidget {
  const SelectFileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconButton(
          onPressed: () {
            //   excelFiles.readContent(excelFiles.selectFile());
          },
          icon: const Icon(Icons.file_copy)),
    );
  }
}
