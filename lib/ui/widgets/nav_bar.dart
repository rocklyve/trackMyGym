import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.items,
    required this.currentIndex,
    required this.router,
    required this.onActiveTabTap,
    Key? key,
  }) : super(key: key);

  final List<AppBottomNavigationBarItem> items;
  final int currentIndex;
  final TabsRouter router;
  final void Function() onActiveTabTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).padding.bottom + 80,
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.white10,
              offset: const Offset(0, -4),
              blurRadius: 12,
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _buildNavBarItems(items, context),
        ),
      ),
    );
  }

  List<Widget> _buildNavBarItems(
    List<AppBottomNavigationBarItem> items,
    BuildContext context,
  ) =>
      items
          .mapIndexed(
            (
              int index,
              AppBottomNavigationBarItem item,
            ) =>
                Flexible(
              child: GestureDetector(
                onTap: () {
                  if (index == router.activeIndex) {
                    onActiveTabTap();
                  } else {
                    router.setActiveIndex(index);
                  }
                },
                child: Container(
                  width: 78,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: currentIndex == index ? 5 : 10,
                      ),
                      currentIndex == index
                          ? item.activeIcon
                          : item.inactiveIcon,
                      SizedBox(
                        height: currentIndex == index ? 5 : 10,
                      ),
                      Text(
                        item.text,
                        style: currentIndex == index
                            ? (item.activeStyle ??
                                TextStyle(color: Colors.white))
                            : (item.inactiveStyle ??
                                TextStyle(color: Colors.white10)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList();
}

class AppBottomNavigationBarItem {
  AppBottomNavigationBarItem({
    required this.text,
    required this.activeIcon,
    required this.inactiveIcon,
    this.activeStyle,
    this.inactiveStyle,
  });

  final String text;
  final Widget activeIcon, inactiveIcon;
  final TextStyle? activeStyle, inactiveStyle;
}
