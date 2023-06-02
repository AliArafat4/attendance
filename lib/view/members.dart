import 'package:flutter/material.dart';

import '../constants.dart';

class Members extends StatelessWidget {
  const Members({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Table(
              border: TableBorder.all(color: Colors.transparent),
              columnWidths: const {
                0: FixedColumnWidth(30),
                1: FixedColumnWidth(200),
                2: FixedColumnWidth(90),
                3: FixedColumnWidth(30),
              },
              children: [
                const TableRow(
                  children: [
                    Center(child: Text("s.n")),
                    Center(child: Text("names")),
                    Center(child: Text("phone")),
                    Text(
                      "",
                    )
                  ],
                ),
                for (int i = 0; i < names.length; i++)
                  TableRow(children: [
                    Center(child: Text("${sn[i]}")),
                    Text("${names[i]}"),
                    Text(phone[i]),
                    Center(
                        child: Icon((isAttend[i]) ? Icons.check : Icons.close)),
                  ])
              ],
            ))
      ],
    );
  }
}

class Search extends StatefulWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchController = TextEditingController();
  var suggest;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          height: 80,
          child: TextField(
            controller: _searchController,
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
            onChanged: (val) {
              searchNames(_searchController.text);
            },
          ),
        ),
        (_searchController.text.isEmpty)
            ? const SizedBox()
            : Center(
                child: Text(
                suggest.toString().substring(1, suggest.toString().length - 1),
                textAlign: TextAlign.center,
              )),
      ],
    );
  }

  void searchNames(String query) {
    //TODO: take data from excel
    final suggestions = names.where((n) {
      final y = n.toLowerCase();

      final input = query.toLowerCase();
      return y.contains(input);
    }).toList();
    setState(() {
      suggest = suggestions;
    });
  }
}
