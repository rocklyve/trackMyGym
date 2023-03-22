import 'package:TrackMyGains/navigation/router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../domain/blocs/dynamic_link/dynamic_link_cubit.dart';
import '../../domain/blocs/dynamic_link/dynamic_link_state.dart';
import '../widgets/nav_bar.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  late TabsRouter tabsRouter;

  Future<bool> _onWillPop(BuildContext context) async {
    final RouteData data = context.router.topRoute;
    final bool willPop = data.name == 'HomeRoute';
    if (!willPop) {
      tabsRouter.setActiveIndex(0);
    }

    return willPop;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: BlocListener<DynamicLinkCubit, DynamicLinkState>(
          listener: (context, state) {
            if (state is DynamicLinkStateLoaded &&
                state.path?.isNotEmpty == true) {
              try {
                // a link usually starts with / followed by a link, like /news/id
                List<String> pathSegments = state.path?.split('/') ?? [];
                if (pathSegments.length > 1) {
                  String type = pathSegments[1];
                  String? identifier =
                      pathSegments.length > 2 ? pathSegments[2] : null;
                  debugPrint(
                      'pushing route to $type with identifier $identifier');
                }
              } on Exception catch (error) {
                debugPrint('Error while routing to ${state.path} with $error');
              }
            }
          },
          child: Builder(
            builder: (context) {
              return _buildBlocProviders(
                context,
                child: BlocBuilder<DynamicLinkCubit, DynamicLinkState>(
                  builder: (context, state) {
                    if (state is DynamicLinkStateInitial) {
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => context
                            .read<DynamicLinkCubit>()
                            .startDeeplinkHandling(),
                      );
                    }
                    return AutoTabsScaffold(
                      animationDuration: const Duration(milliseconds: 500),
                      animationCurve: Curves.decelerate,
                      routes: const <PageRouteInfo>[
                        MyHomeRoute(),
                        ProgressOverviewRoute(),
                        ExercisesOverviewRoute(),
                        ProfileRoute(),
                      ],
                      bottomNavigationBuilder: (_, TabsRouter router) {
                        final Map<String, dynamic> metaData =
                            context.router.topRoute.meta;
                        final bool isFullscreen =
                            (metaData.containsKey('bottomNavBarHidden')
                                ? metaData['bottomNavBarHidden']
                                : false) as bool;
                        tabsRouter = router;
                        return !isFullscreen
                            ? AppBottomNavigationBar(
                                currentIndex: router.activeIndex,
                                router: router,
                                items: _buildNavBarItems(context),
                                onActiveTabTap: () {
                                  if (context.router.canPopSelfOrChildren) {
                                    context.router.popTop();
                                  }
                                },
                              )
                            : const SizedBox();
                      },
                    );
                  },
                ),
              );
            },
          ),
        ));
  }

  AppBottomNavigationBarItem _buildAppBottomNavigationBarItem({
    required BuildContext context,
    required Icon icon,
    required Icon inactiveIcon,
    name,
  }) =>
      AppBottomNavigationBarItem(
        text: name,
        activeIcon: icon,
        inactiveIcon: inactiveIcon,
      );

  List<AppBottomNavigationBarItem> _buildNavBarItems(BuildContext context) =>
      <AppBottomNavigationBarItem>[
        _buildAppBottomNavigationBarItem(
          context: context,
          icon: Icon(Ionicons.home),
          inactiveIcon: Icon(Ionicons.home_outline),
          name: "first",
        ),
        _buildAppBottomNavigationBarItem(
          context: context,
          icon: Icon(Ionicons.newspaper),
          inactiveIcon: Icon(Ionicons.newspaper_outline),
          name: "snd",
        ),
        _buildAppBottomNavigationBarItem(
          context: context,
          icon: Icon(Ionicons.videocam),
          inactiveIcon: Icon(Ionicons.videocam_outline),
          name: "third",
        ),
        _buildAppBottomNavigationBarItem(
          context: context,
          icon: Icon(Ionicons.bar_chart),
          inactiveIcon: Icon(Ionicons.bar_chart_outline),
          name: "fourth",
        ),
      ];

  Widget _buildBlocProviders(
    BuildContext context, {
    required Widget child,
  }) {
    final providers = <BlocProvider>[];

    return providers.isNotEmpty
        ? MultiBlocProvider(
            providers: providers,
            child: child,
          )
        : child;
  }
}
