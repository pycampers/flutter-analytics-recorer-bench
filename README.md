# analytis_recorder_bench

It aims to compare 2 different ways of recording data in plugins.

1. Record random data in Kotlin, after every `recordWriteDuration`.
    Then read it from Kotlin every `recordReadDuration`, and show it on the screen.

2. Record random data in Kotlin, transport it to dart, every `recordWriteDuration`.
    Then read it from Dart every `recordReadDuration`, and show it on the screen.

The results are available in the [results](results) folder, along with the environment config they were run in.

---

This was originally created for the flutter_cognito_plugin,
and is part of a bigger initiative to make software development a _proper_ science.

---

You may run the tests for yourself, using:

```
$ cd example
$ flutter drive --profile --target=test_driver/app.dart
```

We encourage you to submit your test results on a different env.

The scientific method is all about comparing observations,
and this benchmark is merely an excuse for us to experiment with this process in software development.

---

The [parameters](example/test_driver/app_test.dart) are selected under an assumption that data will be recorded often,
but accessed at a releatively slower pace.

Should you chose to tweak them, you are required to publish those numbers as well.
