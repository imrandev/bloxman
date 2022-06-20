import 'dart:async';

import 'package:bloxman/core/db/dao/collection_dao.dart';
import 'package:bloxman/core/db/dao/contact_dao.dart';
import 'package:bloxman/core/db/entity/collection_entity.dart';
import 'package:bloxman/core/db/entity/contact_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database_service.g.dart';

@Database(version: 1, entities: [
  ContactEntity, CollectionEntity
])
abstract class DatabaseService extends FloorDatabase {
  ContactDao get contactDao;
  CollectionDao get collectionDao;
}