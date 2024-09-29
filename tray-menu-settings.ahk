#Requires AutoHotkey v2.0

A_IconTip := "Command Palette"
TraySetIcon(A_ScriptDir . "\tray-icon.ico")

Tray := A_TrayMenu
Tray.Delete()
Tray.Add("Program Directory", Directory)
Tray.Default := "Program Directory"
Tray.Add()
Tray.Add("Windows Spy", WindowsSpy)
Tray.Add("Reload Script", ReloadScript)
Tray.Add()
Tray.Add("Suspend Script", SuspendScript)
Tray.Add("Pause Script", PauseScript)
Tray.Add("Exit", Exit)

; https://www.autohotkey.com/docs/v2/lib/Menu.htm
Directory(*) {
    Run(A_ScriptDir)
}

WindowsSpy(*) {
    Run("C:\Program Files\AutoHotkey\WindowSpy.ahk")
}

ReloadScript(*) {
    Reload
}

SuspendScript(*) {
    Tray.ToggleCheck("Suspend Script")
    Suspend
}

PauseScript(*) {
    Tray.ToggleCheck("Pause Script")
    Pause
}

Exit(*) {
    ExitApp
}