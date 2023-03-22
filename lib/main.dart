import 'dart:async';

import 'package:TrackMyGains/ui/app.dart';
import 'package:TrackMyGains/utils/environment.dart';
import 'package:TrackMyGains/utils/print.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'environment_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const environment = EnvironmentData(
    appTitle: 'TrackMyGym',
    appVersion: '1.0',
  );

  await runMain(environment);
}

Future<void> runMain(EnvironmentData environment) async {
  // Debug printing.
  debugPrint = kDebugMode ? debugPrintThrottled : debugPrintNoOp;

  // Debug tools.
  if (kDebugMode) {
    EquatableConfig.stringify = true;
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  // final database = Database();
  // await database.open(filename: environment.databasePath);

  // App execution
  runZonedGuarded<void>(
    () => runApp(
      Environment(
        data: environment,
        child: const App(),
      ),
    ),
    dartErrorToDebugPrint,
    zoneSpecification: const ZoneSpecification(
      print: kDebugMode ? null : zonePrintNoOp,
    ),
  );
}
