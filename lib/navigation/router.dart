import 'package:TrackMyGains/ui/pages/exercises_overview_page.dart';
import 'package:auto_route/annotations.dart';

import '../ui/pages/base_page.dart';
import '../ui/pages/home_page.dart';
import '../ui/pages/profile_page.dart';
import '../ui/pages/progress_overview_page.dart';

const List<AutoRoute> _tabRoutes = <AutoRoute>[
  AutoRoute(
    page: MyHomePage,
    path: 'home',
  ),
  AutoRoute(
    page: ProgressOverviewPage,
    path: 'progressOverview',
  ),
  AutoRoute(
    page: ExercisesOverviewPage,
    path: 'exerciseOverview',
  ),
  AutoRoute(
    page: ProfilePage,
    path: 'profile',
  ),
];

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<String>(
      page: BasePage,
      path: '/base',
      maintainState: true,
      children: _tabRoutes,
    ),
    RedirectRoute(
      path: '*',
      redirectTo: '/base',
    ),
  ],
)
class $AppRouter {}
