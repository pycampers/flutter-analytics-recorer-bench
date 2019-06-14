import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

/// Total run time for the test
final runTime = Duration(seconds: 10);

/// Duration between successive data write operations
final recordWriteDuration = Duration(milliseconds: 100);

/// Duration between successive data read operations
final recordReadDuration = Duration(seconds: 1);

void main() {
  FlutterDriver driver;

  final recordNative = find.byValueKey('recordNative');
  final recordDart = find.byValueKey('recordDart');
  final stop = find.byValueKey('stop');

  final baseDir = File(Platform.script.toFilePath()).parent.parent.parent.path +
      "/results/${DateTime.now().toIso8601String()}";

  setUpAll(() async {
    driver = await FlutterDriver.connect();
    await Directory(baseDir).create(recursive: true);
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  test(
    "test recorder",
    () async {
      final timelineNative = await driver.traceAction(() async {
        await driver.tap(recordNative);
        await Future.delayed(runTime);
        await driver.tap(stop);
      });

      final summaryNative = new TimelineSummary.summarize(timelineNative);
      await summaryNative.writeSummaryToFile(
        baseDir + '/native_summary',
        pretty: true,
      );
      await summaryNative.writeTimelineToFile(
        baseDir + '/native_timeline',
        pretty: true,
      );

      final timelineDart = await driver.traceAction(() async {
        await driver.tap(recordDart);
        await Future.delayed(runTime);
        await driver.tap(stop);
      });

      final summaryDart = new TimelineSummary.summarize(timelineDart);
      await summaryDart.writeSummaryToFile(
        baseDir + '/dart_summary',
        pretty: true,
      );
      await summaryDart.writeTimelineToFile(
        baseDir + '/dart_timeline',
        pretty: true,
      );
    },
    timeout: Timeout(Duration(seconds: 30)),
  );
}
