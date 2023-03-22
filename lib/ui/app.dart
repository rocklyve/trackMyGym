import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/blocs/bluetoothConnector/bluetooth_connection_cubit.dart';
import '../domain/repositories/data_repository.dart';
import '../domain/repositories/data_repository_impl.dart';
import '../navigation/router.gr.dart';
import '../utils/environment.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    // required this.database,
  });

  // final Database database;
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DataRepository>(
          create: (context) => DataRepositoryImplementation(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<BluetoothConnectionCubit>(
                create: (context) =>
                    BluetoothConnectionCubit(), // ..startListener(),
                lazy: false,
              ),
            ],
            child: MaterialApp.router(
              routerDelegate: _appRouter.delegate(
                navigatorObservers: () => [AutoRouteObserver()],
              ),
              routeInformationProvider: _appRouter.routeInfoProvider(),
              routeInformationParser:
                  _appRouter.defaultRouteParser(includePrefixMatches: true),
              title: Environment.of(context).appTitle,
              supportedLocales: const <Locale>[
                Locale.fromSubtags(languageCode: 'de'),
                Locale.fromSubtags(languageCode: 'en'),
              ],
              debugShowCheckedModeBanner: false,
            ),
          );
        },
      ),
    );
  }
}
