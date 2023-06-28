import 'package:flutter/material.dart';

class Attendance extends StatefulWidget {
  final excelFile;
  const Attendance({Key? key, this.excelFile}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final _searchController = TextEditingController();
  int index = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: SizedBox(
            height: 150,
            width: 150,
            child: Placeholder(),
            // Image.asset(
            //   "assets/images/attendance-icon-5.jpg",
            // )
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          width: 200,
          child: TextField(
            controller: _searchController,
            keyboardType: TextInputType.number,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: 'S.N',
              alignLabelWithHint: true,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(width: 0)),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                index = 0;
              } else {
                index = int.parse(value);
              }
              setState(() {});
            },
          ),
        ),
        (index == 0 || index >= widget.excelFile.content.length)
            ? const SizedBox()
            : Text("${widget.excelFile.content[index]}"),
        ElevatedButton(
            child: const Text("Submit"),
            onPressed: () {
              //TODO: Dialog ensure name
            })
      ],
    );
  }
}
