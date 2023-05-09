import 'package:flutter/material.dart';
import 'package:flutter_app_burguers/burgers_store_bloc.dart';

class BurgersProvider extends InheritedWidget {
  final BurgerStoreBloC bloc;
  final Widget child;

  BurgersProvider({
    required this.bloc,
    required this.child
  }) : super(child:child);

  static BurgersProvider? of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<BurgersProvider>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}