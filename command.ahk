#Requires AutoHotkey v2.0+
#Include variables.ahk
#Include functions.ahk
#Include tray-menu-settings.ahk

#WinActivateForce
SendMode ("Input")
SetTitleMatchMode(2)
#SingleInstance Force
SetWorkingDir A_InitialWorkingDir


#HotIf WinExist("ahk_class Qt51511QWindowIcon")
::fff::nothingtolookhere:)
#HotIf

Rctrl & f13:: {
    CloseActiveWindow()
    Return
}

Rctrl & f14:: {
    KillActiveProgram()
    KeyWait ("Rctrl")
    KeyWait ("f14")
    Return
}

Rctrl & f15:: {
    Send "{Volume_Up}"
    SoundSetVolume 18
    KeyWait ("Rctrl")
    KeyWait ("f15")
    Return
}

Rctrl & f16:: {
    Run("sound\mic-mute\mic_mute.exe")
    Return
}

Rctrl & f17:: {
    SwitchPlaybackDevice(playbackDevices.speaker)
    Return
}

Rctrl & f18:: {
    SwitchPlaybackDevice(playbackDevices.headphones)
    Return
}

Rctrl & f19:: {
    LaunchOrToggleProgram(vscodeTitle, ahkexe.vscode, vscodePath)
    Return
}

Rctrl & f20:: {
    ResizeWindow(1400, 850)
    Return
}

Rctrl & f23:: {
    VscodeInCurrentFolder()
    Return
}

Rctrl & f24:: {
    LaunchOrToggleProgram(algoTitle, ahkexe.explorer, algoPath)
    Return
}

Ralt & f13:: {
    VSCodeInFolder(webdevTitle, webdevPath)
    Return
}

Ralt & f15:: {
    LaunchOrToggleProgram(projectsTitle, ahkexe.explorer, projectsPath)
    Return
}

Ralt & f16:: {
    VSCodeInFolder(projectsTitle, projectsPath)
    KeyWait ("Ralt")
    KeyWait ("f14")
    Return
}

Ralt & f17:: {
    LaunchOrToggleProgram(terminalTitle, ahkexe.terminal, terminalPath, , false)
}

Rctrl & f21:: { ; (Rctrl & f21) and (Rctrl & f22) were missed before
    TerminalInCurrentFolder()
    KeyWait("Rctrl")
    KeyWait("f21")
    Return
}

Ralt & f18:: {
    LaunchOrToggleProgram(notionTitle, ahkexe.notion, notionPath)
    Return
}

Ralt & f19:: {
    OpenNotionPage(todoPageTitle, todoPageID)
    Return
}

Ralt & f20:: {
    OpenNotionPage(deadlinesPageTitle, deadlinesPageID)
    Return
}

Ralt & f21:: {
    OpenNotionPage(leetcodePageTitle, leetcodePageID)
    Return
}

Ralt & f22:: {
    OpenNotionPage(notesPageTitle, notesPageID)
    Return
}

Ralt & f23:: {
    OpenNotionPage(lifeforcePageTitle, lifeforcePageID)
    Return
}

Ralt & f24:: {
    LaunchOrToggleProgram(keepassTitle, ahkexe.keepass, keepassPath, , false)
    Return
}

Rshift & f13:: {
    LaunchProgram(ahkexe.photoshop, photoshopPath)
    Return
}

Rshift & f14:: {
    OpenChrome(chromeProfile1)
    Return
}

Rshift & f15:: {
    LaunchOrToggleProgram(downloads1Title, ahkexe.explorer, downloads1Path)
    Return
}

Rshift & f16:: {
    LaunchOrToggleProgram(downloads2Title, ahkexe.explorer, downloads2Path)
    Return
}

; ----- Primary URLs -----

Rshift & f17:: {
    FindOrOpenChromeTab("<firstmail@gmail.com - gmail>", "mail.google.com/mail/u/0/#inbox")
    Return
}

