#Requires AutoHotkey v2.0

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
    explorerPath := A_Clipboard
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

    explorerPath := A_Clipboard
    if (explorerPath ~= "^[A-Z]:\\$") {
        explorerPath := explorerPath . " "
        Run("wt.exe -d " explorerPath)
    }
    else {
        Run("wt.exe -d " '"' explorerPath '"')
    }
    if (ErrorLevel) {
        MsgBox ("Failed to launch Visual Studio Code. ErrorLevel: " . ErrorLevel)
    }
}

CloseActiveWindow() {
    try {
        activeClass := WinGetClass("A")
        ignoreClasses := ["WorkerW", "DV2ControlHost", "RainmeterMeterWindow"]
        for _, class in ignoreClasses {
            if (activeClass = class) {
                MsgBox("The active window is the desktop or Start menu. Exiting script.", "Warning", 64)
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