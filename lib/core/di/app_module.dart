import 'package:bloxman/core/db/database_client.dart';
import 'package:bloxman/core/db/database_service.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {

  @preResolve
  Future<DatabaseService> get databaseService => DatabaseClient.init();
}