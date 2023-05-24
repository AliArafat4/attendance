import 'package:flutter/material.dart';

class Members extends StatelessWidget {
  const Members({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> sn = [1, 2, 3, 4];
    List<String> names = ["Ali", "Ahmed", "Mohammed", "Hadi"];
    List<String> phone = [
      "1234567890",
      "1234567890",
      "1234567890",
      "1234567890"
    ];
    List<bool> isAttend = [true, true, false, true];
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          height: 80,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: 'Search',
              alignLabelWithHint: true,
              floatingLabelAlignment: FloatingLabelAlignment.center,
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(width: 0)),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("S.N"),
              Text("Name"),
              Text("Phone"),
              Text("Attend"),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: sn.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${sn[index]}"),
                  Text(names[index]),
                  Text(phone[index]),
                  (isAttend[index]) ? Icon(Icons.check) : Icon(Icons.close),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
