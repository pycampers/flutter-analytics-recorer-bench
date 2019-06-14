import 'package:analytis_recorder_bench/analytis_recorder_bench.dart';
import 'package:flutter/material.dart';

import 'app_test.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isNative;
  var recordText = "";

  Future<void> load() async {
    while (true) {
      await Future.delayed(recordReadDuration);
      if (isNative == null) continue;

      var value;
      if (isNative) {
        value = await AnalytisRecorderBench.getRecordsFromNative();
      } else {
        value = AnalytisRecorderBench.records;
      }

      if (!mounted) return;
      setState(() {
        recordText = value.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: <Widget>[
            RaisedButton(
              child: Text("stop"),
              key: Key('stop'),
              onPressed: () {
                AnalytisRecorderBench.stopRecording();
                isNative = null;
              },
            ),
            RaisedButton(
              child: Text('Record native'),
              key: Key('recordNative'),
              onPressed: () {
                isNative = true;
                AnalytisRecorderBench.startRecordingAtNative(
                    recordWriteDuration);
              },
            ),
            RaisedButton(
              child: Text('Record dart'),
              key: Key('recordDart'),
              onPressed: () {
                isNative = false;
                AnalytisRecorderBench.startRecordingAtDart(recordWriteDuration);
              },
            ),
            Text(recordText),
          ],
        ),
      ),
    );
  }
}
