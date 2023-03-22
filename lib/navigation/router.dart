import 'package:TrackMyGains/ui/home_page.dart';
import 'package:auto_route/annotations.dart';

const List<AutoRoute> _tabRoutes = <AutoRoute>[];

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<String>(
      page: MyHomePage,
      path: '/',
      maintainState: true,
      children: _tabRoutes,
    ),
  ],
)
class $AppRouter {}
