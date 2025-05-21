enum ListSize { small, medium, large }

enum ListColor { black, white, blue }

enum ListLayout { under, side }

class ListViewModel<T> {
  final List<T> items;
  final List<String> visibleColumns;
  final Map<String, String Function(T)> dataExtractor;
  final ListSize size;
  final ListColor color;
  final String title;
  final ListLayout layout;

  ListViewModel({
    required this.size,
    required this.color,
    required this.title,
    required this.items,
    required this.visibleColumns,
    required this.dataExtractor,
    required this.layout,
  });
}
