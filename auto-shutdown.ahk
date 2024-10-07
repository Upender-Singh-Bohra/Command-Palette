#Requires AutoHotkey v2.0
#SingleInstance Force

if A_LineFile = A_ScriptFullPath && !A_IsCompiled
{
    autoShutGui := Constructor()
    autoShutGui.Show("w146 h240")
}

Constructor()
{
    A_IconTip := "Command Palette: Auto Shutdown"
    TraySetIcon(A_ScriptDir . "\assets\auto-shutdown.ico")

    Tray := A_TrayMenu
    Tray.Delete()
    Tray.Add("Abort", Abort)

    autoShutGui := Gui()
    autoShutGui.Title := "Auto Shutdown"
    autoShutGui.Opt("-MinimizeBox -MaximizeBox")
    autoShutGui.OnEvent('Close', (*) => ExitApp())
    autoShutGui.OnEvent('Escape', (*) => ExitApp())
    edit1 := autoShutGui.Add("Edit", "x29 y40 w90 h21 +Number +Center")
    autoShutGui.SetFont("s10")
    autoShutGui.Add("Text", "x13 y8 w120 h24 +0x200 +Center", "Set Timer (Minutes):")
    autoShutGui.SetFont("s8")
    sleepButton := autoShutGui.Add("Button", "x13 y72 w120 h24", "Sleep")
    autoShutGui.SetFont("s8")
    shutdownfsButton := autoShutGui.Add("Button", "x13 y104 w120 h24", "Shutdown (FS)")
    autoShutGui.SetFont("s8")
    shutdownButton := autoShutGui.Add("Button", "x13 y136 w120 h24", "Shutdown")
    autoShutGui.SetFont("s8")
    restartButton := autoShutGui.Add("Button", "x13 y168 w120 h24", "Restart")
    autoShutGui.SetFont("s8")
    cancelButton := autoShutGui.Add("Button", "x13 y208 w120 h24 +Default", "Cancel")
    autoShutGui.Add("Text", "x13 y200 w120 h24 +0x10")
    sleepButton.OnEvent("Click", SystemSleep)
    shutdownfsButton.OnEvent("Click", FastStartupShutdown)
    shutdownButton.OnEvent("Click", FullShutdown)
    restartButton.OnEvent("Click", SystemRestart)
    cancelButton.OnEvent("Click", CancelAutoShutdown)

    delay(timeInMinutes) {
        timeInMS := (timeInMinutes * 60) * 1000
        Sleep(timeInMS)
    }

    SystemSleep(*) {
        time := autoShutGui["edit1"].Value
        if !(time = "") {
            autoShutGui.Destroy()
            delay(time)
            DllCall("PowrProf\SetSuspendState", "UInt", 0, "UInt", 0, "UInt", 0)
        }
    }

    FullShutdown(*) {
        time := autoShutGui["edit1"].Value
        if !(time = "") {
            autoShutGui.Destroy()
            delay(time)
            Shutdown 1
        }
    }

    FastStartupShutdown(*) {
        time := autoShutGui["edit1"].Value
        if !(time = "") {
            autoShutGui.Destroy()
            delay(time)
            DllCall("Ntdll\RtlAdjustPrivilege", "UInt", 19, "UChar", true, "UChar", false, "IntP", 0)
            DllCall("User32\ExitWindowsEx", "UInt", 0x00400000 | 0x00000001, "UInt", 1)
        }

    }

    SystemRestart(*) {
        time := autoShutGui["edit1"].Value
        if !(time = "") {
            autoShutGui.Destroy()
            delay(time)
            Shutdown 2
        }
    }

    CancelAutoShutdown(*) {
        ExitApp
    }

    ; Tray Menu option
    Abort(*) {
        ExitApp
    }

    return autoShutGui
}