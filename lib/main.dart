import 'dart:async';

import 'package:bloxman/core/di/injection.dart';
import 'package:bloxman/core/logger/logger.dart';
import 'package:bloxman/core/provider/bloc_provider.dart';
import 'package:bloxman/home/presentation/bloc/home_bloc.dart';
import 'package:bloxman/home/presentation/ui/home_page.dart';
import 'package:flutter/material.dart';

import 'core/utils/constant.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {

    WidgetsFlutterBinding.ensureInitialized();
    await configureDependencies();
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
        primarySwatch: MaterialColor(
          0xFFF65826,
          <int, Color>{
            50: Color(0xFFFFFFFF),
            100: Color(0xFFFFE3D8),
            200: Color(0xFFF5F5F5),
            300: Color(0xFFF5F5F5),
            500: Color(0xFFF65826),
            600: Color(0xFFF65826),
            700: Color(0xFFFE7436),
          },
        ),
        fontFamily: 'Poppins',
        textTheme: TextTheme(
          subtitle1: TextStyle(
            color: Color(0xFF1A1A1A),
          ),
        ),
      ),
      home: BlocProvider(child: const HomePage(), bloc: HomeBloc()),
      debugShowCheckedModeBanner: false,
    );
  }
}
