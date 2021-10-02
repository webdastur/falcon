import 'package:falcon_query/falcon_query.dart';

void main() {
  // SQL Query
  var query = QueryBuilder.i.selectAll().from('tableName').build();
  print(query);
  // SELECT * FROM tableName;
}
