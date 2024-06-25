hotkeyList =
(
---------------------------------------------도움말
Ctrl + Alt + h     (핫키 리스트 출력)

---------------------------------------------코딩용 매크로
Ctrl + Alt + i     (#include 코드)
Ctrl + Alt + j     (int main, fastio 코드)
vhf i n     (for문 매크로)
v=f i n     (for문 매크로)
---------------------------------------------#If(WinActivate VSC)
Ctrl + Alt + y     (auto cin)

---------------------------------------------클립보드 수정
Ctrl + Alt + r     (줄바꿈 제거)
::ATKClipRep:: & input target, want
::ATKClipRem:: & input target

---------------------------------------------북마크
Ctrl + Alt + c     (북마크 추가)
Ctrl + Alt + o     (북마크 목록 열기)
---------------------------------------------#If(WinActivate BookmarkGUI)
1~9     (해당 번호의 북마크 선택)
0     (마지막 북마크 선택)

---------------------------------------------기타
Win + c     (wifi창 열기)
Alt + c     (주소 복사)
Ctrl + Shift + i     (글자 수 계산)
Ctrl + Alt + v     (글꼴 제거 후 텍스트만 붙여넣기)

---------------------------------------------화면 꺼짐 방지 모드
Ctrl + Alt + s     (모드 on/off)
---------------------------------------------화면 꺼짐 방지 모드 + 화면 가림창
Ctrl + Alt + Shift + s     (모드 on/off)

---------------------------------------------마우스 조종 모드
Ctrl + Alt + k     (모드 on/off)
hjkl     (좌하상우 이동)
;'[]     (좌하상우 이동)
shift + 이동     (300`% 이동)
ctrl + 이동     (30`% 이동)
yuio     (좌클릭, 아래휠, 위휠, 우클릭)
/p=\     (좌클릭, 아래휠, 위휠, 우클릭)

---------------------------------------------빠르게 지우기 모드
Ctrl + Alt + q     (모드 on/off)  
q     (home까지 삭제)
w     (end까지 삭제)
)

; 북마크 관련
bookmarkFilePath := A_ScriptDir . "\bookmark.txt"
bookmarkGuiOpened := false

; 화면 꺼짐 방지 모드 관련
noScreenOff := false
Gui2Title := "ATK_ScreenProtect"

; 마우스 조종 모드 관련
MouseControlMode := false
MouseControlDistance := 50

; 빠르게 지우기 모드 관련
fastEraseMode := false

SetTitleMatchMode, 2 ; 부분 문자열 일치 모드로 설정 (창 제목이 일부만 일치해도 됨)
Msgbox, , , junho.ahk has been executed., 0.6

Loop
{
	IfWinExist, ahk_exe LeagueClientUx.exe ; 롤 핵경고 방지
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
	MsgBox, % hotkeyList
	return

^!i::
	SendByPaste("#include <bits/stdc++.h>`nusing namespace std;`n`n")
	return

^!u::
	SendByPaste("#include <bits/stdc++.h>`n#include <ext/rope>`nusing namespace std;`nusing namespace __gnu_cxx;`n`n")
	return

^!j::
	SendByPaste("int main() ")
	SendRaw, {`n
	Sleep, 10
	SendByPasteEnter("cin.tie(0) -> sync_with_stdio(0);")
	return

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

SendByPaste(string)
{
	BackupClipboard := ClipboardAll
    Clipboard := string
    Sleep, 50
    Send, ^v
    Sleep, 200 ;이거 없으면 backupclipboard가 클립보드에 들어가고 나서 ^v될 때도 있음. ^v자체가 시간이 좀 걸리는 듯
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

^!r::
	Clipboard := ClipboardAll
	NewText := StrReplace(Clipboard, "`r`n", " ")
	NewText := RegExReplace(NewText, "\s+", " ")
	Clipboard := NewText
	Msgbox, , , %clipboard%, 0.8
	return

::ATKClipboardReplace::
	Input, target, L1
	Input, want, L1
	clipboard := StrReplace(clipboard, target, want)
	Msgbox, , , %clipboard%, 0.8
	return

::ATKClipboardRemove::
	Input, target, L1
	clipboard := StrReplace(clipboard, target, "")
	Msgbox, , , %clipboard%, 0.8
	return

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
        FileAppend, `n%URL%, %bookmarkFilePath%
        Msgbox, url : %URL%
	}
    else {
        MsgBox, copy failed
    }

    Clipboard := BackupClipboard
    return

^!o::
    if (bookmarkGuiOpened = true) {
        return
    }

    bookmarkGuiOpened := true
    Gui, +AlwaysOnTop
    Gui, Font, s15
    Gui, Add, ListBox, w400 h400 vAddressListBox hwndHANDLE, % ReadAddressesFromFile()
    Gui, Font, s10
    Gui, Add, Button, x18 y400 w50 h20 Default gOpenAddress vOpenBtn, Open
    Gui, Add, Button, x71 y400 w50 h20 gDeleteAddress vDeleteBtn, Delete
    Gui, Add, Button, x124 y400 w50 h20 gUndoAddress vUndoBtn + Disabled, Undo
    GuiControl, Choose, AddressListBox, 1
    Gui, Show, , % "ATK_Bookmark"
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
    global bookmarkFilePath
    FileRead, fileContents, %bookmarkFilePath%

    bookmarks := ""
    Loop, Parse, fileContents, `n
    {
        bookmarks .= A_LoopField . "|"
    }
    return bookmarks
}

GUIDestroy(HANDLE)
{
    global bookmarkFilePath
    FileDelete, %bookmarkFilePath%
    ControlGet, Items, List,,, ahk_id %HANDLE%
    FileAppend, %Items%, %bookmarkFilePath%
    Gui, Destroy

    global bookmarkGuiOpened
    bookmarkGuiOpened := false
}

#IfWinExist, ATK_Bookmark ; 변수로 했더니 에러남. 리터럴만 가능한듯
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

#c::
Run, explorer ms-availablenetworks:
return

!c::
Send, !d
Sleep, 80
Send, ^c
return

^+i::
	BackupClip := ClipboardAll
	Clipboard := ""
	SendInput, ^c
	ClipWait, 0.5
	if ErrorLevel<> 0
	{
		MsgBox, 글자 수 : 0
	}
	else {
		str := StrReplace(Clipboard, "`r`n")
		strNoSpace := StrReplace(str, " ")

		InLen := StrLen(str)
		ExLen := StrLen(strNoSpace)
		wordCount := countNumberOfWords(Clipboard)
		MsgBox, 공백 포함 : %InLen%`n공백 제거 : %ExLen%`n단어 수 : %wordCount%
	}
	Clipboard := BackupClip
	return

countNumberOfWords(text) {
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

^!v::
    BackupClipboard := ClipboardAll
    str := Clipboard
    Clipboard := str
    Send, ^v
    Sleep, 200
    Clipboard := BackupClipboard
    return

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

^!k:: ;keyboard
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

^!q:: ; fast erase mode on/off
	If  (fastEraseMode) {
		fastEraseMode := false
        Gui, 4: Destroy
	}
	else {
		fastEraseMode := true
        Gui, 4: +AlwaysOnTop
        Gui, 4: Add, Text, w200 h40 vDistanceLabel, % "fast erase mode on . . ."
        Gui, 4: Show, x0 y0 w290 h50, % "fast erase mode"
	}
	return

4GuiEscape:
4GuiClose:
    fastEraseMode := false
    Gui, 4: Destroy
    return

#if (fastEraseMode)
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
