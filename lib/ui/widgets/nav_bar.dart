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

  final int _navbarHeight = 50;
  final double _navbarItemTopPadding = 7.5;
  final double _navbarItemWidth = 78;

  final Color _navbarItemTextColor = const Color(0xFF4E9FA7);
  final Color _navbarItemTextInactiveColor = Colors.black54;

  final Color _navbarBackgroundColor = const Color(0xFFF1F4F9);

  List<Widget> _buildNavBarItems(
    List<AppBottomNavigationBarItem> items,
    BuildContext context,
  ) {
    return items
        .mapIndexed(
          (
            int index,
            AppBottomNavigationBarItem item,
          ) =>
              Flexible(
            child: GestureDetector(
              onTap: () => _switchTab(index),
              child: Container(
                width: _navbarItemWidth,
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: _navbarItemTopPadding),
                    currentIndex == index ? item.activeIcon : item.inactiveIcon,
                    SizedBox(height: _navbarItemTopPadding),
                    Text(
                      item.text,
                      style: currentIndex == index
                          ? (item.activeStyle ??
                              TextStyle(color: _navbarItemTextColor))
                          : (item.inactiveStyle ??
                              TextStyle(color: _navbarItemTextInactiveColor)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  void _switchTab(int index) {
    if (index == router.activeIndex) {
      onActiveTabTap();
    } else {
      router.setActiveIndex(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 15.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).padding.bottom + _navbarHeight,
        decoration: BoxDecoration(
          color: _navbarBackgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, -6),
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
}

class AppBottomNavigationBarItem {
  final String text;
  final Widget activeIcon, inactiveIcon;
  final TextStyle? activeStyle, inactiveStyle;

  AppBottomNavigationBarItem({
    required this.text,
    required this.activeIcon,
    required this.inactiveIcon,
    this.activeStyle,
    this.inactiveStyle,
  });
}
