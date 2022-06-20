import 'package:bloxman/core/db/entity/collection_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class CollectionDao {

  @insert
  Future<int> add(CollectionEntity collection);

  @Query('SELECT * FROM CollectionEntity')
  Future<List<CollectionEntity>> findAll();

  @Query('DELETE FROM CollectionEntity WHERE id = :id')
  Future<CollectionEntity?> delete(int id);
}