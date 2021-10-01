import 'package:falcon_query/falcon_query.dart';
import 'package:test/test.dart';

void main() {
  group('SELECT ', () {
    test('all from \'tableName\'', () {
      var query = QueryBuilder.i.selectAll().from('tableName').build();
      expect(query, equals('SELECT * FROM tableName;'));
    });

    test('column1 and column2 from \'tableName\'', () {
      var query = QueryBuilder.i
          .select(['column1', 'column2'])
          .from('tableName')
          .build();
      expect(query, equals('SELECT column1, column2 FROM tableName;'));
    });

    test('distinct columns from \'tableName\'', () {
      var query = QueryBuilder.i
          .selectDistinct(['column1', 'column2'])
          .from('tableName')
          .build();
      expect(query, equals('SELECT DISTINCT column1, column2 FROM tableName;'));
    });

    test('distinct all columns from \'tableName\'', () {
      var query = QueryBuilder.i.selectAllDistinct().from('tableName').build();
      expect(query, equals('SELECT DISTINCT * FROM tableName;'));
    });
  });
}
