import 'package:bloxman/core/db/database_service.dart';

class DatabaseClient {

  static Future<DatabaseService> init() async => await $FloorDatabaseService
      .databaseBuilder('bloxman.db')
      .build();
}