import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final excelFile;
  const Search({
    Key? key,
    this.excelFile,
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
                  borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(width: 0)),
            ),
            onChanged: (val) {
              suggest = widget.excelFile.searchNames(_searchController.text);
              setState(() {});
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
}
