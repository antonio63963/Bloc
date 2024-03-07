import 'package:flutter/material.dart';

extension ToListView<T> on Iterable<T> {
  Widget toListView() => IterableList(iterable: this);
}

class IterableList extends StatelessWidget {
  final Iterable iterable;
  const IterableList({super.key, required this.iterable});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: iterable.length,
      itemBuilder: (_, idx) {
        return ListTile(
          title: Text(iterable.elementAt(idx).toString()),
        );
      },
    );
  }
}
