import 'memory.dart';
import 'disk_space.dart';
import 'memory_info_platform_interface.dart';

class MemoryInfoPlugin {
  MemoryInfoPlugin();

  static MemoryInfoPlatform get _platform => MemoryInfoPlatform.instance;

  Future<String?> get platformVersion => _platform.platformVersion();
  Future<DiskSpace> get diskSpace => _platform.diskSpace();
  Future<Memory> get memoryInfo => _platform.memoryInfo();
}
