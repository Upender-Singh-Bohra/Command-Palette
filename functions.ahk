#Requires AutoHotkey v2.0

; ----- Utility Functions -----
ToggleMonitorPower() {
    static monitorPower := true
    monitorPower := !monitorPower
    Run(monitorPower ? "nircmd monitor on" : "nircmd monitor off")
}

ResizeWindow(width, height) {
    activeClass := WinGetClass("A")
    ignoreClasses := ["WorkerW", "DV2ControlHost", "RainmeterMeterWindow", "Shell_TrayWnd", "TopLevelWindowForOverflowXamlIsland"]
    for _, class in ignoreClasses {
        if (activeClass = class) {
            return
        }
    }
    WinRestore("A")
    WinMove((A_ScreenWidth / 2) - (width / 2), (A_ScreenHeight / 2) - (height / 2), 1400, 850, "A")
}

SwitchPowerPlan(powerplanGUID, description, sound := "") {
    if RunWait("powercfg /s " powerplanGUID, , "Hide") != 0 {
        MsgBox "Failed to change power plan!"
        return
    }
    if sound {
        SoundPlay(sound)
    }
    TrayTip(description, "Power plan changed", 1)
    Sleep 2500
    TrayTip() ; Clear TrayTip after display duration
}

SwitchPlaybackDevice(devicename) {
    command := "nircmd.exe setdefaultsounddevice `"" devicename . "`" 1"
    Run(command, , "Hide")
    TrayTip("Playback Device Changed", "Switched to: " devicename, 1)
    Sleep 2000
    TrayTip() ; Clear TrayTip after display duration
}

; ----- Application Launchers and Switchers -----
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
    if WinExist(ahkexe.chrome) {
        if WinActive(ahkexe.chrome) {
            WinMinimize(ahkexe.chrome)
            WinActivate ("ahk_class Shell_TrayWnd")
        } else {
            WinActivate(ahkexe.chrome)
        }
    } else {
        Run(chromePath . " --profile-directory=" '"' profile '"')
        WinWait(ahkexe.chrome)
        WinActivate(ahkexe.chrome)
    }
}

OpenLink(url, profile := chromeProfile1) {
    Run(chromePath " --profile-directory=" '"' profile '"' " " url)
    WinWait(ahkexe.chrome)
    WinActivate(ahkexe.chrome)
}

FindOrOpenChromeTab(tabName, url, profile := chromeProfile1) {
    chromeCount := WinGetCount(ahkexe.chrome)
    activeTab := ""
    firstTab := ""

    Loop chromeCount {
        WinActivateBottom(ahkexe.chrome)
        WinWaitActive(ahkexe.chrome)
        firstTab := WinGetTitle("A")
        If InStr(firstTab, tabName)
            return true
        While !(activeTab = firstTab) {
            Send("^{tab}")
            Sleep(50)
            activeTab := WinGetTitle("A")
            If InStr(activeTab, tabName)
                return true
        }
    }

    Run(chromePath " --profile-directory=" '"' profile '"' " " url)
    return false
}

OpenNotionPage(pageTitle, pageID) {
    winID := pageTitle " " ahkexe.notion
    if WinExist(winID) {
        if WinActive(winID) {
            WinMinimize(winID)
        } else {
            WinActivate(winID)
        }
    } else {
        if WinExist(ahkexe.notion) {
            Run("notion://www.notion.so/" . pageID)
            WinWait(ahkexe.notion)
            WinActivate(ahkexe.notion)
        } else {
            Run(notionPath " " "notion://www.notion.so/" pageID)
            WinWait(ahkexe.notion)
            WinActivate(ahkexe.notion)
        }
    }
}

VSCodeInFolder(folderTitle, folderPath) {
    winID := folderTitle " " ahkexe.vscode
    if WinExist(winID) {
        if WinActive(winID) {
            WinMinimize(winID)
        } else {
            WinActivate(winID)
        }
    } else {
        Run('"' vscodePath '"' " " ' "' folderPath '"')
        WinWait(winID)
        WinActivate(winID)
    }
}

FetchActiveExplorerPath() {
    A_Clipboard := ""
    Send "!d"
    Sleep 100
    Send "^c"
    Send "{Esc}"
    if !ClipWait(1, 0) {
        return
    }
}

VscodeInCurrentFolder() {
    DetectHiddenWindows True
    winID := WinGetClass("A")
    if !(winID = "CabinetWClass" or winID = "WorkerW") {
        MsgBox "Explorer is not active", "Warning", 16
        return
    }
    ErrorLevel := 0

    FetchActiveExplorerPath()

    explorerPath := A_Clipboard
    if !(InStr(explorerPath, ":\")) {
        MsgBox("Unable to get the folder path.", "Path Error", 48)
        return
    }
    Run('"' vscodePath '"' " " '"' explorerPath '"')
    if (ErrorLevel) {
        MsgBox ("Failed to launch Visual Studio Code. ErrorLevel: " . ErrorLevel)
    }
}

TerminalInCurrentFolder() {
    DetectHiddenWindows True
    winID := WinGetClass("A")
    if !(winID = "CabinetWClass" or winID = "WorkerW") {
        MsgBox "Explorer is not active", "Warning", 16
        return
    }
    ErrorLevel := 0

    FetchActiveExplorerPath()

    explorerPath := A_Clipboard
    if !(InStr(explorerPath, ":\")) {
        MsgBox("Unable to get the folder path.", "Path Error", 48)
        return
    }

    if (explorerPath ~= "^[A-Z]:\\$") {
        explorerPath := explorerPath . " "
        Run("wt.exe -d " explorerPath)
    }
    else {
        Run("wt.exe -d " '"' explorerPath '"')
    }
    if (ErrorLevel) {
        MsgBox ("Failed to launch Terminal. ErrorLevel: " . ErrorLevel)
    }
}

; ----- Window Management -----
CloseActiveWindow() {
    try {
        activeClass := WinGetClass("A")
        ignoreClasses := ["WorkerW", "DV2ControlHost", "RainmeterMeterWindow"]
        for _, class in ignoreClasses {
            if (activeClass = class) {
                MsgBox("The active window belongs to a protected class (" class "). Closing it is restricted.", "Warning", 48)
                return
            }
        }

        activeID := WinGetID("A")
        WinClose("ahk_id " activeID)
    }
    catch {
        ; Emtpy catch block to ignore errors from WinGetID("A")
    }
}

KillActiveProgram() {
    PID := WinGetPID("A")
    activeClass := WinGetClass("A")
    excludedClasses := "^(WorkerW|DV2ControlHost|CabinetWClass|Shell_TrayWnd|TopLevelWindowForOverflowXamlIsland|Windows.UI.Core.CoreWindow|RainmeterMeterWindow)$"
    if (RegExMatch(activeClass, excludedClasses)) {
        MsgBox("This window cannot be terminated as it is a critical system component.", "Warning", 48)
        return
    }
    ProcessClose(PID)
}

; ----- System Functions -----
FastStartupShutdown() {
    response := MsgBox("Do you want to shutdown windows?", "Shutdown Confirmation", 4 | 32)
    if response = "Yes"
    {
        DllCall("Ntdll\RtlAdjustPrivilege", "UInt", 19, "UChar", true, "UChar", false, "IntP", 0)
        DllCall("User32\ExitWindowsEx", "UInt", 0x00400000 | 0x00000001, "UInt", 1) ; Graceful Shutdown (without EWX_FORCE 0x00000004)
    }
}

SystemSleep() {
    response := MsgBox("Are you sure?", "Sleep Confirmation", 4 | 32)
    if response = "Yes"
    {
        DllCall("PowrProf\SetSuspendState", "UInt", 0, "UInt", 0, "UInt", 0)
    }
}