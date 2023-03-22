import 'package:flutter_bloc/flutter_bloc.dart';

import 'dynamic_link_state.dart';

class DynamicLinkCubit extends Cubit<DynamicLinkState> {
  DynamicLinkCubit() : super(const DynamicLinkState.initial());

  static const String _path = 'path';

  Future<void> startDeeplinkHandling() async {
    return;
  }
}
