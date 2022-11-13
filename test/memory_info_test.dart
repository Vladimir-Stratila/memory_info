import 'package:flutter_test/flutter_test.dart';
import 'package:memory_info/memory_info.dart';
import 'package:memory_info/memory_info_platform_interface.dart';
import 'package:memory_info/memory_info_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMemoryInfoPlatform
    with MockPlatformInterfaceMixin
    implements MemoryInfoPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MemoryInfoPlatform initialPlatform = MemoryInfoPlatform.instance;

  test('$MethodChannelMemoryInfo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMemoryInfo>());
  });

  test('getPlatformVersion', () async {
    MemoryInfo memoryInfoPlugin = MemoryInfo();
    MockMemoryInfoPlatform fakePlatform = MockMemoryInfoPlatform();
    MemoryInfoPlatform.instance = fakePlatform;

    expect(await memoryInfoPlugin.getPlatformVersion(), '42');
  });
}
