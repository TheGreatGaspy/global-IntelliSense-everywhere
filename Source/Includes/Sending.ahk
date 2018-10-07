﻿; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil
SendKey(Key){
   IfEqual, Key, $^Enter
   {
      Key = ^{Enter}
   } else IfEqual, Key, $^Space
   { 
      Key = ^{Space}
   } else {
      Key := "{" . SubStr(Key, 2) . "}"
   }
   
   SendCompatible(Key,1)
   Return
}

;------------------------------------------------------------------------

getLineOfIndex(id) {
  global g_SingleMatch
    ;~ erste zeile mit eintrag im wörterbuch: g_SingleMatch[1] 10.07.2017 12:13
  global ActionListFileName
  global ActionList
  ;ActionListFileName = ActionList.txt
  ActionListFileName := ActionList
  if(!FileExist(ActionListFileName))
    Msgbox,:( `n (%A_LineFile%~%A_LineNumber%) )

    Loop, Read, %ActionListFileName%
    {
        if ErrorLevel
            break

        if ( id == A_Index  ) {
            ;msgBox, %A_LoopReadLine% 18-03-02_09-26
            ;tooltip,'%A_LoopReadLine%' = A_LoopReadLine `n (line:%A_LineNumber%)
            ;ToolTip1sec(A_LoopReadLine . "`n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " .    Last_A_This)
            return, A_LoopReadLine
            return, JEE_StrUtf8BytesToText( A_LoopReadLine ) ; dont need this anymore. if anybody using utf. 07.10.2018 19:49 18-10-07_19-49
            return A_Index
         }
    }
    ; MsgBox, '%ActionListFileName%' = ActionListFileName  n (line:%A_LineNumber%) n `n The end of the file has been reached or there was a problem.
    return

}
getWordIndex(word) {
  global g_SingleMatch
    ;~ erste zeile mit eintrag im wörterbuch: g_SingleMatch[1] 10.07.2017 12:13
  global ActionListFileName
  global ActionList
  ;ActionListFileName = ActionList.txt
  ActionListFileName := ActionList
  if(!FileExist(ActionListFileName))
    Msgbox,:( `n (%A_LineFile%~%A_LineNumber%) )

    Loop, Read, %ActionListFileName%
    {
        if ErrorLevel
            break

        foundPos := RegExMatch(A_LoopReadLine, "^" . word )
        if ( foundPos  ) {
            ;msgBox, %A_LoopReadLine% 18-03-02_09-26
            ;tooltip,'%A_LoopReadLine%' = A_LoopReadLine `n (line:%A_LineNumber%)
            ;ToolTip1sec(A_LoopReadLine . "`n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " .    Last_A_This)
            return A_Index
         }
    }
    ; MsgBox, '%ActionListFileName%' = ActionListFileName  n (line:%A_LineNumber%) n `n The end of the file has been reached or there was a problem.
    return
}






getLineOfWord(word) {
  global g_SingleMatch
  ;~ global g_SingleMatchReplacement

;~ erste zeile mit eintrag im wörterbuch: g_SingleMatch[1] 10.07.2017 12:13
;~ letzte zeile mit eintrag im wörterbuch: g_SingleMatch[1] 10.07.2017 12:13

  global ActionListFileName
  global ActionList
  ;ActionListFileName = ActionList.txt
  ActionListFileName := ActionList
  if(!FileExist(ActionListFileName))
    Msgbox,:( `n (%A_LineFile%~%A_LineNumber%) )

    Loop, Read, %ActionListFileName%
    {
        if ErrorLevel
            break

        foundPos := RegExMatch(A_LoopReadLine, "^" . word )
        if ( foundPos  ) {
            ;msgBox, %A_LoopReadLine% 18-03-02_09-26
            ;tooltip,'%A_LoopReadLine%' = A_LoopReadLine `n (line:%A_LineNumber%)
            ;ToolTip1sec(A_LoopReadLine . "`n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " .    Last_A_This)
            return, JEE_StrUtf8BytesToText( A_LoopReadLine )
            ; return A_Index
         }
        }

    if(0)
    Loop,9999
    {
        FileReadLine, thisLine , %ActionListFileName%, %A_Index%
        if ErrorLevel
            break

        foundPos := RegExMatch(thisLine, "^" . word )
        if ( foundPos  ) {
            ;msgBox, %thisLine% 17-07-10_13-28
            ;tooltip,'%thisLine%' = thisLine  `n (line:%A_LineNumber%)
            ;ToolTip1sec(thisLine . "`n" . A_LineNumber . " " .  RegExReplace(A_LineFile,".*\\")  . " " .    Last_A_This)
            return, thisLine
            return a_index
         }
    }
    ; MsgBox, '%ActionListFileName%' = ActionListFileName  n (line:%A_LineNumber%) n `n The end of the file has been reached or there was a problem.
return



firstLine := g_SingleMatch[1]

  word = Trim
  loop,9999
  {
    if(!g_SingleMatch[a_index]){
        aindexBackup := a_index
       break
    }
    thisLine := g_SingleMatch[a_index]
    foundPos := RegExMatch(thisLine, word )
    if ( foundPos  ) {
        msgBox, %thisLine% 170710_1328
        return a_index
     }
  }
  msgbox, :-( 10.07.2017 13:33
  return
  ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  if(false){
  loop,9999
  {
    if(!g_SingleMatch[a_index]){
        aindexBackup := a_index
       break
    }
  }
  lastMatchingWord := g_SingleMatch[A_Index-1] ; for e.g. 6 if you hit "___" 10.07.2017
  send, % "17-07-10_12-21 index= " . aindexBackup . " = " . lastMatchingWord
  }
  ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
  if(false){ ; funktioniert nicht, noch nicht. egal 10.07.2017 13:15. keie Zeit
  global g_ActionListDB
  loop,9999
  {
    if(!g_ActionListDB[a_index]){
        aindexBackup := a_index
       break
    }
  }
  lastWord := g_ActionListDB[A_Index-1] ; for e.g. 6 if you hit "___" 10.07.2017

;~   select = SELECT id FROM Words WHERE word ="%word%" ;
    StringReplace, SearchValueEscaped, word, ', '', All
    global g_ActionListID
  where := " AND ActionListID = '" g_ActionListID "' "
  select := "SELECT * FROM Words WHERE word LIKE '" . SearchValueEscaped . "%' " where
  select := "SELECT * FROM Words WHERE word LIKE 'Trim%' " where
  select := "SELECT * FROM Words WHERE word = 'Trim(String)' " where
  msgbox, '%select%' = select  n (line:%A_LineNumber%) n
  ; ______________________' ' = SearchValue  n (line:69) n17-07-10_12-21 index= 1
  table := g_ActionListDB.Query( select )
 g_ActionListDB.BeginTransaction()
 For each, row in myTable.Rows
 {
    SearchValue0 := row[0]
    SearchValue := row[1]
    Msgbox,'%SearchValue%' = SearchValue  n (line:%A_LineNumber%) n
 }
 g_ActionListDB.EndTransaction()
; ____' ' = SearchValue  n (line:68) n17-07-10_12-21 index= 1
; ____ ____' ' = SearchValue  n (line:67) n17-07-10_12-21 index= 1
; send,'%SearchValue0% %SearchValue%' = SearchValue  n (line:%A_LineNumber%) n
; ________'' = SearchValue  n (line:66) n17-07-10_12-21 index= 1
; ___ __' ' = SearchValue  n (line:68) n17-07-10_12-21 index= 1
  send, % "17-07-10_12-21 index= " . aindexBackup . " = " . lastWord
    }
  ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
return
}
; __17-07-10_12-21 index= 6 __ __17-07-10_12-21 index= 6
; ___17-07-10_12-21 __17-07-10_12-21  ___17-07-10_12-21 index= 0
; ___17-07-10_12-21 index= 1
; ____17-07-10_12-21 index= 1











SendWord(WordIndex){
   global g_SingleMatch
   global g_SingleMatchReplacement

    global ActionList

ActionListFolderOfThisActionListRELATIVE := RegExReplace(ActionList,"\\[^\\]+$","")
ActionListFolderOfThisActionList := A_ScriptDir  "\" RegExReplace(ActionList,"\\[^\\]+$","")
ActionListFolderOfThisActionList := removesSymbolicLinksFromFileAdress(ActionListFolderOfThisActionList) ; user should could includes direcly from his ahk ActionList, without editing the address 05.03.2018 08:15
if(!FileExist(ActionListFolderOfThisActionList)){ ; Checks for the existence of a file or folder
clipboard := ActionListFolderOfThisActionList
    tooltip,ups:`n ! FileExist(%ActionListFolderOfThisActionList% `n (%A_LineFile%~%A_LineNumber%)
    return false
}


disableCopyQ() ; enableCopyQ() ;
   ; getWordIndex("__")

   ;Send the word
   if (g_SingleMatchReplacement[WordIndex]){
      sending := g_SingleMatchReplacement[WordIndex]
      sending := g_SingleMatchReplacement[WordIndex]
      ForceBackspace := true
   } else {
      sending := g_SingleMatch[WordIndex]
      ForceBackspace := false
   }

; sending := "getCorrectedStringUAOSS1==" getCorrectedStringUAOSS( sending  )

; sending := getCorrectedStringUAOSS( sending  ) ; https://autohotkey.com/boards/viewtopic.php?f=5&t=44955&p=203512&hilit=JEE_StrUtf8BytesToText#p203512
if(false){
    Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)

    sending := "JEE_StrTextToUtf8Bytes" JEE_StrTextToUtf8Bytes( sending )
    sending := getCorrectedStringUAOSS( sending  )
    Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)

    sending := JEE_StrUtf8BytesToText( sending ) ; https://autohotkey.com/boards/viewtopic.php?f=5&t=44955&p=203512&hilit=JEE_StrUtf8BytesToText#p203512
    sending := getCorrectedStringUAOSS( sending  )
    Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)

    sending := "getCorrectedStringUAOSS" getCorrectedStringUAOSS( sending  )
    sending := getCorrectedStringUAOSS( sending  )
    Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)

    sending := getCorrectedStringUAOSS( sending  )
    Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)

    sleep,150
     ;MsgBox, % vText := JEE_StrUtf8BytesToText(vUtf8Bytes)
}

; sending := "getCorrectedStringUAOSS2==" getCorrectedStringUAOSS( sending  )
; sending = %sending%
; sending := getCorrectedStringUAOSS( sending  )

;Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)
; ein eineins|rr|zwei|ahk|autohotkey source code
; eins|rr|zwei|ahk|autohotkey source code
; thats great :) here we find the complete line :) inside sending 17.03.2017 18:23 17-03-17_18-23
 ; SciTEWindow\_global.txt
 ;~ Msgbox,'%WordIndex%' = WordIndex  `n (%A_LineFile%~%A_LineNumber%)
;Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; comments to WordIndex is numeric ID
;~ Msgbox, % g_Match[WordIndex] ; thats empty. nicht interessant 10.07.2017 10:49
;~ Msgbox, % g_SingleMatch[WordIndex] ; that only gets the text bofore the pipe | z.B. bei open|rr||ahk|run ....txt you get "open" 10.07.2017 10:53
;~ Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)
;~ sending = complete line z.B. bei open|rr||ahk|run ....txt you get "open|rr||ahk|run ....txt" 10.07.2017 10:53

