import 'package:floor/floor.dart';

@entity
class ContactEntity {

  @PrimaryKey(autoGenerate: true)
  int? id;
  String? collectionId;
  final String name;
  final String phone;

  ContactEntity(this.name, this.phone);
  ContactEntity.withCollection(this.name, this.phone, this.collectionId);
}