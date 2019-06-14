import 'package:flutter/services.dart';
import 'package:plugin_scaffold/plugin_scaffold.dart';

class AnalytisRecorderBench {
  static const MethodChannel channel =
      const MethodChannel('analytis_recorder_bench');

  static final records = <String, List<int>>{};

  static Future<void> startRecordingAtNative(Duration duration) async {
    await channel.invokeMethod("startRecording", duration.inMilliseconds);
  }

  static Future<void> stopRecording() async {
    await channel.invokeMethod("stopRecording");
  }

  static Future<Map> getRecordsFromNative() async {
    return await channel.invokeMethod("getRecordings");
  }

  static void startRecordingAtDart(Duration duration) {
    PluginScaffold.createStream(
      channel,
      "record",
      duration.inMilliseconds,
    ).listen((it) {
      final key = it[0];
      final value = it[1];
      if (!records.containsKey(key)) {
        records[key] = [];
      }
      records[key].add(value);
    });
  }
}
