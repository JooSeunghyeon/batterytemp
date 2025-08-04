package com.juseunghyeon.batterytemp

import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.juseunghyeon.batterytemp/temperature"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "getBatteryTemperature" -> {
                    val temp = getBatteryTemperature()
                    result.success(temp)
                }
                "getBatteryInfo" -> {
                    val info = getBatteryInfo()
                    result.success(info)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun getBatteryTemperature(): Double {
        val intent = applicationContext.registerReceiver(
            null,
            IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        )
        val temp = intent?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1) ?: -1
        return temp / 10.0
    }

    private fun getBatteryInfo(): Map<String, Any> {
        val intent = applicationContext.registerReceiver(
            null,
            IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        )
        
        val temperature = intent?.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1) ?: -1
        val level = intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
        val scale = intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
        val voltage = intent?.getIntExtra(BatteryManager.EXTRA_VOLTAGE, -1) ?: -1
        val status = intent?.getIntExtra(BatteryManager.EXTRA_STATUS, -1) ?: -1
        val health = intent?.getIntExtra(BatteryManager.EXTRA_HEALTH, -1) ?: -1
        val plugged = intent?.getIntExtra(BatteryManager.EXTRA_PLUGGED, -1) ?: -1
        
        val batteryLevel = if (level != -1 && scale != -1) {
            (level * 100 / scale.toFloat()).toInt()
        } else {
            -1
        }
        
        val statusText = when (status) {
            BatteryManager.BATTERY_STATUS_CHARGING -> "충전중"
            BatteryManager.BATTERY_STATUS_DISCHARGING -> "방전중"
            BatteryManager.BATTERY_STATUS_FULL -> "완전충전"
            BatteryManager.BATTERY_STATUS_NOT_CHARGING -> "충전안함"
            BatteryManager.BATTERY_STATUS_UNKNOWN -> "알수없음"
            else -> "상태불명"
        }
        
        val healthText = when (health) {
            BatteryManager.BATTERY_HEALTH_GOOD -> "양호"
            BatteryManager.BATTERY_HEALTH_OVERHEAT -> "과열"
            BatteryManager.BATTERY_HEALTH_DEAD -> "손상"
            BatteryManager.BATTERY_HEALTH_OVER_VOLTAGE -> "과전압"
            BatteryManager.BATTERY_HEALTH_UNSPECIFIED_FAILURE -> "오류"
            BatteryManager.BATTERY_HEALTH_COLD -> "저온"
            else -> "알수없음"
        }
        
        val pluggedText = when (plugged) {
            BatteryManager.BATTERY_PLUGGED_AC -> "AC어댑터"
            BatteryManager.BATTERY_PLUGGED_USB -> "USB"
            BatteryManager.BATTERY_PLUGGED_WIRELESS -> "무선충전"
            0 -> "연결안됨"
            else -> "기타"
        }
        
        return mapOf(
            "temperature" to (temperature / 10.0),
            "level" to batteryLevel,
            "voltage" to (voltage / 1000.0), // mV to V
            "status" to statusText,
            "health" to healthText,
            "plugged" to pluggedText,
            "timestamp" to System.currentTimeMillis()
        )
    }
}
