; 북마크 관련
    bookmarkAddMode := false
    bookmarkAddURL := ""
; gui 1 : directory
    directoryPath := A_ScriptDir . "\bookmark" ; \directory.txt"
    directoryGuiOpened := false
; gui 5 : file
    bookmarkPath := ""
    bookmarkGuiOpened := false

; 화면 꺼짐 방지 모드 관련
; gui 2
    noScreenOff := 0
    Gui2Title := "ATK_ScreenProtect"

; 마우스 조종 모드 관련
; gui 3
    MouseControlMode := false
    MouseControlDistance := 50

; 빠르게 지우기 모드 관련
; gui 4
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

    if (noScreenOff) {
        MouseGetPos, MouseX, MouseY
        MouseMove, MouseX+10, MouseY+10, 10
        MouseMove, MouseX, MouseY, 10
        sleep 1000
    }
}

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

; vsc snippet으로 대체했음
    ; ::dkdnt:: ; for (auto &e : v) cout << e << " "; cout << "\n";
    ;     Input, vecName, , {enter}{space};
    ;     SendByPaste("for (auto &e : " . vecName . ") cout << e << "" ""; cout << ""\n"";`n")
    ;     return

    ; +!i::
    ; 	SendByPaste("#include <bits/stdc++.h>`nusing namespace std;`n`n")
    ; 	return

    ; +!r::
    ; 	SendByPaste("#include <ext/rope>`nusing namespace __gnu_cxx;`n`n")
    ; 	return

    ; +!p::
    ; 	SendByPaste("#include <ext/pb_ds/assoc_container.hpp>`n#include <ext/pb_ds/tree_policy.hpp>`nusing namespace __gnu_pbds;`nusing ordered_set = tree<int, null_type, less<int>, rb_tree_tag, tree_order_statistics_node_update>;`n`n")
    ; 	return

    ; +!j::
    ; 	SendByPasteWithBracket("int main() ")
    ; 	SendByPasteEnter("cin.tie(0) -> sync_with_stdio(0);")
    ; 	return

    ; +!t::
    ; 	SendByPasteWithBracket("int t;`n`tfor (cin >> t; t--;) ")
    ; 	return

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
    output := "cin"
    Loop, % Words0
    {
        word := Words%A_Index%
        word := trim(word)
        output .= " >> "word
    }
	SendByPaste(output)
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
    Sleep, 3
    Clipboard := BackupClipboard
}

#IfWinNotActive ahk_exe idea64.exe
^!d::
	Clipboard := ClipboardAll
	NewText := StrReplace(Clipboard, "`r`n", " ")
	NewText := RegExReplace(NewText, "\s+", " ")
	Clipboard := NewText
	Msgbox, , , %clipboard%, 0.8
	return
#IfWinNotActive

::ATKClipRep::
	Input, target, L1
	Input, want, L1
	clipboard := StrReplace(clipboard, target, want)
	Msgbox, , , %clipboard%, 0.8
	return

::ATKClipRem::
	Input, target, L1
	clipboard := StrReplace(clipboard, target, "")
	Msgbox, , , %clipboard%, 0.8
	return

#IfWinNotActive ahk_exe idea64.exe
^!c::
    Gui, Destroy
    BackupClipboard := ClipboardAll
    Clipboard := ""
    Send, !d
    Sleep, 80
    Send, ^c
	ClipWait, 0.5
	if (ErrorLevel = 0)	{
        bookmarkAddURL := Clipboard
        ; FileAppend, `n%URL%, %directoryPath%
        Msgbox, url : %bookmarkAddURL%
        bookmarkAddMode := true
        OpenDirectoryGui()
	}
    else {
        MsgBox, copy failed
    }

    Clipboard := BackupClipboard
    return

^!o::
    bookmarkAddMode := false
    OpenDirectoryGui()
    return
#IfWinNotActive

OpenDirectoryGui()
{
    global directoryGuiOpened
    if (directoryGuiOpened = true) {
        return
    }

    global DirectoryListBox, openBtn

    directoryGuiOpened := true
    Gui, +AlwaysOnTop
    Gui, Font, s15
    Gui, Add, ListBox, w400 h400 vDirectoryListBox hwndHANDLE, % DirectoryGuiInitByTxt()
    Gui, Font, s10
    Gui, Add, Button, x18 y400 w50 h20 Default gDirectoryGuiOpen vOpenBtn, Open
    GuiControl, Choose, DirectoryListBox, 1
    Gui, Show, , % "ATK_DIRECTORY"
    return
}

GuiEscape:
GuiClose:
    DirectoryGuiDestroy(HANDLE)
    return

DirectoryGuiOpen:
    global bookmarkPath

    GuiControlGet, SelectedDirectory, , DirectoryListBox
    if (SelectedDirectory != "")
    {
        bookmarkPath := A_ScriptDir . "\bookmark\" . SelectedDirectory
    }
    DirectoryGuiDestroy(HANDLE)
    if (bookmarkAddMode)
    {
        FileAppend, `n%bookmarkAddURL%, %bookmarkPath%
    }
    OpenBookmarkGui()
    return

DirectoryGuiInitByTxt()
{
    global directoryPath
    fileList := ""

    Loop, Files, %directoryPath%\* 
    {
        fileList .= A_LoopFileName . "|"
    }

    if (fileList != "")
    {
        fileList := SubStr(fileList, 1, -1)
    }

    return fileList
}

DirectoryGuiDestroy(HANDLE)
{
    global directoryPath
    FileDelete, %directoryPath%
    ControlGet, Items, List,,, ahk_id %HANDLE%
    FileAppend, %Items%, %directoryPath%
    Gui, Destroy

    global directoryGuiOpened
    directoryGuiOpened := false
}

