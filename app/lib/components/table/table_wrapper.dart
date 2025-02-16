import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'row_factories/row_factory.dart';

class TableWrapper<T> extends StatelessWidget {
  final List<String> columnNames;
  final RowFactory rowFactory;
  final List<T> items;

  const TableWrapper({
    super.key,
    required this.columnNames,
    required this.rowFactory,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        DataTable(columns: _buildTableColumns(), rows: []),
        Text(
          AppLocalizations.of(context)!.tableEmpty,
          textAlign: TextAlign.center,
        )
      ]);
    }
    return DataTable(
      columns: _buildTableColumns(),
      rows: _buildTableRows(context),
    );
  }

  List<DataColumn> _buildTableColumns() {
    return columnNames.map((name) => DataColumn(label: Text(name))).toList();
  }

  List<DataRow> _buildTableRows(BuildContext context) {
    return items.map((item) => rowFactory.create(context, item)).toList();
  }
}
