import 'package:dev/desygn_system/components/list/list_view_model.dart';
import 'package:flutter/material.dart';

class ListWidget<T> extends StatelessWidget {
  final ListViewModel<T> viewModel;

  const ListWidget({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.title),
        backgroundColor: _getColor(viewModel.color),
      ),
      body: ListView.builder(
        itemCount: viewModel.items.length,
        itemBuilder: (context, index) {
          final item = viewModel.items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  viewModel.layout == ListLayout.side
                      ? _buildSideLayout(item)
                      : _buildUnderLayout(item),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSideLayout(T item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          viewModel.visibleColumns.map((column) {
            return Expanded(
              child: Text(
                viewModel.dataExtractor[column]!(item),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
    );
  }

  Widget _buildUnderLayout(T item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          viewModel.visibleColumns.map((column) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                "$column: ${viewModel.dataExtractor[column]!(item)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }).toList(),
    );
  }

  Color _getColor(ListColor color) {
    switch (color) {
      case ListColor.black:
        return Colors.black;
      case ListColor.white:
        return Colors.white;
      case ListColor.blue:
        return Colors.blue;
    }
  }
}
