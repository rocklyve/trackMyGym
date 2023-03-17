import 'dart:async';

import 'package:flutter/foundation.dart';

/// Function which can be used as [DebugPrintCallback]
/// which does not use the passed arguments in any way.
///
/// This can be used to disable printing
/// by assigning this function to [debugPrint].
void debugPrintNoOp(String? message, {int? wrapWidth}) {}

/// Function which can be used as [PrintHandler]
/// which does not use the passed arguments in any way.
///
/// This can be used to disable printing in a specific [Zone]
/// by passing it to the [ZoneSpecification] factory when creating the [Zone].
void zonePrintNoOp(Zone self, ZoneDelegate parent, Zone zone, String line) {}

/// Prints a Dart [error] including it's [stackTrace] using [debugPrint].
void dartErrorToDebugPrint(Object error, StackTrace stackTrace) {
  debugPrint('$error $stackTrace');
}
