#NoEnv
#Persistent
#SingleInstance Force
SetBatchLines -1
;SendMode Input
SetWorkingDir %A_WorkingDir%
;----------------------------------
if not A_IsAdmin
{
	Run *RunAs "%A_ScriptFullPath%"
	ExitApp
}
;----------------------------------
; получаем путь к программе
programPath := "C:\Program Files (x86)\MSpeech\MSpeech.exe"

; извлекаем название программы из имени файла
programName := SubStr(programPath, InStr(programPath, "\", 0, -1) + 1)

Gui Add, Text, x84 y43 w308 h25 +0x200, Название: %programName%
Gui Add, Edit, x84 y70 w308 h25 vprogramNameEdit, %programName%
Gui Add, Text, x84 y103 w308 h25 +0x200, Путь: %programPath%
Gui Add, Edit, x84 y130 w308 h25 vprogramPathEdit, %programPath%
Gui Add, Button, x196 y170 w80 h23, &KILL

Gui Show, w476 h236, Window
Return

GuiEscape:
GuiClose:
    ExitApp

KILL:
    ; получаем идентификатор процесса
    Process, Exist, %programPath%
    pid := ErrorLevel

    if (pid > 0) {
        ; закрываем процесс
        Process, Close, %pid%
        ; выводим сообщение об успехе
        MsgBox Процесс %programName% был успешно закрыт!
    } else {
        ; выводим сообщение о ошибке
        MsgBox Не удалось найти процесс %programName%!
    }
Return
