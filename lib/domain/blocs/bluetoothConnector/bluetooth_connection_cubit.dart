import 'package:flutter_bloc/flutter_bloc.dart';

import 'bluetooth_connection_state.dart';

class BluetoothConnectionCubit extends Cubit<BluetoothConnectionState> {
  BluetoothConnectionCubit() : super(const BluetoothConnectionState.initial());

  void startObserving() {
    return;
  }
}
