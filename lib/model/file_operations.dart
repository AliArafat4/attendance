import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

abstract class FileOperations {
  Future selectFile();
  Future readContent(var filePath);
  Future<File> updateContent(var content);
  get content;
  get path;
}

class ExcelFiles implements FileOperations {
  //TODO: add constructor for the excel data
  List<String> _fileContent = [];
  String _selectedFilePath = '';
  @override
  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path.toString());
      return file;
    } else {
      // User canceled the picker
    }
  }

  @override
  Future readContent(var filePath) async {
    try {
      final file = await filePath;
      _selectedFilePath = file.toString();

      // Read the file
      var bytes = file.readAsBytesSync();
      var excel = Excel.decodeBytes(bytes);
      List<String> rowDetail = [];

      //get content
      for (var sheetName in excel.tables.keys) {
        // print(sheetName);
        // print(excel.tables[sheetName]!.maxCols);
        // print(excel.tables[sheetName]!.maxRows);
        for (var row in excel.tables[sheetName]!.rows) {
          rowDetail.add(row.map((e) => e?.value).toString());
          //  print("${row.map((e) => e?.value)}");
        }
      }

      //final contents = await file.readAsString();

      //assign the list to the fileContent variable
      _fileContent = rowDetail;

      // return contents;
    } catch (e) {
      // If encountering an error, return 0
      print(e);
      return 0;
    }
  }

  //get file content
  @override
  get content => _fileContent;

  @override
  get path => _selectedFilePath;

  @override
  Future<File> updateContent(content) {
    // TODO: implement writeContent
    throw UnimplementedError();
  }

// Future<File> writeContent(var content) async {
//   final file = await _localFile;
//
//   // Write the file
//   return file.writeAsString('$content');
// }

  // get columns
  List<String> getColumnData(String column) {
    List<String> headerList = [];

    String col = column;
    String temp = col.substring(1, col.length - 1);
    headerList = temp.split(",");

    return headerList;
  }

  List searchNames(String query) {
    List<String> suggestions = [];
    for (int i = 1; i < content.length; i++) {
      if (content[i].toString().toLowerCase().contains(query.toLowerCase())) {
        suggestions.add(content[i]);
      }
    }
    return suggestions;
  }
}
