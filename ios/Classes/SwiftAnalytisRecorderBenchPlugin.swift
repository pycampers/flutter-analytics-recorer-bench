import Flutter
import UIKit

public class SwiftAnalytisRecorderBenchPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "analytis_recorder_bench", binaryMessenger: registrar.messenger())
    let instance = SwiftAnalytisRecorderBenchPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
