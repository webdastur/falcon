/// [QueryBuilder] is SQL Query Builder class
class QueryBuilder {
  QueryBuilder._internal() {
    _buffer = StringBuffer();
  }

  late StringBuffer _buffer;
  static QueryBuilder? _instance;

  /// [instance] return [QueryBuilder] instance
  static QueryBuilder get instance {
    _instance ??= QueryBuilder._internal();
    return _instance!;
  }

  /// [i] short form of [instance]
  static QueryBuilder get i => instance;

  void _write(String value) {
    _buffer.write(' $value');
  }

  /// Select columns
  ///
  /// Select [columns] Ex: `SELECT column1, ...`
  QueryBuilder select(List<String> columns) {
    _write("SELECT ${columns.join(", ")}");
    return this;
  }

  /// Select All Columns
  ///
  /// Ex: `SELECT * ...`
  QueryBuilder selectAll() {
    return select(['*']);
  }

  /// Select Distinct values
  ///
  /// Select Distinct [columns] Ex: `SELECT DISTINCT column1, ...`
  QueryBuilder selectDistinct(List<String> columns) {
    _write("SELECT DISTINCT ${columns.join(", ")}");
    return this;
  }

  /// Select All Distinct values
  ///
  /// Ex: `SELECT DISTINCT * ...`
  QueryBuilder selectAllDistinct() {
    selectDistinct(['*']);
    return this;
  }

  /// FROM statement
  ///
  /// Ex:
  /// ```dart
  /// QueryBuilder.i.selectAll().from('tableName').build();
  /// ```
  /// Return:
  /// ```sql
  /// SELECT * FROM tableName;
  /// ```
  QueryBuilder from(String tableName) {
    _write('FROM $tableName');
    return this;
  }

  /// Returns completed SQL Query
  String build() {
    var result = _buffer.toString().trim();
    _buffer.clear();
    return '$result;';
  }
}
