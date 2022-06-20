import 'package:bloxman/core/provider/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {
  final _bottomNavIndexController = BehaviorSubject<int>();
  Function(int index) get _bottomNavIndexSink =>
      _bottomNavIndexController.sink.add;
  Stream<int> get bottomNavIndexStream => _bottomNavIndexController.stream;

  final _contactTitleController = BehaviorSubject<String>();
  Function(String) get _contactTitleSink => _contactTitleController.sink.add;
  Stream<String> get contactTitleStream => _contactTitleController.stream;

  @override
  void dispose() {
    _bottomNavIndexController.close();
    _contactTitleController.close();
  }

  @override
  void init() {
    updateBottomNavIndex(0);
  }

  void updateBottomNavIndex(int index) {
    _bottomNavIndexSink(index);
  }
}
