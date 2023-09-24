import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  void back<T extends Object?>([T? result]) {
    Navigator.of(this).pop();
  }

  Future<T?> left<T extends Object?>(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      predicate,
      arguments: arguments,
    );
  }

  Future<T?> toName<T extends Object?>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }
}