Rshift & f18:: {
    FindOrOpenChromeTab("<secondmail@gmail.com - gmail>", "mail.google.com/mail/u/1/#inbox")
    Return
}

Rshift & f19:: {
    FindOrOpenChromeTab("whatsapp", "web.whatsapp.com/")
    Return
}

Rshift & f20:: {
    FindOrOpenChromeTab("ChatGPT", "chatgpt.com")
    Return
}

Rshift & f21:: {
    OpenLink("github.com")
    Return
}

; ----- Other URLs -----

; Rshift & f22:: {

;     Return
; }

; Rshift & f23:: {

;     Return
; }

; Rshift & f24:: {

;     Return
; }

; Lctrl & f13:: {

;     Return
; }

; Lctrl & f14:: {

;     Return
; }

; Lctrl & f15:: {

;     Return
; }

Lctrl & f17:: {
    SetWorkingDir(A_ScriptDir "\obs")
    Run("recording-desktop.vbs")
    SetWorkingDir A_InitialWorkingDir
    Return
}

Lctrl & f18:: {
    SetWorkingDir(A_ScriptDir "\obs")
    Run("screen-webcam.vbs")
    SetWorkingDir A_InitialWorkingDir
    Return
}

Lctrl & f19:: {
    SetWorkingDir(A_ScriptDir "\obs")
    Run("webcam.vbs")
    SetWorkingDir A_InitialWorkingDir
    Return
}

Lctrl & f20:: {
    SwtichPowerPlan(highperformance.guid, "High Performance Plan (Active)", highperformance.soundPath)
    Return
}

Lctrl & f21:: {
    SwtichPowerPlan(highperformanceNoSleep.guid, "High Performance + No Sleep (Active)", highperformanceNoSleep.soundPath)
    Return
}

Lctrl & f22:: {
    SwtichPowerPlan(powersaver.guid, "Power Saver Plan (Active)", powersaver.soundPath)
    Return
}

Lctrl & f23:: {
    Run("nircmd monitor off")
    Return
}

Lctrl & f24:: {
    Run("power\power-states\restart\restart.exe")
    WinWait("Restart Windows")
    WinActivate("Restart Windows")
    Return
}

Lalt & f13:: {
    FastStartupShutdown()
}

Lalt & f14:: {
    Run("power\power-states\full-shutdown\full_shutdown.exe")
    WinWait("Shutdown Windows")
    WinActivate("Shutdown Windows")
    KeyWait("Lalt")
    KeyWait("f14")
    Return
}

Lalt & f15:: {
    SystemSleep()
    Return
}

Lalt & f16:: {
    DetectHiddenWindows True
    if !WinExist("auto-shutdown.ahk") {
        Run("auto-shutdown.ahk")
        DetectHiddenWindows False
        KeyWait("Lalt")
        KeyWait("f16")
        Return
    }
    else {
        DetectHiddenWindows False
        MsgBox("Auto Shutdown is already running!", "Warning", 0 | 64)
        KeyWait("Lalt")
        KeyWait("f16")
        Return
    }
}

Lalt & f17:: {
    LaunchOrToggleProgram(obsTitle, ahkexe.obs, obsPath, "C:\Program Files (others)\obs-studio\bin\64bit\", false)
    LaunchProgram(ahkexe.streamerbot, streamerbotPath, , false, true)
    Return
}

#HotIf WinExist(ahkexe.obs)
Lalt & f17:: {
    LaunchOrToggleProgram(obsTitle, ahkexe.obs, obsPath, "C:\Program Files (others)\obs-studio\bin\64bit\", false)
    Return
}
#HotIf

Lalt & f18:: {
    try {
        WinClose(ahkexe.obs)
        ProcessClose("Streamer.bot.exe")
    }
    catch {

    }
    Return
}

; ----- Script Management -----

Lalt & f19:: Reload

#SuspendExempt
Lalt & f20:: SuspendScript
#SuspendExempt False