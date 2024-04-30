# Hotkey List
```markdown
Command                         Keybinding                      When

## coding macro 
include                         Ctrl + Alt + i
int main, fastio                Ctrl + Alt + j
for loop macro                  ::vhf:: {i} {n}
for loop macro                  ::v=f:: {i} {n}
auto cin                        Ctrl + Alt + y                  #IfWinActivate VSC

## clipboard    
remove Enter                    Ctrl + Alt + r
replace                         ::ATKClipRep:: {t} {w}
remove                          ::ATKClipRem:: {t}

## bookmark 
add bookmark                    Ctrl + Alt + c
open bookmark list              Ctrl + Alt + o
select bookmark                 1~9                             #IfWinActivate BookmarkGUI
select last bookmark            0                               #IfWinActivate BookmarkGUI

## 기타 
show hotkey list                Ctrl + Alt + h
open wifi list                  Win + c
copy address                    Alt + c
count number of words           Ctrl + Shift + i

## no screen off mode   
mode on/off                     Ctrl + Alt + s
super mode on/off               Ctrl + Alt + Shift + s

## mouse control mode   
mode on/off                     Ctrl + Alt + k
move                            hjkl                            #If mouseControlMode
move                            ;'[]                            #If mouseControlMode
move more                       shift + move                    #If mouseControlMode
move                            ctrl + move                     #If mouseControlMode
click L/R                       yo                              #If mouseControlMode
click L/R                       /\                              #If mouseControlMode
wheel D/U                       ui                              #If mouseControlMode
wheel D/U                       p=                              #If mouseControlMode

## fast erase mode  
mode on/off                     Ctrl + Alt + q
delete to home                  q                               #If fastEraseMode
delete to end                   w                               #If fastEraseMode
```