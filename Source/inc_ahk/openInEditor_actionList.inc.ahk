﻿;<<<<<<<< openInEditor <<<< 1810111507 <<<< 01.10.2018 11:54:07 <<<<
openInEditor(ActionListFolderOfThisActionList, isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib){
    if(!AHKcode){
        Clipboard := AHKcode
        Msgbox,% AHKcode "=AHKcode `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        ExitApp, 
    }
    foundPos := RegExMatch( AHKcode , "^\s*(?:AHK-Studio|AutoGUI|run)\s*,?(.+\.ahk)\s*$\b$" ,  m )
    ifIsIt := (isStartingUnderline && is_OpenA_edit_open_lib && foundPos ) 
    if(!ifIsIt)
        return false
    ; edit open script
   ; ___global generated open|rr||ahk|run,..\_globalActionListsGenerated\_global.ahk
   ; __________ __ tool too
    m1CorrectedAhkFileAddress := ActionListFolderOfThisActionList "\" m1
    ;Msgbox,% m1CorrectedAhkFileAddress "=m1CorrectedAhkFileAddress `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    m1ListFileName := RegExReplace(m1,"i)([\w\d_-\.]+\.ahk)\b\s*$","$1")
    ;Msgbox,% m1 "=m1 `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    ;Msgbox,% m1ListFileName "=m1ListFileName `n (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    ; ____
    if(!FileExist(m1CorrectedAhkFileAddress)){
        Msgbox,:( action list `n %m1CorrectedAhkFileAddress% `n is not exist. `n (%A_LineFile%~%A_LineNumber%)
        return false
    }
    if(!FileExist(m1CorrectedAhkFileAddress)){
        Msgbox,:( action list `n %m1CorrectedAhkFileAddress% `n is not exist. `n (%A_LineFile%~%A_LineNumber%)
        return false
    }

    editorName := "AHK-Studio"
    isEditorExist_AHKStudio := FileExist("..\" editorName "\" editorName ".ahk")
    editorName := "AutoGUI"
    isEditorExist_AutoGUI := FileExist("..\" editorName "\" editorName ".ahk")

    ; ______
    if(false){
    }else if(1 && isEditorExist_AHKStudio){
        ; 28.09.2018 15:48 2,6 MB opens with error warnings
        ; i got problems relacing some with umlaute (ue) 29.09.2018 12:04
        runString = AHK-Studio.ahk "%m1CorrectedAhkFileAddress%"
        ;Msgbox,% runString " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        ;Pause
        run,% runString, ..\AHK-Studio
    }else if(1 && isEditorExist_AutoGUI){ ; fallback
        ; 28.09.2018 15:48 6,1 MB opens without error warnings
        runString = AutoGUI.ahk "%m1CorrectedAhkFileAddress%"
        run,% runString, ..\AutoGUI
        return true
    }else if(1){ ; fallback
        runString = notepad "%m1CorrectedAhkFileAddress%"
        run,% runString
        return true
    }

    ; a_Piratenpad_Google_Chrome.ahk ahk_class #32770
    ToolTip,winWait `n (%A_LineFile%~%A_LineNumber%)
    SetTitleMatchMode,1
    winTitleError := m1ListFileName " ahk_class #32770"

;________ __
; ms Msgbox,(`%A_LineFile`%~`%A_LineNumber`%)
; Msgbox,(`%A_LineFile`%~`%A_LineNumber`%)

    SetTitleMatchMode,2
    winTitleError := ".ahk ahk_class #32770"
    winWait,% winTitleError,,3 ; Co_Mozilla_Firefox.ahk ahk_class #32770 ; mouseWindowTitle=0x2970f44  ;
    ifwinnotexist,% winTitleError
    {
        Msgbox,:( not expected by using ahk-studio 28.09.2018 09:36 `n its not a critical issue `n winnotexist %winTitleError% `n (%A_LineFile%~%A_LineNumber%)
        return true
    }
    wingettext,winText,  % winTitleError
    ToolTip,
    ; should consist: "Error: This line does not contain a recognized action."
    errorText := "This line does not contain a recognized action."
    if(!Instr(winText,errorText))
        return true
    loop,20
    {
        winclose,% winTitleError ; thats disturbing opening ahk-studio. if closed ahk-studio opens
        winkill,% winTitleError ; thats disturbing opening ahk-studio. if closed ahk-studio opens
        winWaitClose,% winTitleError,,1
        ifwinnotexist,% winTitleError
            break
        sleep,100
        wingettext,winText,  % winTitleError
        if(!Instr(winText,errorText))
            break

        ; winkill is needet. winclose dont work 26.09.2018 07:37
        ; msgbox,% m1ListFileName " ahk_class #32770 ??? "  ; thats disturbing opening ahk-studio. if closed ahk-studio opens
    }
    msg=%runString% `n %m1% `n deprecated: `n please open by using AHK-Studio instead run`n
    loop,20
    {
        winclose,% winTitleError ; thats disturbing opening ahk-studio. if closed ahk-studio opens
        winkill,% winTitleError ; thats disturbing opening ahk-studio. if closed ahk-studio opens
        winWaitClose,% winTitleError,,1
        ifwinnotexist,% winTitleError
            break
        sleep,100
        wingettext,winText,  % winTitleError
        if(!Instr(winText,errorText))
            break

        ; winkill is needet. winclose dont work 26.09.2018 07:37
        ; msgbox,% m1ListFileName " ahk_class #32770 ??? "  ; thats disturbing opening ahk-studio. if closed ahk-studio opens
    }
    msg=%runString% `n %m1% `n deprecated: `n please open by using AHK-Studio instead run`n
    ;msgbox, % msg "`n" A_LineNumber   " "   A_LineFile   " "   Last_A_This
    ToolTip5sec(msg A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This)
    return true
}
;>>>>>>>> openInEditor >>>> 18101115}417 >>>> 01.1.218 11:54:17 >>>>

; #Include %A_ScriptDir%\inc_ahk\copy2clipBoard.functions.inc.ahk
#Include %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec_RemoveToolTip.inc.ahk
#Include %A_ScriptDir%\inc_ahk\ToolTipSec.inc.ahk
; #Include %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk

