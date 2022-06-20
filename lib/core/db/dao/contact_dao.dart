import 'package:bloxman/core/db/entity/contact_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class ContactDao {
  @insert
  Future<int> add(ContactEntity contact);

  @Query('SELECT * FROM ContactEntity')
  Future<List<ContactEntity>> findAll();

  @Query('DELETE FROM ContactEntity WHERE id = :id')
  Future<ContactEntity?> delete(int id);
}