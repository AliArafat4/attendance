import 'package:flutter/material.dart';
import '../model/firebase_storage.dart';
import '../model/firestore.dart';

class UploadFileScreen extends StatefulWidget {
  final tags;
  final excelFile;
  const UploadFileScreen({Key? key, this.excelFile, this.tags}) : super(key: key);

  @override
  State<UploadFileScreen> createState() => _UploadFileScreenState();
}

var list = [];
var futureNames;
List selectedItem = [];

int index = -1;
bool exist = false;

class _UploadFileScreenState extends State<UploadFileScreen> {
  final _folderNameController = TextEditingController();
  @override
  void initState() {
    futureNames = getFoldersNames();
    super.initState();
  }

  @override
  void dispose() {
    _folderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Files"),
        actions: [
          Switch(
              activeColor: Colors.pink,
              value: exist,
              onChanged: (val) {
                setState(() {
                  exist = val;
                });
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                (exist)
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SizedBox(
                          width: 360,
                          child: TextFormField(
                            controller: _folderNameController,
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.file_copy_outlined),
                                hintText: "Enter a Folder Name",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                )),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: SizedBox(
                          width: 120,
                          child: DropdownButtonHideUnderline(
                            child: FutureBuilder<dynamic>(
                                future: futureNames,
                                builder: (context, snapshot) {
                                  if (!snapshot.connectionState.toString().contains("waiting")) {
                                    final list = snapshot.data;
                                    return DropdownButton(
                                      hint: const Center(child: Text("Select Folder")),
                                      isExpanded: true,
                                      value: (index < 0) ? null : selectedItem[0],
                                      borderRadius: BorderRadius.circular(17),
                                      items: list?.map<DropdownMenuItem<String>>((menuValue) {
                                        return DropdownMenuItem<String>(
                                          value: menuValue,
                                          child: Text(
                                            menuValue,
                                            style: const TextStyle(
                                              fontSize: 13,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (newValue) {
                                        selectedItem.clear();
                                        setState(
                                          () {
                                            selectedItem.add(newValue);
                                            index = 1;
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    return const LinearProgressIndicator();
                                  }
                                }),
                          ),
                        ),
                      ),
              ],
            ),
            const SizedBox(height: 40),
            UploadButton(
                excelFile: widget.excelFile,
                folderNameController: _folderNameController,
                folderNameSelcetedItem: selectedItem),
            const SizedBox(height: 20),
            const Text(" Upload a File"),
          ],
        ),
      ),
    );
  }
}

class UploadButton extends StatelessWidget {
  final excelFile;
  final folderNameSelcetedItem;
  final folderNameController;
  const UploadButton({
    Key? key,
    required this.excelFile,
    required this.folderNameSelcetedItem,
    required this.folderNameController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        foregroundPainter: BorderPainter(),
        child: IconButton(
          iconSize: 100,
          icon: const Icon(
            Icons.file_upload_outlined,
          ),
          onPressed: () async {
            checkFolderName(context);
          },
        ),
      ),
    );
  }

  Future<void> checkFolderName(context) async {
    if (!exist) {
      if (folderNameSelcetedItem.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(behavior: SnackBarBehavior.floating, content: Text('Select a Folder')));
      } else if (folderNameSelcetedItem.toString().contains("[]")) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating, content: Text('Create a New Folder')));
      } else {
        await excelFile.readContent(excelFile.selectFile());
        uploadFile(excelFile.path, folderNameSelcetedItem[0].toString().trim());
      }
    } else {
      if (folderNameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text('Enter a Name for new Folder to Create')));
      } else {
        await excelFile.readContent(excelFile.selectFile());
        putFoldersNames(folderNameController.text.trim());
        uploadFile(excelFile.path, folderNameController.text.trim());
      }
    }
  }
}

class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double sh = size.height; // for convenient shortage
    double sw = 118; // for convenient shortage
    double cornerSide = sh * 0.1; // desirable value for corners side

    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Path path = Path()
      ..moveTo(cornerSide, 0)
      ..quadraticBezierTo(0, 0, 0, cornerSide)
      ..moveTo(0, sh - cornerSide)
      ..quadraticBezierTo(0, sh, cornerSide, sh)
      ..moveTo(sw - cornerSide, sh)
      ..quadraticBezierTo(sw, sh, sw, sh - cornerSide)
      ..moveTo(sw, cornerSide)
      ..quadraticBezierTo(sw, 0, sw - cornerSide, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
}
