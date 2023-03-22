import 'package:freezed_annotation/freezed_annotation.dart';

part 'dynamic_link_state.freezed.dart';

@freezed
class DynamicLinkState with _$DynamicLinkState {
  const factory DynamicLinkState.initial() = DynamicLinkStateInitial;

  const factory DynamicLinkState.loading() = DynamicLinkStateLoading;

  const factory DynamicLinkState.loaded(String? path) = DynamicLinkStateLoaded;

  const factory DynamicLinkState.error({required Object? error}) =
      DynamicLinkStateError;
}
