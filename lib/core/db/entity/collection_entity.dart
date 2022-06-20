import 'package:floor/floor.dart';

@entity
class CollectionEntity {

  @PrimaryKey(autoGenerate: true)
  int? id;
  final String name;

  CollectionEntity(this.name);
  CollectionEntity.withId(this.name, this.id);
}