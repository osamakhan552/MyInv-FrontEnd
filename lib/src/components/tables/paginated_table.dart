import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:wppl/src/components/download_button.dart';
import 'package:wppl/src/components/import_button.dart';
import 'package:wppl/src/components/tables/source.dart';

import '../search_field.dart';

///
/// if download url is given then download button
/// title is also expected otherwise it will throw
/// assertion error
///
class PaginatedTable extends StatefulWidget {
  final TableSource source;
  final List<DataColumn> columns;
  final String? downloadUrl;
  final String? downloadButtonTitle;
  final String? importUrl;
  final String? importButtonTitle;

  const PaginatedTable(
      {Key? key,
      required this.source,
      required this.columns,
      this.downloadUrl,
      this.downloadButtonTitle,
      this.importUrl,
      this.importButtonTitle})
      : super(key: key);

  @override
  _PaginatedTableState createState() => _PaginatedTableState();
}

class _PaginatedTableState extends State<PaginatedTable> {
  int rowsPerPage = 10;
  @override
  Widget build(BuildContext context) {
    assert((widget.downloadButtonTitle != null && widget.downloadUrl != null) ||
        (widget.downloadButtonTitle == null && widget.downloadUrl == null));

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SearchField(onSubmit: (String search) {
                    widget.source.search(search);
                  }),
                  if (widget.downloadUrl != null)
                    DownloadButton(
                        title: widget.downloadButtonTitle!,
                        url: widget.downloadUrl!),
                  if (widget.importUrl != null)
                  Padding(
                    padding: const EdgeInsets.all(9.0),
                    child: ImportButton(
                        title: widget.importButtonTitle!, url: widget.importUrl!),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: AdvancedPaginatedDataTable(
                addEmptyRows: false,
                rowsPerPage: rowsPerPage,
                availableRowsPerPage: widget.source.availableRowsPerPage,
                columns: widget.columns,
                source: widget.source,
                onRowsPerPageChanged: (value) {
                  setState(() {
                    rowsPerPage = value ?? rowsPerPage;
                  });
                },
                onPageChanged: (value) {
                  widget.source.changePage(value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
