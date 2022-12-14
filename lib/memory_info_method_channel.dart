import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'memory.dart';
import 'disk_space.dart';
import 'memory_info_platform_interface.dart';

/// An implementation of [MemoryInfoPlatform] that uses method channels.
class MethodChannelMemoryInfo extends MemoryInfoPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final channel = const MethodChannel('name.stratila.vladimir/memory_info');

  @override
  Future<String?> platformVersion() async {
    final version = await channel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<DiskSpace> diskSpace() async {
    return DiskSpace.fromMap(
      (await channel.invokeMethod('getDiskSpace')).cast<String, dynamic>(),
    );
  }

  @override
  Future<Memory> memoryInfo() async {
    return Memory.fromMap(
      (await channel.invokeMethod('getMemoryInfo')).cast<String, dynamic>(),
    );
  }
}
