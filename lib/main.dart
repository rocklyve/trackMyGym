import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trackmygains/ui/app.dart';
import 'package:trackmygains/utils/environment.dart';
import 'package:trackmygains/utils/print.dart';

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
