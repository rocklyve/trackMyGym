import 'package:flutter/material.dart';

import '../environment_data.dart';

class Environment extends StatelessWidget {
  const Environment({
    super.key,
    required this.data,
    required this.child,
  });

  static EnvironmentData of(BuildContext context) {
    final element = context
        .getElementForInheritedWidgetOfExactType<_InheritedEnvironment>();
    final widget = element?.widget as _InheritedEnvironment?;
    if (widget != null) {
      return widget.environment.data;
    }

    throw FlutterError(
      'Environment.of() called with a context that does not contain a Environment.\n'
      'No Environment ancestor could be found starting from the context that was passed '
      'to Environment.of(). \n'
      'The context used was:\n'
      '  $context',
    );
  }

  final EnvironmentData data;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      _InheritedEnvironment(environment: this, child: child);
}

class _InheritedEnvironment extends InheritedWidget {
  const _InheritedEnvironment({
    Key? key,
    required this.environment,
    required Widget child,
  }) : super(key: key, child: child);

  final Environment environment;

  @override
  bool updateShouldNotify(_InheritedEnvironment old) => false;
}