; getWordIndex("Trim")
;
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;global g_Word
;Msgbox, % g_Word[2] ; ; i dont know what this is. most of time its emptty . rght? 10.07.2017 14:06
;  Msgbox, % g_SingleMatchReplacement[WordIndex] ; thats only the text behind the pipe |
; ________SciTEWindow\_global.txt
; zwei
; Msgbox, '%sending%' = sending  n (line:%A_LineNumber%)  (line:%A_LineNumber%)
AHKcode := "" ; AHKcode2 .= ... AHKcode ... so later its in AHKcode2
doSendSpacesInAHKslow := false
doSendSpaceSlow := true
isAHKcode := false
WinGetActiveTitle, activeTitle

if (g_SingleMatch[WordIndex]) {

; ToolTip2sec|rr|ToolTip2sec|ahk|strlen(m) `n ....
; eins|rr|zwei|ahk|autohotkey source code

; regIsAHKcode := "^([^\|]+?)\|rr\|(.*?)\|ahk\|(.*?)$"
regIsAHKcode := "^([^\|\n]+?)\|rr\|([^\n]*?)\|ahk\|([^\n]*?)$"
regIsKTScode := "^([^\|\n]+?)\|rr\|([^\n]*?)\|kts\|([^\n]*?)$"
regIsXXXcode := "^([^\|\n]+?)\|(rr)\|([^\n]*?)\|(ahk|kts)\|([^\n]*?)$"
regIsXXXcode := "^([^\|\n]+?)\|(rr)\|([^\n]*?)(?:\|(ahk|kts)\|)*([^\n]*?)$"
regIsXXXcode := "^([^\|\n]+?)\|(rr)\|(?:([^\n]*?)(?:\|(ahk|kts)\|)+([^\n]*?)$)*"
regIsXXXcode := "^([^\|\n]+?)\|(rr)\|(?:([^\n]*?)(?:\|(ahk|kts)\|)+(.*?)$)*" ; since today we using ahk blocks. newline could be posible
; may remember this vor later implementation: ^([^\|\n]+?)(?:\|(rr)\|(?:([^\n]*?)(?:\|(ahk|kts)\|)+([^\n]*?)$)*)*$
; https://regex101.com/r/XvcvV4/3/      https://autohotkey.com/boards/viewtopic.php?f=6&t=45684&p=241492#p241492
;<<<<< tests <<<< 1810106253 <<<< 01.10.2018 6:26:53
; if change regex please dont foget to test synonyms (se,29.09.2018 11:01) :
; key:$1 __ rr:$2 __ send:$3 __ lang:$4 __ code:$5
; keyValue|rr|sendValue|ahk|codeValue
; keyValue|rr||ahk|codeValue
; synonymValue|rr|
; synonymValue|rr||ahk|q=keyValue
; and there are some special commands not listed above
;>>>>>>>> tests >>>> 1810106}722 >>>> 1.1.201 06:27:22 >>>>
; Hallo sendDayTimeHello.ahk|rr||ahk|#incDynAhk\sendDayTimeHello.ahk

; ;<<<<<<<< playground <<<< 1810100213 <<<< 01.10.2018 <<<<
; ToolTip5sec(A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
; Msgbox,% "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
;>>>>>>>> playground >>>> 18101080}49 >>>> 01.10.2018  >>>>

; rX := {key:m1, rr:m2, send:"", lang:"" ,code:""}
regIsSynonym := "^([^\|\n]+?)\|(rr)\|$"

lineOfIndex := g_SingleMatch[WordIndex]
; lineOfIndex := "hoHi|rr|"

foundPosSynonym := RegExMatch( lineOfIndex , regIsSynonym ,  m )

if(0){
tip=
(
    %regIsSynonym% = regIsSynonym
    >%foundPosSynonym%< = RegExMatch( lineOfIndex , regIsSynonym )
    >%lineOfIndex%< = lineOfIndex
    %A_LineFile%~%A_LineNumber%
)
tip .= g_SingleMatch[WordIndex] " = g_SingleMatch[WordIndex]"
ToolTip3sec(tip)tip
msgbox,% tip
}

; AHKdyn example super simple example
   if(foundPosSynonym){
        rX := {key:m1, rr:m2, send:"", lang:"" ,code:""}

        if(!rX["lang"]){
            tip := "found synonym `n ("   A_LineFile " ," A_LineNumber  ") "
            ToolTip3sec( tip )
            ; msgbox, % tip
            id := getWordIndex(m1)
            while(!rX["code"] && id>1){
                id -= 1
                lineOfIndex := getLineOfIndex(id)
                ; dayTimeHello.ahk|rr|
                RegExMatch( lineOfIndex , regIsXXXcode  ,  m )
                rX := {key:m1, rr:m2, send:m3, lang:m4 ,code:m5}

                if(!rX["rr"]){
                    tip=%lineOfIndex% `n
                    tip .= "`n regIsXXXcode= " rX["regIsXXXcode"] "`n key= " rX["key"] "`n rr= " rX["rr"] " `n send= " rX["send"] " `n lang= " rX["lang"] " `n code= " rX["code"]
                    ;Msgbox,% " `n" tip "`n no code tag inside `n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                    ;ToolTip3sec(tip)
                    sending := lineOfIndex
                    ;MsgBox,% rX["key"] "#" rX["rr"] "#" rX["send"]  "#" rX["code"] "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                    ;pause

                    break ; no code tag inside
                }
                if(rX["code"]){
                        tip=%lineOfIndex% `n (%A_LineFile%~%A_LineNumber%)
                        ToolTip3sec(tip)
                        ;Msgbox,% "code inside `n(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                        break ; code inside
   }    }   }   }



; AHKdyn example super simple example
   ; if(RegExMatch( sending , ereg ,  m )) {
   if(rX["code"] || RegExMatch( lineOfIndex , regIsXXXcode ,  m )) {
        rX := {key:m1, rr:m2, send:m3, lang:m4 ,code:m5}

if(false){
tip:= "key= " rX["key"] " `n send= " rX["send"] " `n(" A_LineNumber ")"
clipboard:=tip
tooltip,% tip
msgbox,% tip
}
        if(!rX["code"]){
            ToolTip3sec("found synonym `n ("   RegExReplace(A_LineFile,".*\\")  " ," A_LineNumber  ") "   )
            id := getWordIndex(m1)
            while(!rX["code"] && id>1){
                id -= 1
                lineOfIndex := getLineOfIndex(id)
                RegExMatch( lineOfIndex , regIsXXXcode ,  m )
                m := {key:m1, rr:m2, send:m3, lang:m4 ,code:m5}
            }
        }
        StringLower, mlang, % rX["lang"]
        rX["lang"] := mlang
        if(rX["lang"] == "ahk"){
            isAHKcode := true
            AHKcode := rX["code"]
        }
        if(rX["lang"] == "kts"){
            isKTScode := true
            KTScode := rX["code"]
        }


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; enable to use quellenangaben in ahk pseudo code.
; Beispiel: synonyms
;~ indirect hello AHKdyn Example|rr||ahk|q=indirect3
; synonymValue|rr||ahk|q=keyValue
;~ indirect3|rr|indirect3 hello :-) 10.07.2017 14:27|ahk|

; indirect3 hello :-) 10.07.2017 14:27



if(isAHKcode){
    isStartingUnderline := ("___" == substr( lineOfIndex , 1, 3 ) )
    is_OpenA_edit_open_lib := RegExMatch( " " lineOfIndex , "i)(edit|open|lib)" )
    isDeprecated_OpenA_edit_open_lib := ( isAHKcode && isStartingUnderline && is_OpenA_edit_open_lib && RegExMatch( AHKcode , "^\s*(?:run)\s*,?(.+\.ahk)\s*$" ,  m ))
    ; msgbox, % isAHKcode "`=isAHKcode`n`n " lineOfIndex "`n=lineOfIndex`n`n is_OpenA_edit_open_lib=`n" is_OpenA_edit_open_lib " `n`n isDeprecated_OpenA_edit_open_lib=`n" isDeprecated_OpenA_edit_open_lib "`n`n" AHKcode

    ; Msgbox,% AHKcode "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    was_a_Editor_open_command := openInEditor(ActionListFolderOfThisActionList, isAHKcode, AHKcode, isStartingUnderline, is_OpenA_edit_open_lib, isDeprecated_OpenA_edit_open_lib)
    if(was_a_Editor_open_command)
        return
} ; Endof if(isAHKcode)

   if(isAHKcode && !AHKcode){
        ahkBlock := ""
        lineOfIndex := g_SingleMatch[WordIndex]
        id := getWordIndex(lineOfIndex)
        key := rX["key"]
        wordIndexOfKey := getWordIndex(key)
        id := wordIndexOfKey
        while(id++ < 12345678 ){ ; 123456789 is random top numer. not importand 07.10.2018 18:50
            line := getLineOfIndex(id)
            if(!line)
                break
            ahkBlock .= line "`n"
            ;ToolTip4sec(line " (" A_LineNumber " " RegExReplace(A_LineFile,".*\\") " " Last_A_This)
            ; MsgBox,% id ": " line " rX[key]= " rX["key"] "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
        }
         AHKcode := ahkBlock
        ; msg := " ahkBlock = `n `n " ahkBlock
        ; MsgBox,% msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
   }


    ; tooltip ,% AHKcode "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
    ; msgbox ,% "sending=" sending "`n" AHKcode "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"





   if(isAHKcode && RegExMatch( AHKcode , "^\s*q=\s*(.+)\s*$" ,  m ) ) { ; q=
        line := getLineOfWord( m1 ) ; that works :) 10.07.2017 14:18
        ; line := getCorrectedStringUAOSS( getLineOfWord( m1 )) ; that works :) 10.07.2017 14:18
        isAHKcode := false
        if(RegExMatch( line , regIsAHKcode ,  m )) { ; repeat / overwrite last regex 10.07.2017 14:24
         isAHKcode := true
         AHKcode := rX["code"]
        }else{
         ;sending := line
         sending := RegExReplace(line, "i).*\|r\|(.*)", "$1") ; i know thats not redundanct. todo: do better reduaant style 10.07.2017 15:31
      }


    }
    ; ___ __ thats a simple simpleHello thats a simple simpleHello thats a simple simpleHello
    ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

if(false){
tip:= "key= " rX["key"] " `n send= " rX["send"] " `n(" A_LineNumber ")"
clipboard:=tip
tooltip,% tip
msgbox,% tip
}

; msgbox, '%line%' = line  n (line:%A_LineNumber%) n
; __asdkjfhsdf
if(isAHKcode || isKTScode)
    sending :=  rX["send"]
if(false){
    tip:= "key= " rX["key"] " `n send= " rX["send"] " `n(" A_LineNumber ")"
clipboard:=tip
tooltip,% tip
msgbox,% tip
}
    ;sleep,3000
