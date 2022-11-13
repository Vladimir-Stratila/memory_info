import Flutter
import UIKit

public class SwiftMemoryInfoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "name.stratila.vladimir/memory_info", binaryMessenger: registrar.messenger())
    let instance = SwiftMemoryInfoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "getDiskSpace":
            result(["diskFreeSpace": MemoryInfo.diskFreeSpace(),
                    "diskTotalSpace": MemoryInfo.diskTotalSpace()])
        case "getMemoryInfo":
            result(["usedByApp": MemoryInfo.memoryUsedByApp(),
                    "total": MemoryInfo.physicalMemory(),
                    "free": MemoryInfo.memoryUsage().free])
        default:
            result(FlutterMethodNotImplemented)
    }
  }
}
