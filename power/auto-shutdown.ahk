#Requires AutoHotkey v2.0
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir

if A_LineFile = A_ScriptFullPath && !A_IsCompiled
{
    autoShutGui := Constructor()
    autoShutGui.Show("w148 h239")
}

Constructor()
{
    A_IconTip := "Command Palette: Auto Shutdown"
    TraySetIcon("assets\auto-shutdown.ico")

    Tray := A_TrayMenu
    Tray.Delete()
    Tray.Add("Abort", Abort)

    autoShutGui := Gui()
    autoShutGui.Title := "Auto Shutdown"
    autoShutGui.Opt("-MinimizeBox -MaximizeBox")
    autoShutGui.BackColor := "f9f9f9"
    autoShutGui.OnEvent('Close', (*) => ExitApp())
    autoShutGui.OnEvent('Escape', (*) => ExitApp())
    bgcolor := "f9f9f9"

    autoShutGui.SetFont("s10")
    autoShutGui.Add("Text", "x13 y8 w120 h23 +0x200", "Set Timer (Minutes):")
    autoShutGui.SetFont("s8")
    edit1 := autoShutGui.Add("Edit", "x29 y40 w90 h21 +Number +Center")
    autoShutGui.SetFont("s8")
    notifyCB := autoShutGui.Add("CheckBox", "x80 y64 w45 h23 +Checked", "Notify")
    autoShutGui.SetFont("s8")
    forceCB := autoShutGui.Add("CheckBox", "x24 y64 w45 h23", "Force")
    autoShutGui.SetFont("s8")
    sleepButton := autoShutGui.Add("Button", "x16 y96 w120 h23", "Sleep")
    sleepButton.Opt("Background" bgColor)
    autoShutGui.SetFont("s8")
    shutdownButton := autoShutGui.Add("Button", "x16 y120 w120 h23", "Shutdown")
    shutdownButton.Opt("Background" bgcolor)
    autoShutGui.SetFont("s8")
    fullshutdownButton := autoShutGui.Add("Button", "x16 y144 w120 h23", "Full Shutdown")
    fullshutdownButton.Opt("Background" bgcolor)
    autoShutGui.SetFont("s8")
    restartButton := autoShutGui.Add("Button", "x16 y168 w120 h23", "Restart")
    restartButton.Opt("Background" bgcolor)
    autoShutGui.Add("Text", "x16 y200 w120 h23 +0x10")
    autoShutGui.SetFont("s8")
    cancelButton := autoShutGui.Add("Button", "x16 y208 w120 h23 +Default", "Cancel")
    cancelButton.Opt("Background" bgcolor)

    forceCB.OnEvent("Click", ForceCheckBox)
    notifyCB.OnEvent("Click", NotifyCheckBox)
    sleepButton.OnEvent("Click", SystemSleep)
    shutdownButton.OnEvent("Click", FastStartupShutdown)
    fullshutdownButton.OnEvent("Click", FullShutdown)
    restartButton.OnEvent("Click", SystemRestart)
    cancelButton.OnEvent("Click", CancelAutoShutdown)

    ShutdownHandler(actionType, shutdownState) {
        time := edit1.Value
        if time = 0 {
            MsgBox("Please enter a valid time greater than 0.", "Invalid Time", 48)
            edit1.Value := ""
            edit1.Focus()
            return
        }
        if !(time = "") AND (notifyCB.Value) {
            alertTimeDelta := 2 ; minutes
            if (time = alertTimeDelta) {
                Run('python "email-notifier.py"' " " '"' actionType '"' " " alertTimeDelta, , "Hide")
            }
            else if (time > alertTimeDelta) {
                notificationTime := Abs((time * 60 - (alertTimeDelta * 60)) * 1000)
                ; Send notification email 2 minutes before action
                SetTimer(() => Run('python "email-notifier.py"' " " '"' actionType '"' " " alertTimeDelta, , "Hide"), -notificationTime)
            }
            autoShutGui.Destroy()
            shutdownTime := time * 60 * 1000
            SetTimer(shutdownState, -shutdownTime)
        }
    }

    SystemSleep(*) {
        ShutdownHandler("Sleep", () => DllCall("PowrProf\SetSuspendState", "UInt", 0, "UInt", 0, "UInt", 0))
    }

    FastStartupShutdown(*) {
        if (forceCB.Value) {
            ShutdownHandler("FastStartup Shutdown", () =>
                DllCall("Ntdll\RtlAdjustPrivilege", "UInt", 19, "UChar", true, "UChar", false, "IntP", 0)
                DllCall("User32\ExitWindowsEx", "UInt", 0x00400000 | 0x00000001 | 0x00000004, "UInt", 1))
        }
        else {
            ShutdownHandler("FastStartup Shutdown", () =>
                DllCall("Ntdll\RtlAdjustPrivilege", "UInt", 19, "UChar", true, "UChar", false, "IntP", 0)
                DllCall("User32\ExitWindowsEx", "UInt", 0x00400000 | 0x00000001, "UInt", 1))
        }
    }

    FullShutdown(*) {
        local forceFlag := forceCB.Value
        ShutdownHandler("Full Shutdown", () => Shutdown(forceFlag ? 5 : 1))
    }

    SystemRestart(*) {
        local forceFlag := forceCB.Value
        ShutdownHandler("Restart", () => Shutdown(forceFlag ? 6 : 2))
    }

    CancelAutoShutdown(*) {
        ExitApp
    }

    NotifyCheckBox(*) {
        ToolTip("Sends an email notification 2 minutes before the scheduled action.`n"
            . "Adjust email settings in the .env file.")
        SetTimer () => ToolTip(), -3000
    }

    ForceCheckBox(*) {
        MouseGetPos &xpos, &ypos
        ToolTip("Forces shutdown, closing all open apps and bypassing prompts.`n"
            . "Does not affect sleep.", xpos - 360, ypos - 40)
        SetTimer () => ToolTip(), -3000

        sleepButton.Enabled := forceCB.Value ? false : true
    }

    ; Tray Menu option
    Abort(*) {
        ExitApp
    }

    return autoShutGui
}