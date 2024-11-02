#Requires AutoHotkey v2.0

A_IconTip := "Command Palette"
TraySetIcon(A_ScriptDir . "\assets\command.ico")

Tray := A_TrayMenu
Tray.Delete()
Tray.Add("Program Directory", Directory)
Tray.Default := "Program Directory"
Tray.Add()
Tray.Add("Schedule Shutdown", AutoShutdown)
Tray.Add("Windows Spy", WindowsSpy)
Tray.Add()
Tray.Add("Reload", ReloadScript)
Tray.Add("Suspend Keys", SuspendScript)
Tray.Add("Pause Program", PauseScript)
Tray.Add()
Tray.Add("Exit", Exit)

; https://www.autohotkey.com/docs/v2/lib/Menu.htm
Directory(*) {
    Run(A_ScriptDir)
}

AutoShutdown(*) {
    DetectHiddenWindows True
    if !WinExist("auto-shutdown.ahk") {
        Run(A_ScriptDir . "\power\auto-shutdown.ahk")
    } else {
        MsgBox("Auto Shutdown is already running!", "Warning", 0 | 64)
    }
    DetectHiddenWindows False
}

WindowsSpy(*) {
    Run("C:\Program Files\AutoHotkey\WindowSpy.ahk")
}

ReloadScript(*) {
    Reload
}

SuspendScript(*) {
    Tray.ToggleCheck("Suspend Keys")
    Suspend
}

PauseScript(*) {
    Tray.ToggleCheck("Pause Script")
    Pause -1
}

Exit(*) {
    ExitApp
}