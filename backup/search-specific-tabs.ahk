#Requires AutoHotkey v2.0

SetTitleMatchMode(2)
^`::
{
    ChromeCount := WinGetCount("ahk_exe chrome.exe")
    activeTab := ""
    firstTab := ""

    IB := InputBox("Enter Tab Title", "", "w100 h100"), tabName := IB.Value, ErrorLevel := IB.Result = "OK" ? 0 : IB.Result = "CANCEL" ? 1 : IB.Result = "Timeout" ? 2 : "ERROR"
    If ErrorLevel
        return

    Loop ChromeCount
    {
        WinActivateBottom("ahk_exe chrome.exe")
        WinWaitActive("ahk_exe chrome.exe")
        firstTab := WinGetTitle("A")
        If InStr(firstTab, tabName)
            break
        While !(activeTab = firstTab)
        {
            Send("^{tab}")
            Sleep(50)
            activeTab := WinGetTitle("A")
            If InStr(activeTab, tabName)
                break 2 
        }
    }
    return
}