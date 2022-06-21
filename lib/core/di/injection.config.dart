// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../contact/presentation/bloc/contact_bloc.dart' as _i5;
import '../db/database_service.dart' as _i6;
import '../service/block_service.dart' as _i3;
import '../service/contact_block_service.dart' as _i4;
import 'app_module.dart' as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final appModule = _$AppModule();
  gh.factory<_i3.BlockService>(() => _i4.ContactBlockService());
  gh.factory<_i5.ContactBloc>(() => _i5.ContactBloc());
  await gh.factoryAsync<_i6.DatabaseService>(() => appModule.databaseService,
      preResolve: true);
  return get;
}

class _$AppModule extends _i7.AppModule {}
