import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:wppl/src/util/api_methods_mixin.dart';
import 'package:wppl/src/util/util.dart';

abstract class TableSource<T extends JsonifyClass>
    extends AdvancedDataTableSource<T> {
  T creator();

  String searchTerm = "";
  List<T> list = List.empty(growable: true);
  int updateIndex = -1;
  int startingIndex = 0;

  List<int> availableRowsPerPage = [10, 50, 100];

  @override
  Future<RemoteDataSourceDetails<T>> getNextPage(
      NextPageRequest pageRequest) async {
    CountWrapper count = CountWrapper(0);
    list = await getAll(
      creator: creator,
      totalCount: count,
      limit: pageRequest.pageSize,
      offset: pageRequest.offset,
      search: searchTerm,
    );

    return RemoteDataSourceDetails(count.count, list);
  }

  void search(String? searchTerm) {
    this.searchTerm = searchTerm ?? this.searchTerm;
    setNextView();
  }

  void editRow(int index) {
    updateIndex = index;
    // print(nextStartIndex);
    setNextView(startIndex: startingIndex);
  }

  void cancelEditRow() {
    updateIndex = -1;
    setNextView(startIndex: startingIndex);
  }

  void removeItem(int index) {
    list.removeAt(index);
    setNextView(startIndex: startingIndex);
  }

  void updateItemAt(int index, T item) {
    list[index] = item;
    setNextView(startIndex: startingIndex);
  }

  void changePage(int value) {
    startingIndex = value;
  }

  void updateUI() {
    setNextView(startIndex: startingIndex);
  }

  @override
  int get selectedRowCount => 0;
}
