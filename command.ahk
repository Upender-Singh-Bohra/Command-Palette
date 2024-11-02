#Requires AutoHotkey v2.0
#WinActivateForce
#SingleInstance Force

#Include "functions.ahk"
#Include "tray-menu-settings.ahk"
#Include "variables.ahk"

Persistent
SendMode ("Input")
SetTitleMatchMode(2)
SetWorkingDir A_InitialWorkingDir

#HotIf WinExist("ahk_class Qt51511QWindowIcon")
::fff::nothingtolookhere:)
#HotIf

Rctrl & f13:: {
    CloseActiveWindow()
    return
}

Rctrl & f14:: {
    KillActiveProgram()
    KeyWait ("Rctrl")
    KeyWait ("f14")
    return
}

Rctrl & f15:: {
    Send "{Volume_Up}"
    SoundSetVolume 18
    KeyWait ("Rctrl")
    KeyWait ("f15")
    return
}

Rctrl & f16:: {
    Run('python "sound\mic-mute\mic_mute.py"', , "Hide")
    return
}

Rctrl & f17:: {
    SwitchPlaybackDevice(playbackDevices.speaker)
    return
}

Rctrl & f18:: {
    SwitchPlaybackDevice(playbackDevices.headphones)
    return
}

Rctrl & f19:: {
    LaunchOrToggleProgram(vscodeTitle, ahkexe.vscode, vscodePath)
    return
}

Rctrl & f20:: {
    ResizeWindow(1400, 850)
    return
}

Rctrl & f23:: {
    VscodeInCurrentFolder()
    return
}

Rctrl & f24:: {
    LaunchOrToggleProgram(algoTitle, ahkexe.explorer, algoPath)
    return
}

Ralt & f13:: {
    VSCodeInFolder(webdevTitle, webdevPath)
    return
}

Ralt & f15:: {
    LaunchOrToggleProgram(projectsTitle, ahkexe.explorer, projectsPath)
    return
}

Ralt & f16:: {
    VSCodeInFolder(projectsTitle, projectsPath)
    KeyWait ("Ralt")
    KeyWait ("f14")
    return
}

Ralt & f17:: {
    LaunchOrToggleProgram(terminalTitle, ahkexe.terminal, terminalPath, , false)
}

Rctrl & f21:: { ; (Rctrl & f21) and (Rctrl & f22) were missed before
    TerminalInCurrentFolder()
    KeyWait("Rctrl")
    KeyWait("f21")
    return
}

Ralt & f18:: {
    LaunchOrToggleProgram(notionTitle, ahkexe.notion, notionPath)
    return
}

Ralt & f19:: {
    OpenNotionPage(todoPageTitle, todoPageID)
    return
}

Ralt & f20:: {
    OpenNotionPage(deadlinesPageTitle, deadlinesPageID)
    return
}

Ralt & f21:: {
    OpenNotionPage(leetcodePageTitle, leetcodePageID)
    return
}

Ralt & f22:: {
    OpenNotionPage(notesPageTitle, notesPageID)
    return
}

Ralt & f23:: {
    OpenNotionPage(lifeforcePageTitle, lifeforcePageID)
    return
}

Ralt & f24:: {
    LaunchOrToggleProgram(keepassTitle, ahkexe.keepass, keepassPath, , false)
    return
}

Rshift & f13:: {
    LaunchProgram(ahkexe.photoshop, photoshopPath)
    return
}

#HotIf WinExist("Sleep Confirmation ahk_exe AutoHotkey64.exe")
OR WinExist("Shutdown Confirmation ahk_exe AutoHotkey64.exe")
OR WinExist("Full-Shutdown Confirmation ahk_exe python.exe")
OR WinExist("Restart Confirmation ahk_exe python.exe")
Rshift & f13:: {
    Send "{Enter}"
}
#HotIf

Rshift & f14:: {
    OpenChrome(chromeProfile1)
    return
}

Rshift & f15:: {
    LaunchOrToggleProgram(downloads1Title, ahkexe.explorer, downloads1Path)
    return
}

Rshift & f16:: {
    LaunchOrToggleProgram(downloads2Title, ahkexe.explorer, downloads2Path)
    return
}

