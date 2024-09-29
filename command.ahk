#Requires AutoHotkey v2.0+
#Include variables.ahk
#Include functions.ahk

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
    SwitchPlaybackDevice(speaker)
    Return
}

Rctrl & f18:: {
    SwitchPlaybackDevice(headphones)
    Return
}

Rctrl & f19:: {
    LaunchOrToggleProgram(title_vscode, ahkexe_vscode, path_vscode)
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
    LaunchOrToggleProgram(title_algo, ahkexe_explorer, path_algo)
    Return
}

Ralt & f13:: {
    VSCodeInFolder(title_webdev, path_webdev)
    Return
}

Ralt & f15:: {
    LaunchOrToggleProgram(title_projects, ahkexe_explorer, path_projects)
    Return
}

Ralt & f16:: {
    VSCodeInFolder(title_projects, path_projects)
    KeyWait ("Ralt")
    KeyWait ("f14")
    Return
}

Ralt & f17:: {
    TerminalInCurrentFolder()
}

Rctrl & f21:: { ; (Rctrl & f21) and (Rctrl & f22) were missed before
    LaunchOrToggleProgram(title_terminal, ahkexe_terminal, path_terminal, , false)
    KeyWait("Rctrl")
    KeyWait("f21")
    Return
}

Ralt & f18:: {
    LaunchOrToggleProgram(title_notion, ahkexe_notion, path_notion)
    Return
}

Ralt & f19:: {
    OpenNotionPage(pagetitle_todo, pageID_todo)
    Return
}

Ralt & f20:: {
    OpenNotionPage(pagetitle_deadlines, pageID_deadlines)
    Return
}

Ralt & f21:: {
    OpenNotionPage(pagetitle_leetcode, pageID_leetcode)
    Return
}

Ralt & f22:: {
    OpenNotionPage(pagetitle_notes, pageID_notes)
    Return
}

Ralt & f23:: {
    OpenNotionPage(pagetitle_lifeforce, pageID_lifeforce)
    Return
}

Ralt & f24:: {
    LaunchOrToggleProgram(title_keepass, ahkexe_keepass, path_keepass, , false)
    Return
}

Rshift & f13:: {
    LaunchProgram(ahkexe_photoshop, path_photoshop)
    Return
}

Rshift & f14:: {
    OpenChrome(profile1)
    Return
}

Rshift & f15:: {
    LaunchOrToggleProgram(title_downloads1, ahkexe_explorer, path_downloads1)
    Return
}

Rshift & f16:: {
    LaunchOrToggleProgram(title_downloads2, ahkexe_explorer, path_downloads2)
    Return
}

; ----- Primary URLs -----

Rshift & f17:: {
    OpenLink("<firstmail@gmail.com - gmail>", "mail.google.com/mail/u/0/#inbox")
    Return
}

Rshift & f18:: {
    OpenLink("<secondmail@gmail.com - gmail>", "mail.google.com/mail/u/1/#inbox")
    Return
}

Rshift & f19:: {
    OpenLink("whatsapp", "web.whatsapp.com/")
    Return
}

Rshift & f20:: {
    OpenLink("github", "github.com")
    Return
}

Rshift & f21:: {
    OpenLink("chatgpt", "chatgpt.com")
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
    SwtichPowerPlan(guid_highperformance, "High Performance Plan (Active)", sound_highperformance)
    Return
}

Lctrl & f21:: {
    SwtichPowerPlan(guid_studyplan, "Study Plan (Active)", sound_studyplan)
    Return
}

Lctrl & f22:: {
    SwtichPowerPlan(guid_powersaver, "Power Saver Plan (Active)", sound_powersaver)
    Return
}

Lctrl & f23:: {
    SystemShutdown()
    Return
}

Lctrl & f24:: {
    Run("power\power-states\full-shutdown\full_shutdown.exe")
    WinWait("Shutdown Windows")
    WinActivate("Shutdown Windows")
    Return
}

Lalt & f13:: {
    Run("power\power-states\restart\restart.exe")
    WinWait("Restart Windows")
    WinActivate("Restart Windows")
    Return
}

Lalt & f14:: {
    SystemSleep()
    Return
}

#HotIf WinExist(ahkexe_obs)
Lalt & f15:: {
    LaunchOrToggleProgram(title_obs, ahkexe_obs, path_obs, "C:\Program Files (others)\obs-studio\bin\64bit\", false)
    Return
}
#HotIf

Lalt & f15:: {
    LaunchOrToggleProgram(title_obs, ahkexe_obs, path_obs, "C:\Program Files (others)\obs-studio\bin\64bit\", false)
    LaunchProgram(ahkexe_streamerbot, path_streamerbot, , false, true)
    Return
}

Lalt & f16:: {
    try {
        WinClose(ahkexe_obs)
        ProcessClose("Streamer.bot.exe")
    }
    catch {

    }
    Return
}
