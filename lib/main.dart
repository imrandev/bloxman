import 'dart:async';

import 'package:bloxman/core/provider/bloc_provider.dart';
import 'package:bloxman/home/presentation/bloc/home_bloc.dart';
import 'package:bloxman/home/presentation/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'core/di/app_component.dart';
import 'core/logger/logger.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    await AppComponent().init();

    runApp(const BloxApp());
  }, (error, stackTrace) => logger.printDebugLog(error.toString()));
}

class BloxApp extends StatelessWidget {
  const BloxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blox',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Poppins',
      ),
      home: BlocProvider(child: const HomePage(), bloc: HomeBloc()),
      debugShowCheckedModeBanner: false,
    );
  }
}
