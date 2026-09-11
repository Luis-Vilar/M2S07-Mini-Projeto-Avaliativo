import 'package:flutter/material.dart';

enum TodoFilter { all, pending, completed }

class TodoFilterToolbarComponent extends StatelessWidget {
  const TodoFilterToolbarComponent({
    super.key,
    required this.searchController,
    required this.selectedFilter,
    required this.onFilterChanged,
    required this.onSearchChanged,
    required this.onClearSearch,
  });

  final TextEditingController searchController;
  final TodoFilter selectedFilter;
  final ValueChanged<TodoFilter> onFilterChanged;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onClearSearch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TapRegion(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              decoration: InputDecoration(
                labelText: 'Buscar tarefa',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SegmentedButton<TodoFilter>(
                    segments: const [
                      ButtonSegment(
                        value: TodoFilter.all,
                        label: Icon(Icons.all_inbox),
                      ),
                      ButtonSegment(
                        value: TodoFilter.pending,
                        label: Icon(Icons.pending),
                      ),
                      ButtonSegment(
                        value: TodoFilter.completed,
                        label: Icon(Icons.checklist),
                      ),
                    ],
                    selected: {selectedFilter},
                    showSelectedIcon: false,
                    onSelectionChanged: (selection) {
                      onFilterChanged(selection.first);
                    },
                  ),
                ),
                prefixIcon: searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: onClearSearch,
                        icon: const Icon(Icons.clear),
                        tooltip: 'Limpar',
                      ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
