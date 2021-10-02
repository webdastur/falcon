import 'package:falcon_query/falcon_query.dart';
import 'package:falcon_query/src/consts/order_by.dart';
import 'package:test/test.dart';

void main() {
  test('all from \'tableName\'', () {
    var query = QueryBuilder.i.selectAll().from('tableName').build();
    expect(query, equals('SELECT * FROM tableName;'));
  });

  test('column1 and column2 from \'tableName\'', () {
    var query =
        QueryBuilder.i.select(['column1', 'column2']).from('tableName').build();
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

  test('where "equal", "greater than", "less than", "and"', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('name')
        .equal('Alex')
        .and()
        .add('age')
        .greaterThan(18)
        .and()
        .add('updatedAt')
        .lessThan('2021-10-01')
        .build();
    expect(
      query,
      equals('''
SELECT * FROM tableName WHERE name = \'Alex\' AND age > 18 AND updatedAt < \'2021-10-01\';'''),
    );
  });

  test('greater than string', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('name')
        .greaterThan('Alex')
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE name > \'Alex\';',
    );
  });

  test('greater than or equal', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('age')
        .greaterThanOrEqual(18)
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE age >= 18;',
    );
  });

  test('greater than or equal string', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('name')
        .greaterThanOrEqual('Alex')
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE name >= \'Alex\';',
    );
  });

  test('less than string', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('name')
        .lessThan('Alex')
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE name < \'Alex\';',
    );
  });

  test('less than', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('age')
        .lessThan(18)
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE age < 18;',
    );
  });

  test('less than or equal string', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('name')
        .lessThanOrEqual('Alex')
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE name <= \'Alex\';',
    );
  });

  test('less than or equal', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('age')
        .lessThanOrEqual(18)
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE age <= 18;',
    );
  });

  test('not equal string', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('name')
        .notEqual('Alex')
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE name != \'Alex\';',
    );
  });

  test('not equal', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('age')
        .notEqual(18)
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE age != 18;',
    );
  });

  test('or, not', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .not()
        .add('age')
        .equal(18)
        .or()
        .add('name')
        .equal('Alex')
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE NOT age = 18 OR name = \'Alex\';',
    );
  });

  test('between', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('price')
        .between()
        .add(10)
        .and()
        .add(20)
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE price BETWEEN 10 AND 20;',
    );
  });

  test('like', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('name')
        .like('a%')
        .build();
    expect(
      query,
      'SELECT * FROM tableName WHERE name LIKE \'a%\';',
    );
  });

  test('in', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .where()
        .add('name')
        .iN(['Alex', 'John', 'Jacky']).build();
    expect(
      query,
      'SELECT * FROM tableName WHERE name IN (\'Alex\', \'John\', \'Jacky\');',
    );
  });

  test('order by asc', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .orderBy(columns: ['column1', 'column2']).build();
    expect(
      query,
      'SELECT * FROM tableName ORDER BY column1, column2 ASC;',
    );
  });

  test('order by desc', () {
    var query = QueryBuilder.i
        .selectAll()
        .from('tableName')
        .orderBy(columns: ['column1', 'column2'], sort: OrderBy.desc).build();
    expect(
      query,
      'SELECT * FROM tableName ORDER BY column1, column2 DESC;',
    );
  });
}
