; bookmark ����
filePath := A_ScriptDir . "\bookmark.txt"
GuiOpen := false
MouseControlMode := false
MouseControlDistance := 100
GuiTitle := "ATK_Bookmark"
Gui2Title := "ATK_ScreenProtect"
SetTitleMatchMode, 2 ; �κ� ���ڿ� ��ġ ���� ���� (â ������ �Ϻθ� ��ġ�ص� ��)

; ȭ�� ���� ���� ����
noScreenOff := false

Msgbox, , , junho.ahk has been executed., 0.6

Loop
{
	IfWinExist, ahk_exe LeagueClientUx.exe ; �� �ٰ�� ����
	{
		Msgbox, junho.ahk has been terminated due to the execution of League of Legends.
		exitapp
	}

    if (noScreenOff=true) {
        MouseGetPos, MouseX, MouseY
        MouseMove, MouseX+10, MouseY+10, 10
        MouseMove, MouseX, MouseY, 10
        sleep 1000
    }
}

^!h:: ;help
::ATKaudfud:: ;ATK���
::ATKahrfhr:: ;ATK���
::ATKgkatn::  ;ATK�Լ�
	MsgBox, Ctrl + Alt + i(#include �ڵ�)`nCtrl + Alt + j(int main, fastio �ڵ�)`nCtrl + Alt + y(cin ����)`nvhf i n(for�� ��ũ��)`nv=f i n(for�� ��ũ��)`n`nWin + c(wifiâ)`nAlt+c(�ּ� ����)`nwin+q -- q w(������ ����� q : home, w : end)`nCtrl + Shift + i(���� ��)`n`nCtrl + Alt + r(ATKRemoveEnter)`nATKClipboardReplace`nATKClipboardRemove`n`nCtrl + Alt + c(�ϸ�ũ �߰�)`nCtrl + Alt + o(�ϸ�ũ ��� ����)`n`nCtrl + Alt + s(ȭ�� ���� ����)`nCtrl + Alt + Shift + s(ȭ�� ���� ���� + ȭ�� ������ GUIâ)`n`nCtrl + Alt + k(Ű���� Ŭ�� ���)
	return

^!i::
	SendByPaste("#include <bits/stdc++.h>`nusing namespace std;`n`n")
	return

^!j::
	SendByPaste("int main() ")
	SendRaw, {`n
	Sleep, 10
	SendByPasteEnter("cin.tie(0) -> sync_with_stdio(0);")
	return

#IfWinExist, Visual Studio Code
#IfWinActive, Visual Studio Code
^!y:: ; auto cin
    BackupClipboard := ClipboardAll
    Clipboard := ""
    Send, ^[
    Sleep, 50
    SendRaw, "+yy
    Sleep, 50
    Send, o
	str := Clipboard
	Clipboard := BackupClipboard

    str := trim(str)
    StringSplit, Words, str, " "
    len := Strlen(Words1)
    str := SubStr(str, len + 1)
    str := trim(str)
    StringSplit, Words, str, `,
    string := "cin"
    Loop, % Words0
    {
        word := Words%A_Index%
        word := trim(word)
        string .= " >> "word
    }
	SendByPaste(string)
    return
#ifWinExist
#IfWinActive

::vhf:: ; for (int i = 0; i < n; i++)
	Input, idxName, , {enter}{space};
	Input, num, , {enter}{space};
	SendByPasteWithBracket("for (int " . idxName . " = 0; " . idxName . " < " . num "; " . idxName . "++) ")
	return

::v=f:: ; for (int i = 1; i <= n; i++) {
	Input, idxName, , {enter}{space};
	Input, num, , {enter}{space};
	SendByPasteWithBracket("for (int " . idxName . " = 1; " . idxName . " <= " . num "; " . idxName . "++) ")
	return

#c::
Run, explorer ms-availablenetworks:
return

!c::
Send, !d
Sleep, 80
Send, ^c
return

#q:: ; fast erase mode on/off
	If  (activated = 1 ) {
		activated = 0
	}
	else {
		activated = 1
	}
	return

#if activated = 1 ; fast erase
{
	q::
	Send, +{home}
	Send, {backspace}
	return

	w::
	Send, +{end}
	Send, {backspace}
	return
}
#if

^+i::
	BackupClip := ClipboardAll
	Clipboard := ""
	SendInput, ^c
	ClipWait, 0.5
	if ErrorLevel<> 0
	{
		MsgBox, ���� �� : 0
	}
	else {
		str := StrReplace(Clipboard, "`r`n")
		strNoSpace := StrReplace(str, " ")

		InLen := StrLen(str)
		ExLen := StrLen(strNoSpace)
		wordCount := wordCount(Clipboard)
		MsgBox, ���� ���� : %InLen%`n���� ���� : %ExLen%`n�ܾ� �� : %wordCount%
	}
	Clipboard := BackupClip
	return

wordCount(text) {
    sentences := StrSplit(text, "`r`n")
    totalWords := 0

    for _, sentence in sentences {
        words := StrSplit(sentence, " ")
        filteredWords := []
        for _, word in words {
            if (word != "") {
                filteredWords.Push(word)
            }
        }
        totalWords += filteredWords.Length()
    }

    return totalWords
}

^!r::
::ATKRemoveEnter::
	Clipboard := ClipboardAll
	NewText := StrReplace(Clipboard, "`r`n", " ")
	NewText := RegExReplace(NewText, "\s+", " ")
	Clipboard := NewText
	Msgbox, , , %clipboard%, 0.8
	return

::ATKReplaceClipboard::
::ATKClipboardReplace::
	Input, target, L1
	Input, want, L1
	clipboard := StrReplace(clipboard, target, want)
	Msgbox, , , %clipboard%, 0.8
	return

::ATKRemoveClipboard::
::ATKClipboardRemove::
	Input, target, L1
	clipboard := StrReplace(clipboard, target, "")
	Msgbox, , , %clipboard%, 0.8
	return

SendByPaste(string)
{
	BackupClipboard := ClipboardAll
    Clipboard := string
    Sleep, 50
    Send, ^v
    Sleep, 200 ;�̰� ������ backupclipboard�� Ŭ�����忡 ���� ���� ^v�� ���� ����. ^v��ü�� �ð��� �� �ɸ��� ��
    Clipboard := BackupClipboard
}

SendByPasteEnter(string)
{
	BackupClipboard := ClipboardAll
    Clipboard := string
    Sleep, 50
    Send, ^v
	Send, {Enter}{Enter}
    Sleep, 200
    Clipboard := BackupClipboard
}

SendByPasteWithBracket(string)
{
	BackupClipboard := ClipboardAll
    Clipboard := string
    Sleep, 50
    Send, ^v
	Send, {{}{Enter}
    Sleep, 200
    Clipboard := BackupClipboard
}


^!c::
    Gui, Destroy
    BackupClipboard := ClipboardAll
    Clipboard := ""
    Send, !d
    Sleep, 80
    Send, ^c
	ClipWait, 0.5
	if (ErrorLevel = 0)	{
        URL := Clipboard
        FileAppend, `n%URL%, %filePath%
        Msgbox, url : %URL%
	}
    else {
        MsgBox, copy failed
    }

    Clipboard := BackupClipboard
    return

^!o::
    if (GuiOpen = true) {
        WinActivate, ahk_id %HANDLE%
        return
    }
    GuiOpen := true
    Gui, Font, s15
    Gui, Add, ListBox, w400 h400 vAddressListBox hwndHANDLE, % ReadAddressesFromFile()
    Gui, Font, s10
    Gui, Add, Button, x18 y400 w50 h20 Default gOpenAddress vOpenBtn, Open
    Gui, Add, Button, x71 y400 w50 h20 gDeleteAddress vDeleteBtn, Delete
    Gui, Add, Button, x124 y400 w50 h20 gUndoAddress vUndoBtn + Disabled, Undo
    GuiControl, Choose, AddressListBox, 1
    Gui, Show, , %GuiTitle%
    return

GuiEscape:
GuiClose:
    GuiDestroy(HANDLE)
    return

OpenAddress:
    GuiControlGet, SelectedAddress, , AddressListBox
    if (SelectedAddress != "")
    {
        Run, %SelectedAddress%
    }
    GuiDestroy(HANDLE)
    return

DeleteAddress:
    GuiControlGet, DeletedAddress, , AddressListBox
    sendmessage, 0x188, 0, 0, , ahk_id %HANDLE%
    sendmessage, 0x182, errorlevel, 0, , ahk_id %HANDLE%
    GuiControl, Enable, UndoBtn
    return

UndoAddress:
    GuiControlGet, Items, , AddressListBox
    Items := Items "`n" DeletedAddress
    GuiControl, , AddressListBox, %Items%
    GuiControl, Disable, UndoBtn
    return

ReadAddressesFromFile()
{
    global filePath
    FileRead, fileContents, %filePath%

    bookmarks := ""
    Loop, Parse, fileContents, `n
    {
        bookmarks .= A_LoopField . "|"
    }
    return bookmarks
}

GUIDestroy(HANDLE)
{
    global filePath
    FileDelete, %filePath%
    ControlGet, Items, List,,, ahk_id %HANDLE%
    FileAppend, %Items%, %filePath%
    Gui, Destroy

    global GuiOpen
    GuiOpen := false
}

#IfWinExist, ATK_Bookmark ; ������ �ߴ��� ������. ���ͷ��� �����ѵ�
#IfWinActive, ATK_Bookmark
1::
2::
3::
4::
5::
6::
7::
8::
9::
    GuiControl, Choose, AddressListBox, % SubStr(A_ThisHotkey, 1)
    return

0::
    ControlGet, List, List, Count, ListBox1, A
    cnt := 0
    Loop, Parse, List, `n
    {
        cnt++
    }
    GuiControl, Choose, AddressListBox, %cnt%
    return
#IfWinExist
#IfWinActive

^!s:: ;block screen off
^!+s::
    noScreenOff := !noScreenOff
    if (noScreenOff) {
        Gui, 2: Default
		Gui, 2: +AlwaysOnTop
        Gui, 2: Color, White
        Gui, 2: Add, Text, x5 y5 w190 h20 vText, % "screen off preventing is on . . ."

        if GetKeyState("Shift", "P") {
            Gui, 2: Show, x200 y50 w1200 h700, %Gui2Title%
        }
        else {
            Gui, 2: Show, x0 y0 w200 h50, %Gui2Title%
        }
	}
	else {
		Gui, 2: Destroy
	}
    return

2GuiEscape:
2GuiClose:
    noScreenOff := false
    Gui, 2: Destroy
    return

^!k:: ;keyboard mouse control mode
    if (MouseControlMode) {
        MouseControlMode := false
        Gui, 3: Destroy
    }
    else {
        MouseControlMode := true
        Gui, 3: +AlwaysOnTop
        Gui, 3: Add, Text, w200 h40 vDistanceLabel, Default Move : %MouseControlDistance%`nShift move : %MouseControlDistance% * 2`nCtrl move : %MouseControlDistance% * 0.3
        Gui, 3: Show, x0 y0 w290 h50, % "mouse control mode"
    }
    return

3GuiEscape:
3GuiClose:
    MouseControlMode := false
    Gui, 3: Destroy
    return

#If (MouseControlMode)
$h::
$;::MouseMove, % -MouseControlDistance, 0, 2, R  ; left
$j::
$'::MouseMove, 0, % +MouseControlDistance, 2, R   ; down
$k::
$[::MouseMove, 0, % -MouseControlDistance, 2, R   ; up
$l::
$]::MouseMove, % +MouseControlDistance, 0, 2, R    ; right
$+H::
$+;::MouseMove, % -MouseControlDistance * 3, 0, 2, R  ; left
$+J::
$+"::MouseMove, 0, % +MouseControlDistance * 3, 2, R   ; down
$+K::
$+{::MouseMove, 0, % -MouseControlDistance * 3, 2, R   ; up
$+L::
$+}::MouseMove, % +MouseControlDistance * 3, 0, 2, R    ; right
$^h::
$^;::MouseMove, % -MouseControlDistance * 0.3, 0, 2, R  ; left
$^j::
$^'::MouseMove, 0, % +MouseControlDistance * 0.3, 2, R   ; down
$^k::
$^[::MouseMove, 0, % -MouseControlDistance * 0.3, 2, R   ; up
$^l::
$^]::MouseMove, % +MouseControlDistance * 0.3, 0, 2, R    ; right

$/::Click
$+?::Send {Shift Down}{Click}{Shift Up}
$\::Click right
$p::MouseClick, WheelDown
$=::MouseClick, WheelUp

$y::Click
$+y::Send {Shift Down}{Click}{Shift Up}
$o::Click right
$u::MouseClick, WheelDown
$i::MouseClick, WheelUp

; Esc::
;     MouseControlMode := false
;     Gui, 3: Destroy
;     return

; UpdateGui() {
;     Gui, 3: Destroy
;     Gui, 3: +AlwaysOnTop
;     Gui, 3: Add, Text, w200 h40 vDistanceLabel, Default Move : %MouseControlDistance%`nShift move : %MouseControlDistance% * 2`nCtrl move : %MouseControlDistance% * 0.3
;     Gui, 3: Show, x0 y0 w290 h50, % "mouse control mode"
; }

; IncreaseDistance() {
;     MouseControlDistance += 5
;     UpdateGui()
; }

; DecreaseDistance() {
;     if (MouseControlDistance > 5) {
;         MouseControlDistance -= 5
;         UpdateGui()
;     }
; }
#If
