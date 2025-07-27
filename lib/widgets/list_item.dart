import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final List<String> items;
  final bool numberedList;

  const ListItem({
    super.key,
    required this.items,
    this.numberedList = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(items.length, (index) {
        final prefix = numberedList ? '${index + 1}. ' : '• ';
        return Text('$prefix${items[index]}');
      }),
    );
  }
}
