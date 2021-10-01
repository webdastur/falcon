class QueryBuilder {
  late StringBuffer _buffer;
  static QueryBuilder? _instance;

  QueryBuilder._internal() {
    _buffer = StringBuffer();
  }

  static QueryBuilder get instance {
    if (_instance == null) {
      _instance = QueryBuilder._internal();
    }
    return _instance!;
  }

  static QueryBuilder get i => instance;

  void _write(String value) {
    _buffer.write(" $value");
  }

  QueryBuilder select(List<String> columns) {
    _write("SELECT ${columns.join(", ")}");
    return this;
  }

  QueryBuilder selectAll() {
    return select(["*"]);
  }

  QueryBuilder from(String tableName) {
    _write("FROM ${tableName}");
    return this;
  }

  String build() {
    var result = _buffer.toString().trim();
    _buffer.clear();
    return "$result;";
  }
}