;    Msgbox, '%sending%' = sending  `n `n AHKcode = %rX["send"]% (line:%A_LineNumber%)
; (A_LineNumber   " "   A_LineFile   " "   Last_A_This)



   }else
   if( doSendSpaceSlow && substr( lineOfIndex, 1 , 2 ) != "__" && RegExMatch( activetitle , "\.(json|ts|css|html) - PhpStorm" ) ) {
       isAHKcode := true
       doSendSpacesInAHKslow := true
       sending := "" ; thats very fast. may use it in other casese 10.04.2017 13:29
       AHKcode := lineOfIndex

       ; lets open the ActionList inside notepad++ or so 19.04.2017 19:16
;       Msgbox,'%ActionListActive%' = ActionListActive  n (line:%A_LineNumber%) n   n (from: %A_LineFile%~%A_LineNumber%)
; Msgbox,n (from: %A_LineFile%~%A_LineNumber%)


    }
}




   ; Update Typed Count
   UpdateWordCount(sending,0)
   ;if( !isAHKcode )

if( doSendSpacesInAHKslow == false )
    SendFull(sending, ForceBackspace)

   ; thats behind sending
         ; thats great :) here we find the complete line :) inside sending 17.03.2017 18:30 17-03-17_18-30
   ;   Msgbox, '%sending%' = sending  n (line:%A_LineNumber%) n
; Msgbox, '%AHKcode%' = AHKcode `n (line:%A_LineNumber%)



if(false){
    Clipboard = %AHKcode%
    msgbox, %AHKcode%
}

    ;msgbox, isAHKcode = %isAHKcode%AHKdyn example super simple example

; https://github.com/sl5net/global-IntelliSense-everywhere/blob/master/Source/help/CHANGELOG.txt#L1 05.03.2018 10:40
aScriptDir2ActionListFolder := removesSymbolicLinksFromFileAdress(A_ScriptDir "\..\ActionLists") ; user should could includes direcly from his ahk ActionList, without editing the address 05.03.2018 08:15
;msgbox, aScriptDir2ActionListFolder  = %aScriptDir2ActionListFolder%  `n (%A_LineFile%~%A_LineNumber%)
;exitapp\