; ----- Primary URLs -----

Rshift & f17:: {
    FindOrOpenChromeTab("<firstmail@gmail.com - gmail>", "mail.google.com/mail/u/0/#inbox")
    return
}

Rshift & f18:: {
    FindOrOpenChromeTab("<secondmail@gmail.com - gmail>", "mail.google.com/mail/u/1/#inbox")
    return
}

Rshift & f19:: {
    FindOrOpenChromeTab("whatsapp", "web.whatsapp.com")
    return
}

Rshift & f20:: {
    FindOrOpenChromeTab("ChatGPT", "chatgpt.com")
    return
}

Rshift & f21:: {
    OpenLink("github.com")
    return
}

; ----- Other URLs -----

Rshift & f22:: {
    FindOrOpenChromeTab("YouTube - Google Chrome", "youtube.com")
    return
}

; ----- Optional Hotkeys Placeholder -----

; Rshift & f23:: { }

; Rshift & f24:: { }

; Lctrl & f13:: { }

; Lctrl & f14:: { }

; Lctrl & f15:: { }

Lctrl & f17:: {
    SetWorkingDir(A_ScriptDir "\obs")
    Run("recording-desktop.vbs")
    SetWorkingDir A_InitialWorkingDir
    return
}

Lctrl & f18:: {
    SetWorkingDir(A_ScriptDir "\obs")
    Run("screen-webcam.vbs")
    SetWorkingDir A_InitialWorkingDir
    return
}

Lctrl & f19:: {
    SetWorkingDir(A_ScriptDir "\obs")
    Run("webcam.vbs")
    SetWorkingDir A_InitialWorkingDir
    return
}

Lctrl & f20:: {
    SwitchPowerPlan(highperformance.guid, "High Performance Plan (Active)", highperformance.soundPath)
    return
}

Lctrl & f21:: {
    SwitchPowerPlan(highperformanceNoSleep.guid, "High Performance + No Sleep (Active)", highperformanceNoSleep.soundPath)
    return
}

Lctrl & f22:: {
    SwitchPowerPlan(powersaver.guid, "Power Saver Plan (Active)", powersaver.soundPath)
    return
}

Lctrl & f23:: {
    ToggleMonitorPower()
    return
}

Lctrl & f24:: {
    FastStartupShutdown()
    return
}

Lalt & f13:: {
    Run('python "power\full_shutdown.py"', , "Hide")
    WinWait("Full-Shutdown Confirmation ahk_exe python.exe")
    WinActivate("Full-Shutdown Confirmation ahk_exe python.exe")
    KeyWait("Lalt")
    KeyWait("f13")
    return
}

Lalt & f14:: {
    Run('python "power\restart.py"', , "Hide")
    WinWait("Restart Confirmation ahk_exe python.exe")
    WinActivate("Restart Confirmation ahk_exe python.exe")
    return
}

Lalt & f15:: {
    SystemSleep()
    return
}

Lalt & f16:: {
    DetectHiddenWindows True
    if !WinExist("auto-shutdown.ahk ahk_exe AutoHotkey64.exe") {
        Run("power\auto-shutdown.ahk")
    } else {
        MsgBox("Auto Shutdown is already running!", "Warning", 0 | 48)
    }
    DetectHiddenWindows False
    KeyWait("Lalt")
    KeyWait("f16")
    return
}

Lalt & f17:: {
    LaunchOrToggleProgram(obsTitle, ahkexe.obs, obsPath, "C:\Program Files (others)\obs-studio\bin\64bit\", false)
    LaunchProgram(ahkexe.streamerbot, streamerbotPath, , false, true)
    return
}

#HotIf WinExist(ahkexe.obs)
Lalt & f17:: {
    LaunchOrToggleProgram(obsTitle, ahkexe.obs, obsPath, "C:\Program Files (others)\obs-studio\bin\64bit\", false)
    return
}
#HotIf

Lalt & f18:: {
    try {
        WinClose(ahkexe.obs)
        ProcessClose("Streamer.bot.exe")
    }
    catch {

    }
    return
}

; ----- Script Management -----

Lalt & f19:: Reload

#SuspendExempt
Lalt & f20:: {
    SuspendScript
}
#SuspendExempt False