import 'package:flutter/material.dart';
import '../app_styles.dart';

class SearchBarWidget extends StatefulWidget {
  final VoidCallback onClear;

  SearchBarWidget({
    required this.onClear,
  });

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Color(0xFFF2F3F2),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          SizedBox(width: 8.0),
          Icon(
            Icons.search_rounded,
            color: tGrey3,
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                hintStyle: tPoppinsMedium.copyWith(color: tGrey3),
              ),
              onChanged: (query) {
                setState(() {});
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              widget.onClear();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