#IfWinExist, ATK_DIRECTORY ; 변수로 했더니 에러남. 리터럴만 가능한듯
#IfWinActive, ATK_DIRECTORY
1::
2::
3::
4::
5::
6::
7::
8::
9::
    GuiControl, Choose, DirectoryListBox, % SubStr(A_ThisHotkey, 1)
    return

0::
    ControlGet, List, List, Count, ListBox1, A
    cnt := 0
    Loop, Parse, List, `n
    {
        cnt++
    }
    GuiControl, Choose, DirectoryListBox, %cnt%
    return
#IfWinExist
#IfWinActive

OpenBookmarkGui()
{
    global bookmarkGuiOpened
    if (bookmarkGuiOpened = true) {
        return
    }

    global BookmarkListBox, openBtn, deleteBtn, undoBtn

    bookmarkGuiOpened := true
    Gui, 5: +AlwaysOnTop
    Gui, 5: Font, s15
    Gui, 5: Add, ListBox, w400 h400 vBookmarkListBox hwndHANDLE, % BookmarkGuiInitByTxt()
    Gui, 5: Font, s10
    Gui, 5: Add, Button, x18 y400 w50 h20 Default gBookmarkGuiOpen vOpenBtn, Open
    Gui, 5: Add, Button, x71 y400 w50 h20 gBookmarkGuiDelete vDeleteBtn, Delete
    Gui, 5: Add, Button, x124 y400 w50 h20 gBookmarkGuiUndo vUndoBtn + Disabled, Undo
    GuiControl, 5: Choose, BookmarkListBox, 1
    Gui, 5: Show, , % "ATK_BOOKMARK"
    return
}

5GuiEscape:
5GuiClose:
    BookmarkGuiDestroy(HANDLE)
    return

BookmarkGuiOpen:
    GuiControlGet, SelectedBookmark, , BookmarkListBox

    SelectedBookmark := Trim(SelectedBookmark, "`n`r") ; 웹사이트 링크는 상관없는데 폴더경로인 경우 끝에 줄바꿈 있으면 오류남
    if (SelectedBookmark != "")
    {
        Run, %SelectedBookmark%
    }
    BookmarkGuiDestroy(HANDLE)
    return

BookmarkGuiDelete:
    GuiControlGet, DeletedBookmark, , BookmarkListBox
    sendmessage, 0x188, 0, 0, , ahk_id %HANDLE%
    sendmessage, 0x182, errorlevel, 0, , ahk_id %HANDLE%
    GuiControl, Enable, UndoBtn
    GuiControl, Choose, BookmarkListBox, 1
    return

BookmarkGuiUndo:
    GuiControl, Choose, BookmarkListBox, 0 ; 이걸로 choose 취소해놔야 undo제대로 작동함. 이거 안 하면 undo할때 이전에 delete된거랑 1번째 원소 합쳐진 링크가 새로 생김
    GuiControlGet, Items, , BookmarkListBox
    Items := Items "`n" DeletedBookmark
    GuiControl, , BookmarkListBox, %Items%
    GuiControl, Disable, UndoBtn
    GuiControl, Choose, BookmarkListBox, 1
    return

BookmarkGuiInitByTxt()
{
    global bookmarkPath
    FileRead, fileContents, % bookmarkPath

    bookmarks := ""
    Loop, Parse, fileContents, `n
    {
        bookmarks .= A_LoopField . "|"
    }
    return bookmarks
}

BookmarkGuiDestroy(HANDLE)
{
    global bookmarkPath
    FileDelete, %bookmarkPath%
    ControlGet, Items, List,,, ahk_id %HANDLE%
    FileAppend, %Items%, %bookmarkPath%
    Gui, Destroy

    global bookmarkGuiOpened
    bookmarkGuiOpened := false
}

#IfWinExist, ATK_BOOKMARK ; 변수로 했더니 에러남. 리터럴만 가능한듯
#IfWinActive, ATK_BOOKMARK
1::
2::
3::
4::
5::
6::
7::
8::
9::
    GuiControl, 5: Choose, BookmarkListBox, % SubStr(A_ThisHotkey, 1)
    return

0::
    ControlGet, List, List, Count, ListBox1, A
    cnt := 0
    Loop, Parse, List, `n
    {
        cnt++
    }
    GuiControl, 5: Choose, BookmarkListBox, %cnt%
    return
#IfWinExist
#IfWinActive

#c::
Run, explorer ms-availablenetworks:
return

!c::Send, !d^c
!v::Send, !d^v{Enter}
!t::Send, ^t!d^v{Enter}

#IfWinNotActive ahk_exe idea64.exe
^!i::
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
    if (noScreenOff) {
		Gui, 2: Destroy
    }

    noScreenOff := mod(noScreenOff + 1, 3)
    if (noScreenOff) {
        Gui, 2: Default
		Gui, 2: +AlwaysOnTop
        Gui, 2: Color, White
        Gui, 2: Add, Text, x5 y5 w190 h20 vText, % "screen off preventing is on . . ."

        if (noScreenOff=1) {
            Gui, 2: Show, x0 y0 w200 h50, %Gui2Title%
        }
        else if (noScreenOff=2) {
            Gui, 2: Show, x200 y50 w1200 h700, %Gui2Title%
        }
	}
    return
#IfWinNotActive

2GuiEscape:
2GuiClose:
    noScreenOff := false
    Gui, 2: Destroy
    return

#IfWinNotActive ahk_exe idea64.exe
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
#IfWinNotActive

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

#IfWinNotActive ahk_exe idea64.exe
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
#IfWinNotActive

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
