import 'package:falcon_query/src/consts/order_by.dart';

/// [QueryBuilder] is SQL Query Builder class
class QueryBuilder {
  /// private constructor for singleton
  QueryBuilder._internal() {
    _buffer = StringBuffer();
  }

  /// query collector
  late StringBuffer _buffer;

  /// Private instance for singleton
  static QueryBuilder? _instance;

  /// [instance] return [QueryBuilder] instance
  static QueryBuilder get instance {
    _instance ??= QueryBuilder._internal();
    return _instance!;
  }

  /// [i] short form of [instance]
  static QueryBuilder get i => instance;

  void _write(dynamic value) {
    _buffer.write(' $value');
  }

  /// Select columns
  ///
  /// Select [columns] Ex: `SELECT column1, ...`
  QueryBuilder select(List<String> columns) {
    return add("SELECT ${columns.join(", ")}");
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
    return add("SELECT DISTINCT ${columns.join(", ")}");
  }

  /// Select All Distinct values
  ///
  /// Ex: `SELECT DISTINCT * ...`
  QueryBuilder selectAllDistinct() {
    return selectDistinct(['*']);
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
    return add('FROM $tableName');
  }

  /// The `WHERE` clause is used to filter records.
  ///
  /// ```sql
  /// SELECT column1, column2, ...
  /// FROM table_name
  /// WHERE condition;
  /// ```
  QueryBuilder where() {
    return add('WHERE');
  }

  /// Add something to Query
  ///
  /// Ex:
  /// ```dart
  /// QueryBuilder.i
  ///   .selectAll()
  ///   .from('tableName')
  ///   .where()
  ///   .add('FirstName')
  ///   .equal('Alex')
  ///   .build();
  /// ```
  /// return
  /// ```sql
  /// SELECT * FROM tableName WHERE FirstName='Alex';
  /// ```
  QueryBuilder add(dynamic value) {
    _write(value);
    return this;
  }

  /// Check value is number
  bool _isNum(dynamic value) {
    return value is int || value is double;
  }

  /// Equal operator '='
  QueryBuilder equal(dynamic value) {
    if (_isNum(value)) {
      return add('= $value');
    }
    return add('= \'$value\'');
  }

  /// Greater Than operator '>'
  QueryBuilder greaterThan(dynamic value) {
    if (_isNum(value)) {
      return add('> $value');
    }
    return add('> \'$value\'');
  }

  /// Less Than operator '<'
  QueryBuilder lessThan(dynamic value) {
    if (_isNum(value)) {
      return add('< $value');
    }
    return add('< \'$value\'');
  }

  /// Greater Than Or Equal operator '>='
  QueryBuilder greaterThanOrEqual(dynamic value) {
    if (_isNum(value)) {
      return add('>= $value');
    }
    return add('>= \'$value\'');
  }

  /// Less Than Or Equal operator '<='
  QueryBuilder lessThanOrEqual(dynamic value) {
    if (_isNum(value)) {
      return add('<= $value');
    }
    return add('<= \'$value\'');
  }

  /// Not Equal operator '!='
  QueryBuilder notEqual(dynamic value) {
    if (_isNum(value)) {
      return add('!= $value');
    }
    return add('!= \'$value\'');
  }

  /// BETWEEN operator
  QueryBuilder between() {
    return add('BETWEEN');
  }

  /// LIKE operator
  QueryBuilder like(String pattern) {
    return add('LIKE \'$pattern\'');
  }

  /// IN Operator
  ///
  /// Ex:
  /// ```dart
  /// QueryBuilder.i
  ///   .selectAll()
  ///   .from('tableName')
  ///   .where()
  ///   .add('FirstName')
  ///   .iN(['Alex', 'John', 'Jacky'])
  ///   .build();
  /// ```
  /// return
  /// ```sql
  /// SELECT * FROM tableName WHERE FirstName IN ('Alex', 'John', 'Jacky');
  /// ```
  QueryBuilder iN(List values) {
    values = values.map<dynamic>((dynamic e) {
      if (_isNum(e)) {
        return e;
      }
      return '\'$e\'';
    }).toList();
    return add('IN (${values.join(', ')})');
  }

  /// AND operator
  QueryBuilder and() {
    return add('AND');
  }

  /// OR operator
  QueryBuilder or() {
    return add('OR');
  }

  /// NOT operator
  QueryBuilder not() {
    return add('NOT');
  }

  /// ORDER BY for ordering
  ///
  /// [columns] columns for ordering(sorting)
  /// [sort] for sorting [OrderBy.asc] or [OrderBy.desc]
  QueryBuilder orderBy({
    required List<String> columns,
    String sort = OrderBy.asc,
  }) {
    return add('ORDER BY ${columns.join(', ')} $sort');
  }

  /// INSERT INTO statement
  ///
  /// Insert new record to [tableName]
  /// [columns] is column names
  /// [values] is column values
  QueryBuilder insertInto({
    required String tableName,
    List<String> columns = const [],
    required List<dynamic> values,
  }) {
    values = values.map<dynamic>((e) {
      if (_isNum(e)) {
        return e;
      }
      return '\'$e\'';
    }).toList();
    if (columns.isEmpty) {
      return add('INSERT INTO $tableName VALUES (${values.join(', ')})');
    }
    return add(
      'INSERT INTO $tableName '
      '(${columns.join(', ')}) VALUES (${values.join(', ')})',
    );
  }

  /// Check column value is null
  QueryBuilder isNull(String column) {
    return add('$column IS NULL');
  }

  /// Check column value is not null
  QueryBuilder isNotNull(String column) {
    return add('$column IS NOT NULL');
  }

  /// Returns completed SQL Query
  String build() {
    var result = _buffer.toString().trim();
    _buffer.clear();
    return '$result;';
  }
}
