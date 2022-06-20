import 'package:flutter/material.dart';

abstract class BlocBase {
  void init();
  void dispose();
}

// Generic BLoC provider
class BlocProvider<T extends BlocBase> extends StatefulWidget {

  const BlocProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }): super(key: key);

  final T bloc;
  final Widget child;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context){
    _BlocProviderInherited<T> provider =
        context.getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()?.widget as _BlocProviderInherited<T>;
    return provider.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>>{

  @override
  void initState() {
    widget.bloc.init();
    super.initState();
  }

  @override
  void dispose(){
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {

  const _BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.bloc,
  }) : super(key: key, child: child);
  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => oldWidget.bloc != bloc;
}