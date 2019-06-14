package com.pycampers.analytis_recorder_bench

import com.pycampers.plugin_scaffold.StreamSink
import com.pycampers.plugin_scaffold.createPluginScaffold
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.util.Random
import java.util.Timer
import kotlin.concurrent.timer

class AnalytisRecorderBenchPlugin {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            createPluginScaffold(registrar.messenger(), "analytis_recorder_bench", PluginMethods())
        }
    }
}

class PluginMethods {
    val records = mutableMapOf<String, MutableList<Int>>()
    val keys = (1..100).map { java.util.UUID.randomUUID().toString() }

    var kotlinTimer: Timer? = null
    var dartTimer: Timer? = null

    init {
        for (key in keys) {
            records[key] = mutableListOf()
        }
    }

    fun startRecording(call: MethodCall, result: Result) {
        kotlinTimer = timer(
            period = (call.arguments as Int).toLong(),
            action = {
                val key = keys[Random().nextInt(100)]
                records[key]?.add(Random().nextInt(100))
            }
        )
    }

    fun stopRecording(call: MethodCall, result: Result) {
        kotlinTimer?.cancel()
        kotlinTimer = null
        dartTimer?.cancel()
        dartTimer = null
    }

    fun getRecordings(call: MethodCall, result: Result) {
        result.success(records)
    }

    fun recordOnListen(id: Int, args: Any?, sink: StreamSink) {
        dartTimer = timer(
            period = (args as Int).toLong(),
            action = {
                val key = keys[Random().nextInt(100)]
                sink.success(listOf(key, Random().nextInt(100)))
            }
        )
    }

    fun recordOnCancel(id: Int, args: Any?) {
        dartTimer?.cancel()
        dartTimer = null
    }
}
