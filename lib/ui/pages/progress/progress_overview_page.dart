import 'package:flutter/material.dart';

class ProgressOverviewPage extends StatefulWidget {
  const ProgressOverviewPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProgressOverviewPage();
}

class _ProgressOverviewPage extends State<ProgressOverviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(color: const Color(0xFF1E1E1E)),
    );
  }
}
