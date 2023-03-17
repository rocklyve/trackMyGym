import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bluetooth_connection_state.freezed.dart';

@freezed
class BluetoothConnectionState with _$BluetoothConnectionState {
  const factory BluetoothConnectionState.initial() =
      BluetoothConnectionStateInitial;

  const factory BluetoothConnectionState.loading() =
      BluetoothConnectionStateLoading;

  const factory BluetoothConnectionState.loaded(
    bool isConnected,
  ) = BluetoothConnectionStateLoaded;

  const factory BluetoothConnectionState.error({
    required dynamic error,
  }) = BluetoothConnectionStateError;
}
