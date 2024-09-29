#Requires AutoHotkey v2.0

; ______________________________________________________________________________
; ahkexe Definitions
; ______________________________________________________________________________

ahkexe := {
    obs: "ahk_exe obs64.exe",
    chrome: "ahk_exe chrome.exe",
    notion: "ahk_exe Notion.exe",
    vscode: "ahk_exe Code.exe",
    keepass: "ahk_exe KeePassXC.exe",
    terminal: "ahk_exe WindowsTerminal.exe",
    explorer: "ahk_exe explorer.exe",
    photoshop: "ahk_exe Photoshop.exe",
    streamerbot: "ahk_exe Streamer.bot.exe"
}

; ______________________________________________________________________________
; Playback Devices
; ______________________________________________________________________________

playbackDevices := {
    speaker: "Speakers",
    headphones: "Realtek HD Audio 2nd output"
}

; ______________________________________________________________________________
; PowerPlan GUIDs
; ______________________________________________________________________________

highperformance := {
    guid: "8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c",
    soundPath: "power\power-plans\audio\highperformance-notification.mp3"
}

powersaver := {
    guid: "a1841308-3541-4fab-bc81-f71556f20b4a",
    soundPath: "power\power-plans\audio\powersaver-level-up.mp3"
}

highperformanceNoSleep := {
    guid: "9897998c-92de-4669-853f-b7cd3ecb2790",
    soundPath: "power\power-plans\audio\studyplan-message-incoming.mp3"
}

; ______________________________________________________________________________
; Folder Definitions
; ______________________________________________________________________________

downloads1Title := "Downloads"
downloads1Path := "C:\Users\XANOUS\Downloads"

downloads2Title := "Downloads - 2"
downloads2Path := "G:\Downloads - 2"

algoTitle := "Algorithm"
algoPath := "D:\Prog\Algorithms"

webdevTitle := "WebDev"
webdevPath := "D:\Prog\WebDev"

projectsTitle := "Projects"
projectsPath := "D:\Projects"

; ______________________________________________________________________________
; Application Definitions
; ______________________________________________________________________________

chromeProfile1 := "Profile 5"
chromeProfile2 := "Profile 1"

chromeTitle := "Google Chrome"
chromePath := "C:\Program Files\Google\Chrome\Application\chrome.exe"

keepassTitle := "KeePassXC"
keepassPath := "C:\Program Files\KeePassXC\KeePassXC.exe"

terminalTitle := "Windows PowerShell"
terminalPath := "wt.exe"

vscodeTitle := "" ; Visual Studio Code
vscodePath := "C:\Users\XANOUS\AppData\Local\Programs\Microsoft VS Code\Code.exe"

notionTitle := ""
notionPath := "C:\Users\XANOUS\AppData\Local\Programs\Notion\Notion.exe"

todoPageTitle := "Today"
todoPageID := "Today-8ad9eff7deff427ea6be2e947881686d?pvs=4"

deadlinesPageTitle := "Goals & Deadlines"
deadlinesPageID := "Goals-Deadlines-0faa17bbd634432baf8da2b396b7a278?pvs=4"

notesPageTitle := "My Notes"
notesPageID := "My-Notes-eee2830f44c941bb8215c7bf16e68323?pvs=4"

leetcodePageTitle := "Leetcode Tracker"
leetcodePageID := "Leetcode-Tracker-e5d7f54ef3bc4258971fddefd8c3d526?pvs=4"

lifeforcePageTitle := "Life Force"
lifeforcePageID := "Life-Force-bb55a5c56e224055965bff5758bd3617?pvs=4"

photoshopTitle := ""
photoshopPath := "C:\Program Files\Adobe\Adobe Photoshop 2024\Photoshop.exe"

obsTitle := ""
obsPath := "C:\Program Files (others)\obs-studio\bin\64bit\obs64.exe"
streamerbotPath := "C:\Program Files (others)\Streamer.bot-x64-0.2.4\Streamer.bot.exe"
