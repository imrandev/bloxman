// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_service.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorDatabaseService {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseServiceBuilder databaseBuilder(String name) =>
      _$DatabaseServiceBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$DatabaseServiceBuilder inMemoryDatabaseBuilder() =>
      _$DatabaseServiceBuilder(null);
}

class _$DatabaseServiceBuilder {
  _$DatabaseServiceBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$DatabaseServiceBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$DatabaseServiceBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<DatabaseService> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$DatabaseService();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$DatabaseService extends DatabaseService {
  _$DatabaseService([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ContactDao? _contactDaoInstance;

  CollectionDao? _collectionDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ContactEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `collectionId` TEXT, `name` TEXT NOT NULL, `phone` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CollectionEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ContactDao get contactDao {
    return _contactDaoInstance ??= _$ContactDao(database, changeListener);
  }

  @override
  CollectionDao get collectionDao {
    return _collectionDaoInstance ??= _$CollectionDao(database, changeListener);
  }
}

class _$ContactDao extends ContactDao {
  _$ContactDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _contactEntityInsertionAdapter = InsertionAdapter(
            database,
            'ContactEntity',
            (ContactEntity item) => <String, Object?>{
                  'id': item.id,
                  'collectionId': item.collectionId,
                  'name': item.name,
                  'phone': item.phone
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ContactEntity> _contactEntityInsertionAdapter;

  @override
  Future<List<ContactEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM ContactEntity',
        mapper: (Map<String, Object?> row) =>
            ContactEntity(row['name'] as String, row['phone'] as String));
  }

  @override
  Future<ContactEntity?> delete(int id) async {
    return _queryAdapter.query('DELETE FROM ContactEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            ContactEntity(row['name'] as String, row['phone'] as String),
        arguments: [id]);
  }

  @override
  Future<int> add(ContactEntity contact) {
    return _contactEntityInsertionAdapter.insertAndReturnId(
        contact, OnConflictStrategy.abort);
  }
}

class _$CollectionDao extends CollectionDao {
  _$CollectionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _collectionEntityInsertionAdapter = InsertionAdapter(
            database,
            'CollectionEntity',
            (CollectionEntity item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CollectionEntity> _collectionEntityInsertionAdapter;

  @override
  Future<List<CollectionEntity>> findAll() async {
    return _queryAdapter.queryList('SELECT * FROM CollectionEntity',
        mapper: (Map<String, Object?> row) =>
            CollectionEntity(row['name'] as String));
  }

  @override
  Future<CollectionEntity?> delete(int id) async {
    return _queryAdapter.query('DELETE FROM CollectionEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            CollectionEntity(row['name'] as String),
        arguments: [id]);
  }

  @override
  Future<int> add(CollectionEntity collection) {
    return _collectionEntityInsertionAdapter.insertAndReturnId(
        collection, OnConflictStrategy.abort);
  }
}
