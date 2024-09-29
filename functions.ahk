#Requires AutoHotkey v2.0

ResizeWindow(width, height) {
    active_class := WinGetClass("A")
    ignore_classes := ["WorkerW", "DV2ControlHost", "RainmeterMeterWindow", "Shell_TrayWnd", "TopLevelWindowForOverflowXamlIsland"]
    for _, class in ignore_classes {
        if (active_class = class) {
            return
        }
    }
    WinRestore("A")
    WinMove((A_ScreenWidth / 2) - (width / 2), (A_ScreenHeight / 2) - (height / 2), 1400, 850, "A")
}


LaunchOrToggleProgram(programTitle, ahkexe, programPath, workingDir := "", maximize := true, minimize := false) {
    winID := programTitle " " ahkexe
    if WinExist(winID) {
        if WinActive(winID) {
            WinMinimize(winID)
            WinActivate("ahk_class Shell_TrayWnd")
        } else {
            WinActivate(winID)
        }
    } else {
        workingDIR := (workingDir != "") ? workingDir : ""
        if maximize {
            Run(programPath, workingDIR, "Max")
            WinWait(winID)
            WinActivate(winID)
        } else if minimize {
            Run(programPath, workingDIR, "Min")
        } else {
            Run(programPath, workingDIR)
            WinWait(winID)
            WinActivate(winID)
        }
    }
}

LaunchProgram(ahkexe, programPath, workingDir := "", maximize := true, minimize := false) {
    workingDIR := (workingDir != "") ? workingDir : ""
    if maximize {
        Run(programPath, workingDIR, "Max")
    }
    else if minimize {
        Run(programPath, workingDIR, "Min")
    }
    else {
        Run(programPath, workingDIR)
    }
    WinWait(ahkexe)
    WinActivate(ahkexe)
}

OpenChrome(profile) {
    if WinExist(ahkexe_chrome) {
        if WinActive(ahkexe_chrome) {
            WinMinimize(ahkexe_chrome)
            WinActivate ("ahk_class Shell_TrayWnd")
        } else {
            WinActivate(ahkexe_chrome)
        }
    } else {
        Run(path_chrome . " --profile-directory=" '"' profile '"')
        WinWait(ahkexe_chrome)
        WinActivate(ahkexe_chrome)
    }
}

OpenLink(wintitle, url, profile := profile1) {
    Run(path_chrome " --profile-directory=" '"' profile '"' " " url)
    WinWait(ahkexe_chrome)
    WinActivate(ahkexe_chrome)
}

OpenNotionPage(pageTitle, pageID) {
    winID := pageTitle " " ahkexe_notion
    if WinExist(winID) {
        if WinActive(winID) {
            WinMinimize(winID)
        } else {
            WinActivate(winID)
        }
    } else {
        if WinExist(ahkexe_notion) {
            Run("notion://www.notion.so/" . pageID)
            WinWait(ahkexe_notion)
            WinActivate(ahkexe_notion)
        } else {
            Run(path_notion " " "notion://www.notion.so/" pageID)
            WinWait(ahkexe_notion)
            WinActivate(ahkexe_notion)
        }
    }
}

VSCodeInFolder(foldertitle, folder) {
    winID := foldertitle " " ahkexe_vscode
    if WinExist(winID) {
        if WinActive(winID) {
            WinMinimize(winID)
        } else {
            WinActivate(winID)
        }
    } else {
        Run('"' path_vscode '"' " " ' "' folder '"')
        WinWait(winID)
        WinActivate(winID)
    }
}

VscodeInCurrentFolder() {
    DetectHiddenWindows True
    winID := WinGetClass("A")
    if !(winID = "CabinetWClass" or winID = "WorkerW") {
        MsgBox "Explorer is not active", "Warning", 16
        Return
    }
    A_Clipboard := ""
    ErrorLevel := 0

    Send "!d"
    Sleep 100
    Send "^c"

    if !ClipWait(1, 0) {
        ; MsgBox "Can't fetch path for this directory", "Warning", 64
        Return
    }
    explorer_path := A_Clipboard
    Run('"' path_vscode '"' " " '"' explorer_path '"')
    if (ErrorLevel) {
        MsgBox ("Failed to launch Visual Studio Code. ErrorLevel: " . ErrorLevel)
    }
}

TerminalInCurrentFolder() {
    DetectHiddenWindows True
    winID := WinGetClass("A")
    if !(winID = "CabinetWClass" or winID = "WorkerW") {
        MsgBox "Explorer is not active", "Warning", 16
        Return
    }
    A_Clipboard := ""
    ErrorLevel := 0

    Send "!d"
    Sleep 100
    Send "^c"

    if !ClipWait(1, 0) {
        ; MsgBox "Can't fetch path for this directory", "Warning", 64
        Return
    }

    explorer_path := A_Clipboard
    if (explorer_path ~= "^[A-Z]:\\$") {
        explorer_path := explorer_path . " "
        Run("wt.exe -d " explorer_path)
    }
    else {
        Run("wt.exe -d " '"' explorer_path '"')
    }
    if (ErrorLevel) {
        MsgBox ("Failed to launch Visual Studio Code. ErrorLevel: " . ErrorLevel)
    }
}

CloseActiveWindow() {
    try {
        active_class := WinGetClass("A")
        ignore_classes := ["WorkerW", "DV2ControlHost", "RainmeterMeterWindow"]
        for _, class in ignore_classes {
            if (active_class = class) {
                MsgBox("The active window is the desktop or Start menu. Exiting script.", "Warning", 64)
                return
            }
        }

        active_id := WinGetID("A")
        WinClose("ahk_id " active_id)
    }
    catch {
        ; Emtpy catch block to ignore errors from WinGetID("A")
    }
}

KillActiveProgram() {
    PID := WinGetPID("A")
    active_class := WinGetClass("A")
    excluded_classes := "^(WorkerW|DV2ControlHost|CabinetWClass|Shell_TrayWnd|TopLevelWindowForOverflowXamlIsland|Windows.UI.Core.CoreWindow|RainmeterMeterWindow)$"
    if (RegExMatch(active_class, excluded_classes)) {
        MsgBox("The active window can not be terminated", "Warning", 64)
        return
    }
    ProcessClose(PID)
}

SwtichPowerPlan(powerplanGUID, description, sound := "") {
    if RunWait("powercfg /s " powerplanGUID, , "Hide") != 0 {
        MsgBox "Failed to change power plan!"
        Return
    }
    if sound {
        SoundPlay(sound)
    }
    TrayTip(description, "Power plan changed", 1)
    Sleep 2500
    TrayTip()
}

SwitchPlaybackDevice(devicename) {
    command := "nircmd.exe setdefaultsounddevice `"" devicename . "`" 1"
    RunWait(command, , "Hide")
    TrayTip("Playback Device Changed", "Switched to: " devicename, 1)
    Sleep 2000
    TrayTip()
}

SystemShutdown() {
    result := MsgBox("Are you sure?", "Shutdown Confirmation", 4 | 48)
    if result = "Yes"
    {
        DllCall("Ntdll\RtlAdjustPrivilege", "UInt", 19, "UChar", true, "UChar", false, "IntP", 0)
        DllCall("User32\ExitWindowsEx", "UInt", 0x00400000 | 0x00000001, "UInt", 1)
    }
}

SystemSleep() {
    result := MsgBox("Are you sure?", "Sleep Confirmation", 4 | 48)
    if result = "Yes"
    {
        DllCall("PowrProf\SetSuspendState", "UInt", 0, "UInt", 0, "UInt", 0)
    }
}