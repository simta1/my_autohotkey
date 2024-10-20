<!-- 한글로 쓰고 싶은데 들여쓰기 정도가 달라져서 표가 깨짐 -->

| Category                 | Command                         | Keybinding                      | When                             |
|--------------------------|---------------------------------|---------------------------------|----------------------------------|
| **coding macro**         | for [0, n)                      | `::vhf:: {i} {n}`               |                                  |
|                          | for [1, n]                      | `::v=f:: {i} {n}`               |                                  |
| **clipboard**            | clipboard remove newline        | `Ctrl + Alt + d`                | #ifWinNotActive intellij         |
|                          | clipboard replace               | `::ATKClipRep:: {pattern} {str}`|                                  |
|                          | clipboard remove                | `::ATKClipRem:: {pattern}`      |                                  |
| **bookmark**             | add bookmark                    | `Ctrl + Alt + c`                | #ifWinNotActive intellij         |
|                          | open bookmark list              | `Ctrl + Alt + o`                | #ifWinNotActive intellij         |
|                          | select bookmark                 | `1~9`                           | #IfWinActive BookmarkGUI         |
|                          | select last bookmark            | `0`                             | #IfWinActive BookmarkGUI         |
| **misc**                 | open wifi list                  | `Win + c`                       |                                  |
|                          | cut address                     | `Alt + x`                       |                                  |
|                          | copy address                    | `Alt + c`                       |                                  |
|                          | paste address in current tab    | `Alt + v`                       |                                  |
|                          | paste address in new tab        | `Alt + t`                       |                                  |
|                          | paste address in new window     | `Alt + n`                       |                                  |
|                          | count selected text             | `Ctrl + Alt + i`                | #ifWinNotActive intellij         |
|                          | paste by plain text             | `Ctrl + Alt + v`                | #ifWinNotActive intellij         |
| **no screen off mode**   | mode on/off                     | `Ctrl + Alt + s`                | #ifNotWinActive intellij         |
|                          | super mode on/off               | `Ctrl + Alt + s`                | #ifNotWinActive intellij         |
| **mouse control mode**   | mode on/off                     | `Ctrl + Alt + k`                | #ifNotWinActive intellij         |
|                          | move                            | `hjkl`                          | #If mouseControlMode             |
|                          | click L/R                       | `yo`                            | #If mouseControlMode             |
|                          | wheel D/U                       | `ui`                            | #If mouseControlMode             |
|                          | move                            | `;'[]`                          | #If mouseControlMode             |
|                          | click L/R                       | `/\`                            | #If mouseControlMode             |
|                          | wheel D/U                       | `p=`                            | #If mouseControlMode             |
|                          | move more                       | `Shift + move`                  | #If mouseControlMode             |
|                          | move less                       | `Ctrl + move`                   | #If mouseControlMode             |
| **fast erase mode**      | mode on/off                     | `Ctrl + Alt + q`                | #ifNotWinActive intellij         |
|                          | delete to home                  | `q`                             | #If fastEraseMode                |
|                          | delete to end                   | `w`                             | #If fastEraseMode                |