if( isKTScode ){
    ; "E:\fre\private\HtmlDevelop\AutoHotKey\global-IntelliSense-everywhere\ActionLists\_kts\kotlinc\bin\kotlinc"
    ;

    fExistCode := FileExist(ActionListFolderOfThisActionList "\" KTScode)
    if(fExistCode){
        scriptAddress := ActionListFolderOfThisActionList "\" KTScode
    }else{
        scriptAddress := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\ActionLists\_kts\KotlinLove.kts" )
        KTScode := RegExReplace(KTScode, "``n" , "`n")
        FileSave(KTScode, scriptAddress )
    }
    resultAddress := removesSymbolicLinksFromFileAdress( A_ScriptDir "\..\ActionLists\_kts\cmdResult2.ahk" ) ; ; %A_Temp%\
    kotlincExeAddress := removesSymbolicLinksFromFileAdress (A_ScriptDir "\..\ActionLists\_kts\kotlinc\bin\kotlinc")
    ; run,cmd.exe /c "%kotlincExeAddress%" -script KotlinLove.kts > cmdResult.txt,, Hide"
    runString = cmd.exe /c "%kotlincExeAddress%" -script %scriptAddress% > %resultAddress%
    run,% runString,, Hide
    ; Clipboard := runString
        ;  ActionLists\_kts\kotlinc\bin\kotlinc""
    ; FileReadLine, thisLine , %A_Temp%\cmdResult.txt, 1
    sleep,100
    FileRead, cmdResult, % resultAddress
    Send,% "{text}" cmdResult
    ; Msgbox,cmdResult = %cmdResult% `n sKTScode = %isKTScode% `n (%A_LineFile%~%A_LineNumber%)
}


;<<<<<<<< isAHKcode <<<< 180315221709 <<<< 15.03.2018 22:17:09 <<<<
   if( isAHKcode ){
   AHKcode2 := ""
; AHKcode2 .= "#" . "NoTrayIcon `n "
AHKcode2 .= "#" "MaxHotkeysPerInterval 99000000 `n "
AHKcode2 .= "#" "HotkeyInterval 99000000 `n "
AHKcode2 .= "SetWorkingDir, " . aScriptDir2ActionListFolder . "`n" ; doesent work has no effect ScriptDir|rr||ahk|send, % A_ScriptDir ; \\.\pipe 03.04.2017 11:17 17-04-03_11-17
AHKcode2 .= "SetBatchLines, -1 `n "
AHKcode2 .= "SetKeyDelay, -1, -1 `n "
AHKcode2 .= "SetWinDelay, -1 `n "
AHKcode2 .= "SetControlDelay, -1 `n "
AHKcode2 .= "Process, Priority,, H `n "

;>>>>>>>> DynaRun >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
FileRead,dynaRunFunctionImplementationSource,dynaRunFunctionImplementationSource.inc.ahk
AHKcode2 .= dynaRunFunctionImplementationSource  . "`n"
;>>>>>>>>>> DynaRun >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


if(0){
    AHKcode2 .= "ActionList = , " . ActionListNEW . "`n" ; i cant do this :D becouse the script cant know this :D 12.08.2017 11:12
    Msgbox,% AHKcode2 . "`n`n = AHKcode2 `n (%A_LineFile%~%A_LineNumber%)"
}
; doesent work has no effect ScriptDir|rr||ahk|send, % A_ScriptDir ; \\.\pipe 03.04.2017 11:17 17-04-03_11-17

startPos := 1
if( false && doSendSpacesInAHKslow )
while( RegExMatch( AHKcode , "mPi)(^[ ]*Send[ ]*,[ ]*)([^\n]+)" , m , startPos ) ) {
    m1 := SubStr(AHKcode, mPos1 ,  mLen1 )
    rX["rr"] := SubStr(AHKcode, mPos2 ,  mLen2 )
    rX["rr"] := RegExReplace(rX["rr"], "([a-z,.\(\)\[\]]) ([a-z,.\(\)\[\]])" , "$1`nSleep,1000`nSend,{space}$2")
    endString := SubStr(AHKcode, mPos2 + mLen2 )
    AHKcode := SubStr(AHKcode, 1 , mPos2 -1 ) . rX["rr"] . endString
    startPos := mPos1 + m - 1
}

if( RegExMatch( activeTitle , "\.(json|ts|css|html) - PhpStorm" ) && substr( lineOfIndex, 1 , 2 ) != "__" ) {
    global g_Word ; thats the beginning of the word user already typed. 27.04.2017 18:52
    AHKcode := getRealisticDelayDynamicSendAHKcode(g_Word,AHKcode)
}

; https://github.com/sl5net/global-IntelliSense-everywhere/blob/master/Source/help/CHANGELOG.txt#L1
;AHKcode := RegExReplace(AHKcode, "#include[ ]*,[ ]*(\w)"           , "#include " . aScriptDir2ActionListFolder . "\\$1" ) ; dayTimeHello|rr||ahk|#include,incDynAhk\sendDayTimeHello.ahk
;AHKcode := RegExReplace(AHKcode, "#include[ ]*,[ ]*([\.]{1,2}\\\w)", "#include " . aScriptDir2ActionListFolder . "\\$1" ) ; dayTimeHello|rr||ahk|#include,..\xyz\sendDayTimeHello.ahk
; AHKcode := RegExReplace(AHKcode, "#include[ ]+([\.]{1,2}\\\w)", "#include " . aScriptDir2ActionListFolder . "\\$1" ) ; dayTimeHello|rr||ahk|#include ..\xyz\sendDayTimeHello.ahk

; ___create own project dir or this 1|rr||ahk|#Include,..\activeClassManipulation.inc.ahk `n activeClass := RegExReplace( activeClass, "[\W_]+", "") `n d1
;
regEx := "i)(http|https):"
regEx2 := "(#include|run)[ ]*( |,)[ ]*\b(?!\w\:\\)" ; should not work with thinks like: ; run, C:\tata only relative paths 8.5.2018 14:27 , see: https://www.regextester.com/15
regEx2 := "(#include|run)[ ]*( |,)[ ]*(?!( |\w:\\))" ; should not work with thinks like: ; run, C:\tata only relative paths 8.5.2018 14:27 , see: https://www.regextester.com/15
if(!RegExMatch(AHKcode, regEx))
    AHKcode := RegExReplace(AHKcode, "i)" regEx2, "$1$2$3" . ActionListFolderOfThisActionList . "\" ) ; dayTimeHello|rr||ahk|#include ..\xyz\sendDayTimeHello.ahk
;    AHKcode := RegExReplace(AHKcode, "i)(#include|run)[ ]*( |,)[ ]*(?!\w\:\\)", "$1$2" . ActionListFolderOfThisActionList . "\" ) ; dayTimeHello|rr||ahk|#include ..\xyz\sendDayTimeHello.ahk



;clipboard := AHKcode
;Msgbox,%AHKcode%`n = AHKcode (%A_LineFile%~%A_LineNumber%) 

; AHKcode := RegExReplace(AHKcode, "#include[ ]*,[ ]*(\w)", "#include \\$1" ) ; dayTimeHello|rr||ahk|#include,incDynAhk\sendDayTimeHello.ahk
; AHKcode := RegExReplace(AHKcode, "#include[ ]*,[ ]*[\.]{0,2}\\(\w)", "#include \\$1" ) ; dayTimeHello|rr||ahk|#include,incDynAhk\sendDayTimeHello.ahk
StringReplace, AHKcode, AHKcode, `%A_ScriptDir`%, %aScriptDir2ActionListFolder%, All
StringReplace, AHKcode, AHKcode, `%A_WorkingDir`%, %A_WorkingDir%, All ; in some context its not neccasarry becouse its set ... 12.08.2017 11:22
; A_ScriptDir == A_WorkingDir is proably the same !! should be in this case :) 12.08.2017 11:26

; StringReplace, AHKcode, AHKcode, #incDynAhk, #include %A_ScriptDir%\incDynAhk, All ; dayTimeHello|rr||ahk|#incDynAhk\sendDayTimeHello.ahk ; before 09.03.2018 11:03
 StringReplace, AHKcode, AHKcode,#incDynAhk,#include %ActionListFolderOfThisActionList%\incDynAhk, All ; dayTimeHello|rr||ahk|#incDynAhk\sendDayTimeHello.ahk



;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; todo: howto insert  a newwline text sign into te output 19.04.2017 21:01 ? not solved :(
; msgbox, '%AHKcode%' = AHKcode  n (line:%A_LineNumber%) n
AHKcode2 .= RegExReplace(AHKcode, "([^``])``n", "$1`n") ; ; thats we really need. the only chance to get newline inside the source code
AHKcode2 .= "`n exitApp"
; msgbox, '%AHKcode2%' = AHKcode2  n (line:%A_LineNumber%) n
; abc abc n
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

; AHKcode2  = RegExReplace(AHKcode2 , "%A_ScriptDir%", A_ScriptDir)
if(0){
    clipboard := AHKcode2
    msgbox, % AHKcode2
}
       global g_sending_is_buggy
       if( g_sending_is_buggy )
           lll(A_LineNumber, A_LineFile, "send, `n 17-07-29_11-47")

        ;msgbox,(%A_LineFile%~%A_LineNumber%) `n %AHKcode2%
        aWorkingDirBackUp := A_WorkingDir
        SetWorkingDir,%A_WorkingDir%\..\ActionLists
         ; suspend,on ; if you do thi script sends nothing 13.03.2018 15:30
       DynaRun(AHKcode2)
        ; suspend,off
        SetWorkingDir,%aWorkingDirBackUp%
   }
   ;>>>>>>>> isAHKcode >>>> 180315221926 >>>> 15.03.2018 22:19:26 >>>>

   ClearAllVars(true)
   ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
   ; the following code was addet by Http://SL5.net 11.03.2017 17:54 17-03-11_17-54 . have fin & enjoy
   sending:=trim( sending )
   if(RegExMatch( sending , "^[^\s]+(\\[^\\\s]+\\[^\\\s]+\.ahk)$", SubPat) ) ; stores in SubPat1. 30.04.2017 12:24 is that buggy ? correct? todo:
        absActionListAddress = %aScriptDir2ActionListFolder%\..\%sending%
        ; Msgbox,%absActionListAddress% = absActionListAddress `n (from: %A_LineFile%~%A_LineNumber%)
        fExistWL := FileExist(absActionListAddress)
        fExist := FileExist(sending)
        ; InStr(FileExist("C:\My Folder"), "D") would be true only if the file exists and is a directory.
      if((fExist && InStr(FileExist(fExist), "D"))  || (fExistWL && InStr(FileExist(fExistWL), "D"))  ) {
         ;~ hint := "... " . SubStr( sending, 60 ) 
         Sleep,1000
         MsgBox, 4, Open library? (id=1703171452) , would you open your library file? (Press YES or NO) `n `n ... %SubPat1% ; this window will not closed by reloading couse of his idetify code (1703171452). See in source below. 17-03-17_15-00
    IfMsgBox yes
        if(fExist)
            ; run, %sending%
            openInEditor("..\ActionLists\" . ActiveClass, true, "run," sending, true, true, true)
        else
             ; run, %absActionListAddress%
             openInEditor("..\ActionLists\" . ActiveClass, true, "run," absActionListAddress, true, true, true)
                 ;Msgbox,%absActionListAddress% `n (from: %A_LineFile%~%A_LineNumber%)

      }

;
   ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    unpressAllPressedKeys() ; addet at 05.04.2018 13:13

   enableCopyQ() ;


   if(isAHKcode){
        regExPattern = g_config\["list"\]\["change"\]\["stopRexExTitle"\]\s*:=\s*([^\n]*)\s*
      foundPos := RegExMatch( AHKcode , regExPattern ,  matchs )
      if(foundPos) {
        tooltip,found `n change list automatically = `>%matchs1%< `n(" A_LineNumber ")"
        ; matchs1 := Trim(matchs1, """")
        matchs1debuginfo := Trim(matchs1, """")
        ; g_config["list"]["change"]["stopRexExTitle"]:=true
        ;WinWaitNotActive,A,,9
        WinWaitNotActive,A,,5
        ;sleep,7777 ; needs maybe time to read changed title or so. script is triggerd by title changes

        g_config["list"]["change"]["stopRexExTitle"] := ( RegExMatch(matchs1,"i)^\s*(false|"")\s*$" ) ) ? false : Trim(matchs1, """")
        ; g_config["list"]["change"]["stopRexExTitle"] := ! g_config["list"]["change"]["stopRexExTitle"]
        ; msgbox,found >%matchs1%<  >%matchs1debuginfo%< 18-04-30_11-46 `n(" A_LineNumber ")"
      }
   }


   Return
}  
;------------------------------------------------------------------------

unpressAllPressedKeys(){

    SetCapsLockState,Off
    SetScrollLockState,Off ; Im Übrigen reagieren nur noch einige Uralt-Programme, etwa Word 5 für DOS, auf diese Taste. Damit bietet sie sich als idealer Kandidat

    ; Unpress All Pressed Keys
    KeyList := "Capslock|Shift|Ctrl|Alt" ; and so on
    Loop, Parse, KeyList, |
    {
        If GetKeystate(A_Loopfield, "P")
            Send % "{" A_Loopfield " Up}"
    }
    return
}


SendFull(SendValue,ForceBackspace:= false){
   global g_Active_Id
   global g_Word
   global prefs_AutoSpace
   global prefs_NoBackSpace
   global prefs_SendMethod

   global g_doUseSendPlay

   SwitchOffListBoxIfActive()
   
   BackSpaceLen := StrLen(g_Word)
   
   if (ForceBackspace || prefs_NoBackspace = "Off") {
      BackSpaceWord := true
   }
    ;  BackSpaceWord := false ; test 27.04.2017 18:40

;<<<<< Capitalize := false 13.08.2017 14:05 17-08-13_14-05 sl5 <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if("Capitalize := false")
    Capitalize := false
else {
   ; match case on first letter if we are forcing a backspace AND CaseCorrection is off
   if (ForceBackspace && !(prefs_NoBackspace = "Off")) {
      IfEqual, A_IsUnicode, 1
      {
         if ( RegExMatch(Substr(g_Word, 1, 1), "S)\p{Lu}") > 0 )  
         {
            Capitalize := true
         }
      } else if ( RegExMatch(Substr(g_Word, 1, 1), "S)[A-ZÀ-ÖØ-ß]") > 0 )
      {
         Capitalize := true
      }
}
;>>>>>>>>>>>>>>>>>>>>  Capitalize := false 13.08.2017 14:05 17-08-13_14-05 sl5  >>>>>>>>>>>>>>>>>>>>>>>>>>
      
      StringLeft, FirstLetter, SendValue, 1
         StringTrimLeft, SendValue, SendValue, 1
      if (Capitalize) {
         StringUpper, FirstLetter, FirstLetter
      } else {
         StringLower, FirstLetter, FirstLetter
      }
      SendValue := FirstLetter . SendValue
   }


   ; if the user chose a word with accented characters, then we need to
   ; substitute those letters into the word
   StringCaseSenseOld := A_StringCaseSense
   StringCaseSense, Locale   
   if (!BackSpaceWord && !(SubStr(SendValue, 1, BackSpaceLen) = g_Word)) {
      BackSpaceWord := true
      
      SendIndex := 1
      WordIndex := 1
      NewSendValue =
      While (WordIndex <= BackSpaceLen) {
         SendChar := SubStr(SendValue, SendIndex, 1)
         WordChar := SubStr(g_Word, WordIndex, 1)
         SendIndex++
         
         if (SendChar = WordChar) {
            WordIndex++
            NewSendValue .= WordChar
         } else {
            
            SendCharNorm := StrUnmark(SendChar)
            ; if character normalizes to more than 1 character, we need
            ; to increment the WordIndex pointer again
            
            StringUpper, SendCharNormUpper, SendCharNorm
            StringLower, SendCharNormLower, SendCharNorm
            StringUpper, SendCharUpper, SendChar
            StringLower, SendCharLower, SendChar
            WordChar := SubStr(g_Word, WordIndex, StrLen(SendCharNorm))
            
            if (SendCharNorm == WordChar) {
               NewSendValue .= SendChar
            } else if (SendCharNormUpper == WordChar) {
               NewSendValue .= SendCharUpper
            } else if (SendCharNormLower == WordChar) {
               NewSendValue .= SendCharLower
            } else {
               NewSendValue .= SendChar
            }
            WordIndex += StrLen(SendCharNorm)
         }
      }
      
      NewSendValue .= SubStr(SendValue, SendIndex, StrLen(SendValue) - SendIndex + 1)
      
      SendValue := NewSendValue
   }

   StringCaseSense, %StringCaseSenseOld%
   
   ; If we are not backspacing, remove the typed characters from the string to send
   if !(BackSpaceWord)
   {
      StringTrimLeft, SendValue, SendValue, %BackSpaceLen%
   }
   
   ; if autospace is on, add a space to the string to send
   IfEqual, prefs_AutoSpace, On
      SendValue .= A_Space

      ; thats great :) here we find the complete line :) inside sending 17.03.2017 18:30 17-03-17_18-30
;      Msgbox, '%SendValue%' = SendValue  (line:%A_LineNumber%)  (line:%A_LineNumber%)

 ; Msgbox, '%SendValue%' = SendValue  `n '%sending%' = sending `n (line:%A_LineNumber%) n


;~ global g_useRAWsending
;~ if(g_useRAWsending)
;~     Raw:="{Raw}"

   IfEqual, prefs_SendMethod, 1
   {
      ; Shift key hits are here to account for an occassional bug which misses the first keys in SendPlay
        if(g_doUseSendPlay)
          sending = {Shift Down}{Shift Up}{Shift Down}{Shift Up}
      if (BackSpaceWord)
      {
          if(g_doUseSendPlay)
             sending .= "{BS " . BackSpaceLen . "}"
         else{
            
             Send,{Backspace %BackSpaceLen%} ; workaround :) 29.07.2017 12:51 17-07-29_12-51 by sl5net
             ; just tested: words with ahk code goes here 13.03.2018 14:43
        ;lll(A_LineNumber, A_LineFile, "%sending% `n >" . sending . "<  `n token=18-03-13_14-31")
        ;Msgbox,`n (%A_LineFile%~%A_LineNumber%) 
        }
      }
      if(!g_doUseSendPlay){
          sending .= SendValue
     ; just tested: words with ahk code goes here. but sending gets the value1 not the value2 with the script or ahk part 13.03.2018 14:43
        ;lll(A_LineNumber, A_LineFile, "%sending% `n >" . sending . "<  `n token=18-03-13_14-54")
        ; Msgbox,sending `n >%sending%< `n (%A_LineFile%~%A_LineNumber%) 
      }else{
        
          ; sending .= "{Raw}" . SendValue ; till 13.03.2018 14:26
          sending .= "{Text}" . SendValue ; new featrure in version  [v1.1.27+]
        lll(A_LineNumber, A_LineFile, "%sending% `n >" . sending . "<  `n token=18-03-13_14-31")
        Msgbox,`n (%A_LineFile%~%A_LineNumber%) 
          ; Send {Raw}abi `n ^v ; interpretiert  `r, `n, `t and `b usw
            ; Send {Text}baby ^v {Clipboard} ; interpretiert nicht `r, `n, `t and `b usw

        }
if(!g_doUseSendPlay){
     ; just tested: words with ahk code goes here. but sending gets the value1 not the value2 with the script or ahk part 13.03.2018 14:43
    ; SendRaw, %sending% ; used till 13.03.2018 14:51

global g_method
if(g_method == "Clipboard" ){
; HotKey, $^+v, Off ; nonexistend hotkey
;HotKey, $^v, Off ; nonexistend hotkey

    ;DisableKeyboardHotKeys()
;sendClipboard(sending) ; funny not work here ; 01.04.2018 09:46 18-04-01_09-46

ToolTip4sec("A_SendLevel = " A_SendLevel "`n`n" A_LineNumber   " "   RegExReplace(A_LineFile,".*\\")    " "   Last_A_This) ; The built-in variable A_SendLevel contains the current setting.

ClipboardBackup := Clipboard
;Sleep,10
Clipboard := ""

; #; InputLevel 0

SendLevel 9 ; with this additions lines it works also in globalIntelisense nearliy 99% of time 18-04-01_12-24
Clipboard := ""
;sleep,2000
;tooltip,% c
Clipboard := sending ; " ln=" A_LineNumber "`n`n"
AHKcode := "Send,^v"
DynaRun(AHKcode) ; <= uese old clipboard.or  simle give it more time
sleep,2000
SendLevel 0
Clipboard := ClipboardBackup




    ;
    ;SendLevel 9
    ;ClipboardBackup := Clipboard
    ;Clipboard := sending
    ;Send,^v
    ;Clipboard := ClipboardBackup
    ;SendLevel 0
}else
    Send,{Text}%sending%

            ;lll(A_LineNumber, A_LineFile, "%sending% `n >" . sending . "<  `n token=18-03-13_14-44")

        ; Msgbox,sending `n >%sending%< `n (%A_LineFile%~%A_LineNumber%)

}else{
       SendPlay, %sending% ; First do the backspaces, Then send word (Raw because we want the string exactly as in ActionList . ahk)
        ;lll(A_LineNumber, A_LineFile, "%sending% `n >" . sending . "<  `n token=18-03-13_14-44")
        ; Msgbox,sending `n >%sending%< `n (%A_LineFile%~%A_LineNumber%) 
}

             global g_sending_is_buggy
             if( g_sending_is_buggy )
                 lll(A_LineNumber, A_LineFile, "SendPlay, %sending% `n >" . sending . "<  `n 17-07-29_11-48")

if(false && g_sending_is_buggy){
lll(A_LineNumber, A_LineFile, "let test sending with differenct methods `n SendValue =" . SendValue . " `n 17-07-29_12-23")
;
SendEvent, 1SendEvent = %sending% `n
SendInput, 2SendInput = %sending% `n
SendPlay, 3SendPlay = %sending% `n
SendRaw, 4SendRaw = %sending% `n
}

      Return
   }


;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;
; reg1SendEvenfoundPos := RegExMatch( "str" , "i)" )
; 2SendInpufoundPos := RegExMatch( "str" , "i)" )
; 4SendRaw = {Shift Down}{Shift Up}{Shift Down}{Shift Up}{BS 4}{
;
;



;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



; ms17-03-18_16-13
; =line:224Msgbox, ```n  ``n `n  (line:%A_LineNumber%)`
; ms17-03-18_16-13
;

; Msgbox, '%SendValue%' = SendValue  `n '%sending%' = sending `n (line:%A_LineNumber%) n
; Clipboard := SendValue
; Msgbox, ```n  ``n `n  (line:%A_LineNumber%)

; Sleep,1000
global g_sending_is_buggy
if(fals && g_sending_is_buggy){
lll(A_LineNumber, A_LineFile, "let test sending with differenct methods `n SendValue =" . SendValue . " `n 29.07.2017 11:06 17-07-29_11-07")
;
SendEvent, 1SendEvent = %SendValue% `n
SendInput, 2SendInput = %SendValue% `n
SendPlay, 3SendPlay = %SendValue% `n
SendRaw, 4SendRaw = %SendValue% `n
}
; sleep,2000
; reload

; i typed regex :
; 1SendEvenewStr := RegExReplace("abc", "i)")
; 2SendInpnewStr := RegExReplace("abc", "i)")
; 4SendRaw = {Shift Down}{Shift Up}{Shift Down}{Shift Up}{}
   if (BackSpaceWord)
   {
      sending = {BS %BackSpaceLen%}{Raw}%SendValue%
   } Else {
      sending = {Raw}%SendValue%
   }

   IfEqual, prefs_SendMethod, 2
   {
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
if(WinActive("PhpStorm", "", ".ahk") || WinActive("New File ahk_class SunAwtDialog") || WinActive("Rename ahk_class SunAwtDialog") )  {
; setKeyDelay, DelayMilliSec, PressDuration, Play ; PressDuration: Use -1 for no delay at all (default) and 0 for the smallest possible delay ; Play applies the above settings to the SendPlay mode
    ; SetKeyDelay, 95, 10 ; PressDuration: Use -1 for no delay at all (default) and 0 for the smallest possible delay ; Play applies the above settings to the SendPlay mode
    if(true){
        global g_Word ; thats the beginning of the word user alreaddy typed. 27.04.2017 18:52
        AHKcode := getRealisticDelayDynamicSendAHKcode(g_Word,SendValue)
global g_sending_is_buggy
if( g_sending_is_buggy )
    lll(A_LineNumber, A_LineFile, " send, ")
;send, ; avoids releasing Alt/Control/Shift/Win if they started out
               DynaRun(AHKcode)
               } else {
    SetKeyDelay, -1, -1 ; PressDuration: Use -1 for no delay at all (default) and 0 for the smallest possible delay ; Play applies the above settings to the SendPlay mode
    Send, %sending% ; it doesent work with SendInput in slow motion  04.04.2017 21:50 17-04-04_21-50

global g_sending_is_buggy
if( g_sending_is_buggy )
    lll(A_LineNumber, A_LineFile, " Send, %sending% `n >" . sending . "<  `n 17-07-29_11-38")

    }
   Return
}

;

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

      SendInput, %sending% ; First do the backspaces, Then send word (Raw because we want the string exactly as in ActionList . ahk)
 ;Msgbox, '%SendValue%' = SendValue  `n `n '%sending%' = sending `n (line:%A_LineNumber%) n

 global g_sending_is_buggy
 if( g_sending_is_buggy )
     lll(A_LineNumber, A_LineFile, "SendInput, %sending% `n >" . sending . "<  `n 17-07-29_11-42")

      Return
   }

   IfEqual, prefs_SendMethod, 3
   {
   global g_sending_is_buggy
   if( g_sending_is_buggy )
       lll(A_LineNumber, A_LineFile, " SendEvent, %sending% ")

      SendEvent, %sending% ; First do the backspaces, Then send word (Raw because we want the string exactly as in ActionList . ahk)
 ;Msgbox, '%SendValue%' = SendValue  `n `n '%sending%' = sending `n (line:%A_LineNumber%) n
      Return
   }
 ;Msgbox, '%SendValue%' = SendValue  `n `n '%sending%' = sending `n (line:%A_LineNumber%) n
;
   ClipboardSave := ClipboardAll
   Clipboard = 
   Clipboard := SendValue
   ClipWait, 0
   
   if (BackSpaceWord)
   {
      sending = {BS %BackSpaceLen%}{Ctrl Down}v{Ctrl Up}
   } else {
   sending = {Ctrl Down}v{Ctrl Up}
   }

   IfEqual, prefs_SendMethod, 1C
   {
      sending := "{Shift Down}{Shift Up}{Shift Down}{Shift Up}" . sending
      SendPlay, %sending% ; First do the backspaces, Then send word via clipboard
      global g_sending_is_buggy
      if( g_sending_is_buggy )
          lll(A_LineNumber, A_LineFile, "SendPlay, %sending% `n >" . sending . "<  `n 17-07-29_11-41")

   } else IfEqual, prefs_SendMethod, 2C
   {
      SendInput, %sending% ; First do the backspaces, Then send word via clipboard
 global g_sending_is_buggy
 if( g_sending_is_buggy )
     lll(A_LineNumber, A_LineFile, "SendInput, %sending% `n >" . sending . "<  `n 17-07-29_11-43")

   } else IfEqual, prefs_SendMethod, 3C
   {
      SendEvent, %sending% ; First do the backspaces, Then send word via clipboard
       global g_sending_is_buggy
       if( g_sending_is_buggy )
           lll(A_LineNumber, A_LineFile, "SendEvent, %sending% `n >" . sending . "<  `n 17-07-29_11-44")

   } else {
      ControlGetFocus, ActiveControl, ahk_id %g_Active_Id%
      IfNotEqual, ActiveControl,
         ControlSend, %ActiveControl%, %sending%, ahk_id %g_Active_Id%
   }
         
   Clipboard := ClipboardSave
   Return
}

;------------------------------------------------------------------------
SendCompatible(SendValue,ForceSendForInput) {

    lll(A_LineNumber, A_LineFile, "SendCompatible(SendValue,ForceSendForInput) `n SendValue =" . SendValue . " `n 17-07-16_15-01")

   global g_IgnoreSend
   global prefs_SendMethod
   ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
       SetKeyDelay, 200, 20, Play ; PressDuration: Use -1 for no delay at all (default) and 0 for the smallest possible delay ; Play applies the above settings to the SendPlay mode
       Send, %SendValue%

        global g_sending_is_buggy
        if( g_sending_is_buggy )
            lll(A_LineNumber, A_LineFile, " Send, %SendValue% `n Send, %" . SendValue . "% `n 17-07-29_12-10")
; regeregregreg
      Return
      ; GetKeyState, LshiftState, Lshift, P; 96+ lines in autocopy.ahk
   ;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

   IfEqual, ForceSendForInput, 1
   {
      g_IgnoreSend = 
      SendEvent, %SendValue%

       global g_sending_is_buggy
       if( g_sending_is_buggy )
           lll(A_LineNumber, A_LineFile, "SendEvent, %SendValue% `n >" . SendValue . "<  `n 17-07-29_11-45")


      Return
   }
   
   SendMethodLocal := SubStr(prefs_SendMethod, 1, 1)
   IF ( ( SendMethodLocal = 1 ) || ( SendMethodLocal = 2 ) )
   {
      SendInput, %SendValue%

       global g_sending_is_buggy
       if( g_sending_is_buggy )
           lll(A_LineNumber, A_LineFile, "SendInput, %SendValue% `n >" . SendValue . "<  `n 17-07-29_11-46")

      Return
   }

   IF ( ( SendMethodLocal = 3 ) || ( SendMethodLocal = 4 ) )
   {
      g_IgnoreSend = 1
      SendEvent, %SendValue%
             global g_sending_is_buggy
             if( g_sending_is_buggy )
                 lll(A_LineNumber, A_LineFile, "SendInput, %SendValue% `n >" . SendValue . "<  `n 17-07-29_11-46")

      Return
   }

   ; reg
   
   SendInput, %SendValue%
             global g_sending_is_buggy
             if( g_sending_is_buggy )
                 lll(A_LineNumber, A_LineFile, "SendInput, %SendValue% `n >" . SendValue . "<  `n 17-07-29_11-46")

   Return
}

;------------------------------------------------------------------------



;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

getTypicalKeyLatency( key, factor = 1 ) {
; recordet at 10.04.2017 17:45 from sl5net
time2keyPressLog := {}
time2keyPressLog[" ,"] := 390
time2keyPressLog[" a"] := 109
time2keyPressLog[" b"] := 109
time2keyPressLog[" c"] := 249
time2keyPressLog[" d"] := 109
time2keyPressLog[" e"] := 110
time2keyPressLog[" F"] := 219
time2keyPressLog[" g"] := 156
time2keyPressLog[" h"] := 188
time2keyPressLog[" i"] := 172
time2keyPressLog[" J"] := 343
time2keyPressLog[" k"] := 203
time2keyPressLog[" l"] := 140
time2keyPressLog[" m"] := 109
time2keyPressLog[" n"] := 124
time2keyPressLog[" o"] := 140
time2keyPressLog[" p"] := 296
time2keyPressLog[" s"] := 140
time2keyPressLog[" t"] := 203
time2keyPressLog[" u"] := 140
time2keyPressLog[" v"] := 203
time2keyPressLog[" w"] := 125
time2keyPressLog[" y"] := 203
time2keyPressLog[" z"] := 219
time2keyPressLog[" ä"] := 312
time2keyPressLog["''"] := 203
time2keyPressLog[", "] := 109
time2keyPressLog["-A"] := 344
time2keyPressLog["-F"] := 312
time2keyPressLog["-L"] := 344
time2keyPressLog["-S"] := 359
time2keyPressLog[". "] := 109
time2keyPressLog[".h"] := 374
time2keyPressLog["01"] := 187
time2keyPressLog["15"] := 78
time2keyPressLog["2 "] := 390
time2keyPressLog["20"] := 187
time2keyPressLog["45"] := 109
time2keyPressLog[": "] := 234
time2keyPressLog["<m"] := 312
time2keyPressLog["> "] := 390
time2keyPressLog["? "] := 218
time2keyPressLog["a "] := 141
time2keyPressLog["ab"] := 156
time2keyPressLog["ad"] := 218
time2keyPressLog["ag"] := 125
time2keyPressLog["am"] := 156
time2keyPressLog["an"] := 140
time2keyPressLog["ap"] := 234
time2keyPressLog["ar"] := 125
time2keyPressLog["as"] := 265
time2keyPressLog["at"] := 124
time2keyPressLog["ay"] := 219
time2keyPressLog["be"] := 187
time2keyPressLog["bj"] := 249
time2keyPressLog["cl"] := 219
time2keyPressLog["co"] := 109
time2keyPressLog["cr"] := 203
time2keyPressLog["ct"] := 203
time2keyPressLog["cu"] := 249
time2keyPressLog["d "] := 171
time2keyPressLog["da"] := 141
time2keyPressLog["de"] := 156
time2keyPressLog["di"] := 219
time2keyPressLog["e "] := 109
time2keyPressLog["ea"] := 141
time2keyPressLog["ec"] := 187
time2keyPressLog["ee"] := 390
time2keyPressLog["eg"] := 203
time2keyPressLog["ei"] := 109
time2keyPressLog["el"] := 125
time2keyPressLog["em"] := 125
time2keyPressLog["en"] := 109
time2keyPressLog["er"] := 31
time2keyPressLog["es"] := 125
time2keyPressLog["et"] := 188
time2keyPressLog["ev"] := 359
time2keyPressLog["ex"] := 219
time2keyPressLog["fr"] := 187
time2keyPressLog["fu"] := 140
time2keyPressLog["g "] := 203
time2keyPressLog["ge"] := 172
time2keyPressLog["gh"] := 171
time2keyPressLog["gi"] := 109
time2keyPressLog["gu"] := 141
time2keyPressLog["h "] := 125
time2keyPressLog["ha"] := 125
time2keyPressLog["he"] := 125
time2keyPressLog["hi"] := 109
time2keyPressLog["ho"] := 140
time2keyPressLog["ht"] := 187
time2keyPressLog["i "] := 141
time2keyPressLog["ib"] := 234
time2keyPressLog["id"] := 203
time2keyPressLog["ie"] := 203
time2keyPressLog["im"] := 343
time2keyPressLog["in"] := 109
time2keyPressLog["is"] := 109
time2keyPressLog["it"] := 187
time2keyPressLog["je"] := 125
time2keyPressLog["k "] := 249
time2keyPressLog["ke"] := 109
time2keyPressLog["la"] := 109
time2keyPressLog["ld"] := 94
time2keyPressLog["le"] := 109
time2keyPressLog["ll"] := 156
time2keyPressLog["lo"] := 202
time2keyPressLog["ls"] := 109
time2keyPressLog["m "] := 78
time2keyPressLog["ma"] := 203
time2keyPressLog["me"] := 140
time2keyPressLog["ml"] := 109
time2keyPressLog["mp"] := 187
time2keyPressLog["my"] := 250
time2keyPressLog["n "] := 109
time2keyPressLog["na"] := 141
time2keyPressLog["nc"] := 203
time2keyPressLog["nd"] := 110
time2keyPressLog["ne"] := 140
time2keyPressLog["ng"] := 109
time2keyPressLog["ns"] := 124
time2keyPressLog["nt"] := 109
time2keyPressLog["o "] := 125
time2keyPressLog["ob"] := 187
time2keyPressLog["oe"] := 141
time2keyPressLog["og"] := 156
time2keyPressLog["ol"] := 218
time2keyPressLog["om"] := 124
time2keyPressLog["on"] := 156
time2keyPressLog["op"] := 390
time2keyPressLog["or"] := 109
time2keyPressLog["ou"] := 78
time2keyPressLog["ow"] := 125
time2keyPressLog["p "] := 218
time2keyPressLog["pe"] := 172
time2keyPressLog["pl"] := 188
time2keyPressLog["po"] := 140
time2keyPressLog["pp"] := 141
time2keyPressLog["pr"] := 140
time2keyPressLog["r "] := 140
time2keyPressLog["r."] := 234
time2keyPressLog["ra"] := 171
time2keyPressLog["re"] := 125
time2keyPressLog["ri"] := 156
time2keyPressLog["rk"] := 141
time2keyPressLog["ro"] := 140
time2keyPressLog["rs"] := 202
time2keyPressLog["rt"] := 156
time2keyPressLog["ry"] := 203
time2keyPressLog["s "] := 156
time2keyPressLog["se"] := 156
time2keyPressLog["si"] := 109
time2keyPressLog["sp"] := 359
time2keyPressLog["ss"] := 156
time2keyPressLog["st"] := 172
time2keyPressLog["sy"] := 172
time2keyPressLog["t "] := 109
time2keyPressLog["ta"] := 156
time2keyPressLog["te"] := 109
time2keyPressLog["th"] := 125
time2keyPressLog["ti"] := 47
time2keyPressLog["tm"] := 125
time2keyPressLog["to"] := 109
time2keyPressLog["ts"] := 172
time2keyPressLog["ul"] := 203
time2keyPressLog["un"] := 187
time2keyPressLog["ur"] := 125
time2keyPressLog["us"] := 156
time2keyPressLog["ve"] := 202
time2keyPressLog["w "] := 156
time2keyPressLog["wh"] := 109
time2keyPressLog["wi"] := 125
time2keyPressLog["wo"] := 172
time2keyPressLog["x."] := 234
time2keyPressLog["xp"] := 281
time2keyPressLog["y "] := 187
time2keyPressLog["ye"] := 202
time2keyPressLog["yo"] := 172
time2keyPressLog["ac"] := 156
time2keyPressLog["ag"] := 141
time2keyPressLog["al"] := 109
time2keyPressLog["am"] := 124
time2keyPressLog["an"] := 109
time2keyPressLog["Ap"] := 312
time2keyPressLog["ar"] := 172
time2keyPressLog["as"] := 187
time2keyPressLog["at"] := 156
time2keyPressLog["au"] := 109
time2keyPressLog["av"] := 203
time2keyPressLog["ba"] := 140
time2keyPressLog["bb"] := 187
time2keyPressLog["be"] := 156
time2keyPressLog["bi"] := 343
time2keyPressLog["bl"] := 141
time2keyPressLog["bt"] := 188
time2keyPressLog["Bu"] := 156
time2keyPressLog["c "] := 281
time2keyPressLog["ce"] := 171
time2keyPressLog["ch"] := 109
time2keyPressLog["ck"] := 140
time2keyPressLog["Co"] := 249
time2keyPressLog["cr"] := 188
time2keyPressLog["CS"] := 296
time2keyPressLog["d "] := 156
time2keyPressLog["da"] := 109
time2keyPressLog["de"] := 125
time2keyPressLog["Di"] := 140
time2keyPressLog["dl"] := 78
time2keyPressLog["dn"] := 140
time2keyPressLog["du"] := 109
time2keyPressLog["e "] := 109
time2keyPressLog["e-"] := 327
time2keyPressLog["e."] := 140
time2keyPressLog["ea"] := 171
time2keyPressLog["eb"] := 203
time2keyPressLog["ec"] := 218
time2keyPressLog["ed"] := 172
time2keyPressLog["eg"] := 124
time2keyPressLog["eh"] := 125
time2keyPressLog["ei"] := 109
time2keyPressLog["ek"] := 156
time2keyPressLog["el"] := 109
time2keyPressLog["em"] := 109
time2keyPressLog["en"] := 109
time2keyPressLog["ep"] := 125
time2keyPressLog["er"] := 16
time2keyPressLog["es"] := 140
time2keyPressLog["et"] := 125
time2keyPressLog["eu"] := 109
time2keyPressLog["ew"] := 328
time2keyPressLog["ez"] := 296
time2keyPressLog["f "] := 109
time2keyPressLog["f."] := 296
time2keyPressLog["fe"] := 140
time2keyPressLog["Fl"] := 156
time2keyPressLog["fo"] := 125
time2keyPressLog["fr"] := 156
time2keyPressLog["ft"] := 202
time2keyPressLog["g "] := 109
time2keyPressLog["ge"] := 109
time2keyPressLog["gi"] := 124
time2keyPressLog["gl"] := 125
time2keyPressLog["Go"] := 172
time2keyPressLog["gr"] := 156
time2keyPressLog["gs"] := 250
time2keyPressLog["gt"] := 156
time2keyPressLog["gu"] := 109
time2keyPressLog["h "] := 47
time2keyPressLog["ha"] := 93
time2keyPressLog["hb"] := 328
time2keyPressLog["he"] := 109
time2keyPressLog["hi"] := 78
time2keyPressLog["hk"] := 219
time2keyPressLog["hm"] := 203
time2keyPressLog["hn"] := 156
time2keyPressLog["ho"] := 93
time2keyPressLog["hr"] := 234
time2keyPressLog["ht"] := 109
time2keyPressLog["hä"] := 109
time2keyPressLog["ia"] := 281
time2keyPressLog["ib"] := 78
time2keyPressLog["ic"] := 109
time2keyPressLog["id"] := 156
time2keyPressLog["ie"] := 109
time2keyPressLog["if"] := 156
time2keyPressLog["ig"] := 156
time2keyPressLog["il"] := 172
time2keyPressLog["Im"] := 187
time2keyPressLog["in"] := 109
time2keyPressLog["io"] := 62
time2keyPressLog["ip"] := 78
time2keyPressLog["is"] := 140
time2keyPressLog["it"] := 125
time2keyPressLog["iw"] := 250
time2keyPressLog["Ja"] := 187
time2keyPressLog["JS"] := 390
time2keyPressLog["k "] := 172
time2keyPressLog["ka"] := 140
time2keyPressLog["ke"] := 109
time2keyPressLog["kl"] := 172
time2keyPressLog["Ko"] := 125
time2keyPressLog["ks"] := 187
time2keyPressLog["kt"] := 94
time2keyPressLog["l "] := 156
time2keyPressLog["la"] := 109
time2keyPressLog["lc"] := 109
time2keyPressLog["ld"] := 187
time2keyPressLog["le"] := 109
time2keyPressLog["li"] := 109
time2keyPressLog["ll"] := 156
time2keyPressLog["ln"] := 109
time2keyPressLog["lo"] := 203
time2keyPressLog["lt"] := 109
time2keyPressLog["lu"] := 171
time2keyPressLog["lä"] := 156
time2keyPressLog["Lö"] := 187
time2keyPressLog["lü"] := 234
time2keyPressLog["m "] := 125
time2keyPressLog["m-"] := 296
time2keyPressLog["ma"] := 109
time2keyPressLog["mb"] := 172
time2keyPressLog["me"] := 125
time2keyPressLog["mf"] := 203
time2keyPressLog["mi"] := 171
time2keyPressLog["mm"] := 171
time2keyPressLog["mo"] := 125
time2keyPressLog["mp"] := 312
time2keyPressLog["ms"] := 156
time2keyPressLog["mt"] := 109
time2keyPressLog["mu"] := 359
time2keyPressLog["n "] := 109
time2keyPressLog["n,"] := 219
time2keyPressLog["na"] := 140
time2keyPressLog["nb"] := 249
time2keyPressLog["nd"] := 109
time2keyPressLog["ne"] := 109
time2keyPressLog["ng"] := 110
time2keyPressLog["Ni"] := 109
time2keyPressLog["nk"] := 94
time2keyPressLog["nn"] := 141
time2keyPressLog["no"] := 109
time2keyPressLog["ns"] := 109
time2keyPressLog["nt"] := 109
time2keyPressLog["nu"] := 172
time2keyPressLog["nw"] := 187
time2keyPressLog["nz"] := 312
time2keyPressLog["o "] := 125
time2keyPressLog["oc"] := 140
time2keyPressLog["od"] := 110
time2keyPressLog["oe"] := 109
time2keyPressLog["og"] := 125
time2keyPressLog["oh"] := 312
time2keyPressLog["ol"] := 172
time2keyPressLog["om"] := 141
time2keyPressLog["on"] := 109
time2keyPressLog["oo"] := 187
time2keyPressLog["op"] := 281
time2keyPressLog["or"] := 109
time2keyPressLog["os"] := 358
time2keyPressLog["ot"] := 171
time2keyPressLog["ou"] := 62
time2keyPressLog["p "] := 187
time2keyPressLog["PA"] := 156
time2keyPressLog["ph"] := 203
time2keyPressLog["pl"] := 203
time2keyPressLog["po"] := 219
time2keyPressLog["pp"] := 156
time2keyPressLog["Pr"] := 219
time2keyPressLog["pt"] := 140
time2keyPressLog["pu"] := 218
time2keyPressLog["r "] := 109
time2keyPressLog["r,"] := 250
time2keyPressLog["ra"] := 110
time2keyPressLog["rc"] := 203
time2keyPressLog["rd"] := 109
time2keyPressLog["re"] := 109
time2keyPressLog["rf"] := 203
time2keyPressLog["rg"] := 187
time2keyPressLog["ri"] := 109
time2keyPressLog["rk"] := 156
time2keyPressLog["rl"] := 140
time2keyPressLog["rm"] := 187
time2keyPressLog["rn"] := 156
time2keyPressLog["ro"] := 172
time2keyPressLog["rr"] := 219
time2keyPressLog["rs"] := 124
time2keyPressLog["rt"] := 172
time2keyPressLog["ru"] := 187
time2keyPressLog["rv"] := 249
time2keyPressLog["rz"] := 202
time2keyPressLog["s "] := 109
time2keyPressLog["s-"] := 156
time2keyPressLog["sa"] := 156
time2keyPressLog["sc"] := 141
time2keyPressLog["sd"] := 390
time2keyPressLog["se"] := 109
time2keyPressLog["si"] := 109
time2keyPressLog["so"] := 109
time2keyPressLog["sp"] := 203
time2keyPressLog["ss"] := 141
time2keyPressLog["st"] := 109
time2keyPressLog["su"] := 140
time2keyPressLog["t "] := 109
time2keyPressLog["t,"] := 171
time2keyPressLog["t-"] := 297
time2keyPressLog["t."] := 124
time2keyPressLog["ta"] := 141
time2keyPressLog["te"] := 109
time2keyPressLog["tf"] := 234
time2keyPressLog["ti"] := 250
time2keyPressLog["tl"] := 125
time2keyPressLog["tm"] := 140
time2keyPressLog["tr"] := 156
time2keyPressLog["ts"] := 125
time2keyPressLog["tt"] := 124
time2keyPressLog["Tu"] := 187
time2keyPressLog["tw"] := 125
time2keyPressLog["ty"] := 218
time2keyPressLog["tz"] := 47
time2keyPressLog["tä"] := 140
time2keyPressLog["u "] := 125
time2keyPressLog["uc"] := 109
time2keyPressLog["ue"] := 93
time2keyPressLog["uf"] := 203
time2keyPressLog["ug"] := 140
time2keyPressLog["ui"] := 359
time2keyPressLog["uk"] := 390
time2keyPressLog["ul"] := 187
time2keyPressLog["Um"] := 171
time2keyPressLog["un"] := 171
time2keyPressLog["ur"] := 109
time2keyPressLog["us"] := 124
time2keyPressLog["ut"] := 109
time2keyPressLog["va"] := 171
time2keyPressLog["Ve"] := 172
time2keyPressLog["vi"] := 109
time2keyPressLog["vo"] := 109
time2keyPressLog["We"] := 125
time2keyPressLog["wi"] := 109
time2keyPressLog["wo"] := 125
time2keyPressLog["xi"] := 250
time2keyPressLog["ys"] := 234
time2keyPressLog["ze"] := 109
time2keyPressLog["zm"] := 359
time2keyPressLog["Zu"] := 140
time2keyPressLog["zw"] := 187
time2keyPressLog["ß "] := 343
time2keyPressLog["ße"] := 375
time2keyPressLog["äf"] := 141
time2keyPressLog["än"] := 172
time2keyPressLog["är"] := 203
time2keyPressLog["äs"] := 187
time2keyPressLog["ät"] := 110
time2keyPressLog["ös"] := 156
time2keyPressLog["üc"] := 219
if( time2keyPressLog[key] )
  r :=  time2keyPressLog[key]
Else {
  key := SubStr(key,2 , 1) . SubStr(key,1,1)
  r := time2keyPressLog[key]
  ;Msgbox,%key% --- %temp%`n (from: %A_LineFile%~%A_LineNumber%)
  if( RegExMatch(temp,"^d+$"))
        r :=  temp
    else
        r := 300
 }
 r := round( r * factor )

 return r
}

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
convertSendCode2SendPlayCode(AHKcode){
   AHKcode1 := AHKcode
; thats pseudo sendPlay . alternative ; However, SendPlay may have no effect at all on Windows Vista or later if User Account Control is enabled, even if the script is running as an administrator. mySendPlay
    StringReplace, AHKcode, AHKcode, ! , {!}
    if(strlen(AHKcode)>1)
        return AHKcode
    StringReplace, AHKcode, AHKcode, # , {#}
    if(strlen(AHKcode)>1)
        return AHKcode
    StringReplace, AHKcode, AHKcode, + , {+}
    if(strlen(AHKcode)>1)
        return AHKcode
    StringReplace, AHKcode, AHKcode, ^ , {^}
    if(strlen(AHKcode)>1)
        return AHKcode
    StringReplace, AHKcode, AHKcode, { , {{}
    if(strlen(AHKcode)>1)
        return AHKcode
    StringReplace, AHKcode, AHKcode, } , {}}
        return AHKcode
}
getRealisticDelayDynamicSendAHKcode(g_Word,AHKcode){
 ; g_Word thats the already correct typied letters.
 ; AHKcode thats the letters we type next her in this function 30.04.2017 08:32

 ; if(false){
    ; todo: works relly fine. do the rest please 10.04.2017 18:34
 startPos := 1
 ; while( RegExMatch( AHKcode , "P)([\w ])([\w ])" , m , startPos ) ) { ; used till 10.04.2017 20:31 works

 ; quick and dirty repair: kind of encodeing. lets decode later.
  StringReplace, AHKcode , AHKcode ,``,´,, All ; its only for prevent errors. 27.04.2017 15:55 for eg if you want write ... thats working. it better then noting :) ... its not correct bad not so a big false. you could correct it manually easily
  ;~ StringReplace, AHKcode , AHKcode , ``, ´ ,, All ; its only for prevent errors. 27.04.2017 15:55 for eg if you want write ... thats working. it better then noting :) ... its not correct bad not so a big false. you could correct it manually easily
     ;~ StringReplace, AHKcode , AHKcode , ``, ````,, All ; its only for prevent errors. 27.04.2017 15:55 for eg if you want write
 ;~ tooltip,'%AHKcode%' = AHKcode  n (line:%A_LineNumber%) n
 ;~ sleep,2000


; lets ignore to send the first letters
BackSpaceLen := StrLen(g_Word)
  ;  msgbox,'%BackSpaceLen%' = BackSpaceLen   = '%g_Word%' = g_Word `n (%A_LineFile%~%A_LineNumber%)
AHKcode := substr(AHKcode, BackSpaceLen + 1)
isDoubleQuoteDeletedByBackspace := false
while( RegExMatch( AHKcode , "P)([^\n])([^\n])" , m , startPos ) ) {
    m1 := SubStr(AHKcode, mPos1 ,  mLen1 )
    m2 := SubStr(AHKcode, mPos2 ,  mLen2 )


    ; StringReplace, I_ThisCmd, I_ThisCmd, #, {#}  ; Replace leading #, if any.


    key := m1 . m2
    factor := 0.5
    factor := 0.9
    ; factor := 0.4
    ; factor := 10
    ; SendPlay may have no effect at all on Windows Vista or later if User Account Control is enabled, even if the script is running as an administrator. 10.04.2017 18:24
;~     if(m1 == "``")
;~         sleepMili := "`n Sleep," . getTypicalKeyLatency( key, factor ) . "`n SendInput,#####"
;~     if(m2 == "``")
;~         sleepMili := "`n Sleep," . getTypicalKeyLatency( key, factor ) . "`n SendInput,#####"
  ;  if(m2 == ";" || m2 == "`;"){
  ;      sleepMili := "`n Sleep," . getTypicalKeyLatency( key, factor ) . "`n SendInput,###"
  ;      m2 := "uio"
  ;      }
    if(m2 == """" && !isDoubleQuoteDeletedByBackspace){ ; jetbrains often send outomatically the closing double quote. di dont like that this time. 28.04.2017 17:19
        sleepMili := "`n SendInput,{Backspace}"
        isDoubleQuoteDeletedByBackspace := true
        }
        ;~ sleepMili := "`n Sleep," . getTypicalKeyLatency( key, factor ) . "`n SendInput,{Backspace}"
    else
        sleepMili := "`n Sleep," . getTypicalKeyLatency( key, factor ) . "`n SendInput,"

; msgbox, % convertSendCode2SendPlayCode(convertSendCode2SendPlayCode("%"))
if(true){
    m1 := convertSendCode2SendPlayCode(m1)
    ;m1 := "E1"
    if(false){
    if(m1 == "``;"){
        ; m1 := "```;" ; for eg CLIMBERS;
        ; m1 := "; " ; for eg CLIMBERS;
        m1 := "x2" ; for eg CLIMBERS;
    }
    if(m1 == "````;"){
        ; m1 := "```;" ; for eg CLIMBERS;
        ; m1 := "; " ; for eg CLIMBERS;
        m1 := "x4" ; for eg CLIMBERS;
    }
    if(m1 == "```;"){
        ; m1 := "```;" ; for eg CLIMBERS;
        ; m1 := "; " ; for eg CLIMBERS;
        m1 := "x3" ; for eg CLIMBERS;
    }
    if(m1 == ";"){
        ; m1 := "```;" ; for eg CLIMBERS;
        ; m1 := "; " ; for eg CLIMBERS;
        m1 := "x0" ; for eg CLIMBERS;
    }
    if(m1 == "`;"){
        ; m1 := "```;" ; for eg CLIMBERS;
        m1 := "; " ; for eg CLIMBERS;
        m1 := "x3" ; for eg CLIMBERS;
    }}
    if(m1 = " "){
        m1 := "{space}" ; that seems importend. for e.g. hiere: climbers = CLIMBERS;
    }
;    tooltip,'%m1%'=m1 (%A_LineFile%~%A_LineNumber%)
    ; m2 := convertSendCode2SendPlayCode(m2)
}
    AHKcodePre := SubStr(AHKcode, 1 , mPos1 + mLen1 -2 ) . m1
    AHKcodeEnd := SubStr(AHKcode, mPos2 )
    AHKcode := AHKcodePre . sleepMili . AHKcodeEnd
    ; startPos := startPos + m - 1
    startPos := mPos1 + strlen(m1) + strlen(sleepMili)
  ; tooltip, % strlen(AHKcode) . ": "  . AHKcode
  }
  if(isDoubleQuoteDeletedByBackspace)
    AHKcode .= "`n SendInput,{del}" ; delete the last double quote moved by jetbrains around 28.04.2017 17:29

AHKcode := "`nSend," . AHKcode
; msgbox, % AHKcode
;AHKcode  := AHKcodeNEW

; getTypicalKeyLatency( key )

; Msgbox, AHKcode = %AHKcode%
;AHKcode := RegExReplace(AHKcode, "\{Sleep\s{0,5}(\d+)\}" , "`n Sleep, $1 `n Send,")
; AHKcode

; deencodeing. the space becouse they key is wainting without using key. thats quick and dirty and good working workaround. 27.04.2017 18:22:
 StringReplace, AHKcode , AHKcode ,´,````{SPACE},, All
; Msgbox,'%AHKcode%' = AHKcode  `n (%A_LineFile%~%A_LineNumber%)
return AHKcode
}
 ; StringReplace, AHKcode , AHKcode ,;,````;,, All ; maybe this is not problem. may comment it oust
;AHKcode .= " `; TESSST 17-04-28_00-03"
;clipboard := AHKcode
 ; (literal semicolon). Note: This is necessary only if a semicolon has a space or tab to its left. If it does not, it will be recognized correctly without being escaped.
; AHKcode := RegExReplace(AHKcode, "`;", "X")



getCorrectedStringUAOSS( sending  ) {

; If Unicode is supported, Number is a Unicode character code between 0 and 0x10FFFF (or 0xFFFF prior to [v1.1.21]); otherwise it is an ANSI character code between 0 and 255.

tooltip,danger Chr(252) may not work in utf8??? `n (line:%A_LineNumber%)
; lÃ¶scht
; k�rzlich ver�ffentlicht l�uft
; return sending
; return sending " 18-09-26_10-31"


nW := "[^\w\s\.!-_]+" ; no word z.b. ? �
; nW := "[^a-zA-Z\s\.!-_]+" ; no word



sending := RegExReplace( sending , "i)Ã¼", Chr(252) ) ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "Ãœ", Chr(220) ) ; UE http://slayeroffice.com/tools/ascii/ Ãœbrigens

sending := RegExReplace( sending , "k" nW "rz","k" Chr(220) "rz" ) ; UE http://slayeroffice.com/tools/ascii/ k?rzlich

sending := RegExReplace( sending , "Pr" nW "f", "Pr" . Chr(252) .  "f" ) ; ue http://slayeroffice.com/tools/ascii/

sending := RegExReplace( sending , "\bmu\ste\b", "musste" )


sending := RegExReplace( sending , "ueber", "" . Chr(252) .  "ber" ) ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bfÃ¼r\b","f" . Chr(252) . "r") ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bf" nW "r\b","f" . Chr(252) . "r") ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bgew" nW "nscht\b","gew" . Chr(252) . "nscht") ; ue gew?nscht http://slayeroffice.com/tools/ascii/
;

sending := RegExReplace( sending , "i)\bwÃ¼rd","w" . Chr(252) . "rd") ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bw" nW "rd","w" . Chr(252) . "rd") ; ue http://slayeroffice.com/tools/ascii/

sending := RegExReplace( sending , "i)\bgrÃ¼nd","gr" . Chr(252) . "nd") ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bgr" nW "nd","gr" . Chr(252) . "nd") ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bmuendl.\b","m" . Chr(252) . "ndl.") ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)r" nW "ck","r" . Chr(252) . "ck") ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)m" nW "nd","m" . Chr(252) . "nd") ; ue http://slayeroffice.com/tools/ascii/

sending := RegExReplace( sending , "m�glich", "m" Chr(246) "glich" ) ; oe  m�glich
sending := RegExReplace( sending , "m" nW "glich", "m" Chr(246) "glich" ) ; oe  m�glich

sending := RegExReplace( sending , "Ã¶", Chr(246) ) ; oe zB hÃ¶ren http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "oe", Chr(246) ) ; oe zB hÃ¶ren http://slayeroffice.com/tools/ascii/

sending := RegExReplace( sending , "" nW "ffentlicht", Chr(246) "ffentlicht" ) ; oe zB hÃ¶ren http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "L" nW "sung", "L" Chr(246) "sung" ) ; oe zB hÃ¶ren http://slayeroffice.com/tools/ascii/

sending := RegExReplace( sending , "Ã¼", Chr(252) ) ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "Ã¼be", Chr(252) "be" ) ; ue http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "[^" nW "\s\.!-]be", Chr(252) "be" ) ; ue http://slayeroffice.com/tools/ascii/


; weiÃŸ
sending := RegExReplace( sending , "ÃŸ","" . Chr(223) . "") ; ss http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bgroÃŸ","gro" . Chr(223) . "") ; ss http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)\bgro" nW "","gro" . Chr(223) . "") ; ss http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)lieÃŸlich\b","lie" . Chr(223) . "lich") ; scharfess http://slayeroffice.com/tools/ascii/ 

sending := RegExReplace( sending , "Abschlu" nW "", "Abschlu" . Chr(223) ) ; scharfess http://slayeroffice.com/tools/ascii/

; sending := RegExReplace( sending , "i)ss", Chr(223) ) ; scharfess http://slayeroffice.com/tools/ascii/ Ausnahmen professionell

; ausschlie�lich
sending := RegExReplace( sending , "i)lie.lich\b","lie" . Chr(223) . "lich") ; scharfess http://slayeroffice.com/tools/ascii/ 

sending := RegExReplace( sending , "i)s" nW "ch","s" . Chr(228) . "ch") ; 
sending := RegExReplace( sending , "i)schw" nW "tzte","schw" . Chr(228) . "tzte") ; 
sending := RegExReplace( sending , "i)Ã¤", Chr(228) ) ;  http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "Ã„", "" . Chr(196) . "" ) ; AE http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "u.Ã„.", "u." . Chr(196) . "." ) ; AE http://slayeroffice.com/tools/ascii/
sending := RegExReplace( sending , "i)beschÃ¤ftigte","besch" . Chr(228) . "ftigte") ; ae http://slayeroffice.com/tools/ascii/ 

sending := RegExReplace( sending , "l" nW "uft","l" . Chr(228) . "uft") ; ae http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "oberfl" nW "chlich","oberfl" . Chr(228) . "chlich") ; ae http://slayeroffice.com/tools/ascii/

sending := RegExReplace( sending , "i)\bgefÃ¤lt","gef" . Chr(228) . "lt") ; ae http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "i)\bgef" nW "lt","gef" . Chr(228) . "lt") ; ae http://slayeroffice.com/tools/ascii/ 

sending := RegExReplace( sending , "i)\bMÃ¤rz","M" . Chr(228) . "rz") ; ae http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "i)\bM" nW "rz","M" . Chr(228) . "rz") ; ae http://slayeroffice.com/tools/ascii/ 

sending := RegExReplace( sending , "i)\bW" nW "hre","W" . Chr(228) . "hre") ; ae http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "i)\bjÃ¤hr","j" . Chr(228) . "hr") ; ae http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "i)\bj" nW "hr","j" . Chr(228) . "hr") ; ae http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "i)" nW "hnlich","" . Chr(228) . "hnlich") ; ae http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "i)besch" nW "ft","besch" . Chr(228) . "ft") ; ae http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "i)sch" nW "tigt","sch" . Chr(228) . "ftigt") ; ae http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "i)AuftrÃ¤ge","Auftr" . Chr(228) . "ge") ; ae http://slayeroffice.com/tools/ascii/ 
sending := RegExReplace( sending , "i)Auftr" nW "ge","Auftr" . Chr(228) . "ge") ; ae http://slayeroffice.com/tools/ascii/ 

foundPos := RegExMatch( sending , "i)Ã" )
if(foundPos){
    msgbox,17-05-23_17-09 :( '%sending%' = sending  (line:%A_LineNumber%)
}
foundPos := RegExMatch( sending , "Ã¼" )
if(foundPos){
    msgbox,18-03-01_15-49 :( '%sending%' = sending  (line:%A_LineNumber%)
}


return sending  
}









;==================================================

;e.g. vText := JEE_StrUtf8BytesToText(vUtf8Bytes)

JEE_StrUtf8BytesToText(ByRef vUtf8Bytes)
{
	if A_IsUnicode
	{
		VarSetCapacity(vTemp, StrPut(vUtf8Bytes, "CP0"))
		StrPut(vUtf8Bytes, &vTemp, "CP0")
		return StrGet(&vTemp, "UTF-8")
	}
	else
		return StrGet(&vUtf8Bytes, "UTF-8")
}

;==================================================

;e.g. vUtf8Bytes := JEE_StrTextToUtf8Bytes(vText)

JEE_StrTextToUtf8Bytes(ByRef vText)
{
	VarSetCapacity(vTemp, StrPut(vText, "UTF-8"))
	StrPut(vText, &vTemp, "UTF-8")
	return StrGet(&vTemp, "CP0")
}

;==================================================
