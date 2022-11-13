import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'memory_info_method_channel.dart';

abstract class MemoryInfoPlatform extends PlatformInterface {
  /// Constructs a MemoryInfoPlatform.
  MemoryInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static MemoryInfoPlatform _instance = MethodChannelMemoryInfo();

  /// The default instance of [MemoryInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelMemoryInfo].
  static MemoryInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MemoryInfoPlatform] when
  /// they register themselves.
  static set instance(MemoryInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> platformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<DiskSpace> diskSpace() {
    throw UnimplementedError('diskSpace() has not been implemented.');
  }

  Future<Memory> memoryInfo() {
    throw UnimplementedError('memoryInfo() has not been implemented.');
  }
}
