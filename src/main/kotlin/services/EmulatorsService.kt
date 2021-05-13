package services

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.ExperimentalCoroutinesApi
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.launch
import models.emulator.Emulator
import models.emulator.EmulatorParameters
import util.ErrorHelper
import util.ExecuteHelper
import util.JsonHelper
import java.util.prefs.Preferences

@ExperimentalCoroutinesApi
object EmulatorsService {
    private const val KEY_EMULATOR = "emulator"
    private const val KEY_PARAMETERS = "parameters"

    private val preferences = Preferences.userRoot().node("emulators")
    private val emulatorParametersAdapter = JsonHelper.moshi.adapter(EmulatorParameters::class.java)

    private val mutableEmulators: MutableStateFlow<List<Emulator>> = MutableStateFlow(emptyList())

    val emulators: StateFlow<List<Emulator>>
        get() = mutableEmulators

    init {
        loadEmulators()
    }

    fun loadEmulators() {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val emulators = ExecuteHelper.execute(SettingsService.emulatorPath, listOf("-list-avds"))
                    .split("\n")
                    .filter { line -> line.isNotEmpty() }
                    .map { name -> Emulator(name, getEmulatorParameters(name)) }
                    .sortedBy { emulator -> emulator.name }
                mutableEmulators.value = emulators
            } catch (t: Throwable) {
                mutableEmulators.value = emptyList()
                ErrorHelper.handleThrowable(t)
            }
        }
    }

    fun startEmulator(emulator: Emulator) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val arguments = mutableListOf("-avd", emulator.name)
                if (emulator.parameters.noSnapshotLoad) {
                    arguments.add("-no-snapshot-load")
                }
                if (emulator.parameters.writableSystem) {
                    arguments.add("-writable-system")
                }
                var bootCompleted = false
                ExecuteHelper.executeAsync(
                    command = SettingsService.emulatorPath,
                    arguments = arguments,
                    onData = { data ->
                        if (data.contains("boot completed")) {
                            bootCompleted = true
                            DevicesService.loadDevices()
                        }
                    },
                    onCompleted = {
                        if (!bootCompleted) {
                            DevicesService.loadDevices()
                            ErrorHelper.handleThrowable(Throwable("Failed to start emulator"))
                        }
                    },
                    onError = { message ->
                        DevicesService.loadDevices()
                        if (message.isEmpty()) {
                            ErrorHelper.handleThrowable(Throwable("Failed to start emulator"))
                        } else {
                            ErrorHelper.handleThrowable(Throwable(message))
                        }
                    }
                )
            } catch (t: Throwable) {
                ErrorHelper.handleThrowable(t)
                DevicesService.loadDevices()
            }
        }
    }

    fun saveEmulatorParameters(emulator: Emulator) {
        val json = emulatorParametersAdapter.toJson(emulator.parameters)
        preferences.put("$KEY_EMULATOR.${emulator.name}.$KEY_PARAMETERS", json)
    }

    private fun getEmulatorParameters(name: String): EmulatorParameters {
        val json = preferences.get("$KEY_EMULATOR.$name.$KEY_PARAMETERS", "{}")
        return emulatorParametersAdapter.fromJson(json) ?: EmulatorParameters()
    }
}