﻿if(InStr(A_ComputerName,"SL5")) ; do ignore nothing. development computer
	global g_ignReg := { feedbackMsgBox:{tit:".^", text:".^"} ,          saveLogFiles: {ln:".^", scriptName:"\b(Window|ListBox)\.ahk", text:"(WordIndex|CloseListBox|HotKeys|g_ListBox_Id)\b"},                    sqlQuery: {ln:".^", scriptName:".^", text:".^"},                    hotKeyStuff: {ln:".^", scriptName:".^", text:".^"},                    runLogFile: {ln:".^", scriptName:".^", text:".^"} } ;;;;


; Indentation_style: https://de.wikipedia.org/wiki/Einrückungsstil#SL5small-Stil






















;/¯¯¯¯ ActionListNEWactivate( ¯¯ 181012014107 ¯¯ 12.10.2018 01:41:07 ¯¯\
; hier wird das active ueberschrieben: 12.07.2017 21:33
ActionListNEWactivate( ActionListDir , ActionListNEW, ActionListActive , gi_everywhereSourcePath, activeClass := "" , activeTitle := "" ) {
; return, 1 ; return spielt keine rolle, quasi void 30.07.2017 12:52 17-07-30_12-52
	
	global g_lineNumberFeedback
	
;Msgbox,n (%A_LineFile%~%A_LineNumber%)
	
	if(1)
		lll(A_LineNumber, A_LineFile, ":) _______________ Hello inside " RegExReplace(A_LineFile,".*\\") )
    ; lll(A_LineNumber, A_LineFile, ":) _______________ Hello inside temp.ahk _____________"  )
	
    ; lll(A_LineNumber, A_LineFile, "START function: ActionListNEWactivate"  )
	
	
	g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%
	
	
	
	if(FileExist(ActionListNEW)) ; feature update 08.04.2017 19:43
		ActionListNEWarchivePath := ActionListNEW
	else
		ActionListNEWarchivePath = % ActionListDir . "\" . ActionListNEW
   ; From here we only use ActionListNEWarchivePath
   ; Next time this variable is used here: simplifyNameOfActionListNEWstep1( ActionListNEW ) {  in line 256   12.07.2017 21:07
	
	if(1 && !WinExist("1:" )){
		msg =
(
ActionListNEWarchivePath = '%ActionListNEWarchivePath%'
ActionListDir = '%ActionListDir%'
'%A_LineNumber%' = A_LineNumber
'%A_ScriptDir%' = A_ScriptDir
'%A_LineFile%' = A_ScriptName
'%A_ThisFunc%' = A_ThisFunc
)
		feedbackMsgBox(msg,msg,1,1)
	}
	
	
	global g_doSaveLogFiles
	if(Instr(ActionListNEWarchivePath,"\EVERYTHING\")){
		g_doSaveLogFiles := false
		lll(A_LineNumber, A_LineFile,A_ThisFunc ": "    "g_doSaveLogFiles := true" )
	}else{
		g_doRunLogFiles := false
	}
	
	
	if(!ActionListNEWarchivePath)
		Msgbox,Oops !ActionListNEWarchivePath `n (Typing_Aid_everywhere_multi_clone.inc.ahk~%A_ThisFunc%~%LineNumber%) `
	
   ; ActionListActivePath := gi_everywhereSourcePath .  "\" . ActionListActive
	ActionListActivePath := A_ScriptDir . "\" . ActionListActive
	if(!FileExist(ActionListActivePath))
		MsgBox, :( '%ActionListActivePath%' = ActionListActivePath  `n (line:%A_LineNumber%) `n 18-01-20_17-12
; The active path, that the complete address of the file inc dir, has to be always present. if not then that is an error. 12.07.2017 21:10
	
	;/¯¯¯¯ !FileExist(ActionListNEWarchivePath) ¯¯ 181012011354 ¯¯ 12.10.2018 01:13:54 ¯¯\

    RegRead, CreatedDir, HKEY_CURRENT_USER, SOFTWARE\sl5net, CreatedDir
    if(CreatedDir){
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, CreatedDir, % "" ; RegWrite , RegSave , Registry

     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, lastImportant_ScriptName, % A_ScriptName ; RegWrite , RegSave , Registry
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite ,
     RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, lastImportant_LineFileShort, % RegExReplace(A_LineFile,".*\\") ; RegWrite ,
     }




    fileAddress_projectFlag := ActionListDir "\_create_own_project.flag"
    isFileExist_create_own_projectFlag := (FileExist(fileAddress_projectFlag) && !InStr(FileExist(fileAddress), "D"))
    ; isFileExist_create_own_projectFlag deprecated. probably to slow
	if(!FileExist(ActionListNEWarchivePath) && (CreatedDir || isFileExist_create_own_projectFlag )) {

	    FIleDelete,  % fileAddress_projectFlag ; then you need alway generae it explizit via generate project links 23.10.2018 11:29

		; So hear it's possibly a good idea to generate a new one by using a template. 12.07.2017 21:12
		g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%
		
		WinGetActiveTitle,at
		strLen_ActionListNEWar := StrLen(ActionListNEWarchivePath)
		if(strLen_ActionListNEWar < 5)
			MsgBox, :-( '%strLen_ActionListNEWar%' = strLen_ActionListNEWar  `n (line:%A_LineNumber%) `n
		  ;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
		  ; Let's generate a pretty short 80 signs long name. 12.07.2017 21:14
		if(strLen_ActionListNEWar>70) {
			global g_lineNumberFeedback
			g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%
			
			ActionListNEWarchivePath80 := "... " . SubStr(ActionListNEWarchivePath, -70 )
      ; MsgBox, '%ActionListNEWarchivePath80%' = ActionListNEWarchivePath80  `n (line:%A_LineNumber%) `n
		} else {
			ActionListNEWarchivePath80 := ActionListNEWarchivePath
		}
		;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
		initialActionList := ltrim(getInitialActionList(ActionListNEWarchivePath,ActionListNEW))
		; _%ActionListNEWarchivePath%|r|Here you could find your library
		
		StringReplace, lineFileRelative, A_LineFile , % A_ScriptDir,Source, All
		;Msgbox,%LineFileRelative%`n (%A_LineFile%~%A_LineNumber%) )

        calledFromStr := A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
        Include := "Include"

		    RegWrite, REG_SZ, HKEY_CURRENT_USER, SOFTWARE\sl5net, FileAppend , % A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
FileAppend, `#%Include% _global.ahk `n`; '%at%' `; (%LineFileRelative%~%A_LineNumber%) `n%initialActionList% `n, % ActionListNEWarchivePath
		 Sleep,400
		 ; Sleep,250 ; why sleeping ? todo sleeping?

		; End of: if(!FileExist(ActionListNEWarchivePath))
		lll(A_LineNumber, A_LineFile,A_ThisFunc ": "    "saved first time: >" . ActionListNEWarchivePath . "< = Now the new examples-template should be saved" )
		; Now the new examples-template is saved inside of this file: ActionListNEWarchivePath
		;\____ !FileExist(ActionListNEWarchivePath) __ 181012011424 __ 12.10.2018 01:14:24 __/
	} else {
		; No example template was used. The content is already there. Inside on this file. And don't need to be generated. 12.07.2017 21:36
		msg:=A_ThisFunc ": "    "startREADING: >" . ActionListNEWarchivePath . "< = ActionListNEWarchivePath"
		lll(A_LineNumber, A_LineFile,msg)
		;Msgbox,%msg%`n (%A_LineFile%~%A_LineNumber%)
		
;/¯¯¯¯ startREADING ¯¯ 181012011928 ¯¯ 12.10.2018 01:19:28 ¯¯\
		; read #include commands
		exist_includeFilePath := 0
		includeFileSContent := ""
		ActionListGeneratedPath := ""
		isIncludeFileInside := false
		includeFileSContentWillBeNeedsSaved := false
		includeFilePathArray := Object()
		lineInRegExArray := Object()
		
		; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . ActionListGeneratedPath . "' = ActionListGeneratedPath `n'" . ActionListNEWarchivePath . " = ActionListNEWarchivePath " )
		
		if(1 && !WinExist("1:" )){
			msg =
(
ActionListNEWarchivePath = '%ActionListNEWarchivePath%'
ActionListDir = '%ActionListDir%'
'%A_LineNumber%' = A_LineNumber
'%A_ScriptDir%' = A_ScriptDir
'%A_LineFile%' = A_ScriptName
'%A_ThisFunc%' = A_ThisFunc
)
; feedbackMsgBox(msg,msg,1,1)
			lll(A_LineNumber, A_LineFile, msg )
		}
		
		;/¯¯¯¯ Loop,read,%ActionListNEWarchivePath ¯¯ 
		Loop,read, % ActionListNEWarchivePath
		{
           ; Beispiel:
; #Include .\..\ActionLists\Notepad\_global.txt
; #Include ..\_globalActionLists\Bewerbung\Firmware_Entwicklung.txt
			
;           regEx := "i)^\s*#include\s*( |,)\s*([^|!]+)\s*(?:((\||\!))\s*(.+))?\s*"
; include[ ]*(?:,|\s)[ ]*([^|!\n]+)[ ]*(?:((\||\!))[ ]*([^\n]+))?[ ]*
            ; ?: is used to denote non capturing group.
			regEx := "i)^[ ]*#include[ ]*(?:,| )[ ]*([^|!\n]+)[ ]*(?:((\||\!))[ ]*([^\n]+))?[ ]*"
			foundPos := RegexMatch( A_LoopReadLine, regEx, matchs) ; later matchs1 is used 04.10.2018 09:04 18-10-04_09-04
			examples =
(
#include dir\something.ahk
)
			
			msg := "#include foundPos = >" foundPos "< in `n" ActionListNEWarchivePath "`n"
			msg .= A_WorkingDir " = A_WorkingDir `n"
			msg .= A_ScriptDir " = A_ScriptDir `n"
			msg .= A_ScriptFullPath " = A_ScriptFullPath `n"
			lll(A_LineNumber, A_LineFile, msg )
            ;Msgbox,%msg%`n (%A_LineFile%~%A_LineNumber%)
			
			;/¯¯¯¯ isIncludeFileInside ¯¯ 181012004940 ¯¯ 12.10.2018 00:49:40 ¯¯\
			if(foundPos){
				isIncludeFileInside := true
				
				includeFilePath     := ActionListDir "\" trim(matchs1)
				
				; includeFilePath := RegExReplace(includeFilePath ,"(\\[^\\]+\\\.\.)+") ; works. removes all symbolic links 24.02.2018  cleanPath
				includeFilePath := removesSymbolicLinksFromFileAdress(includeFilePath) ; same as above -^
				
                ; Msgbox,%includeFilePath%`n (%A_LineFile%~%A_LineNumber%)
				
				
				exist_includeFilePath := (FileExist(includeFilePath)) ? 1 : 0
				if(!exist_includeFilePath){ ; 11.03.201:23 new style/format of adress writing, but try stay compativle to old scripts. TODO deletie it.
					
					msg := ":( includeFile NOT exist here: "  includeFilePath " = includeFilePath  `n"
					msg .= ActionListDir " =  ActionListDir `n"
					msg .= A_WorkingDir " = A_WorkingDir `n"
					msg .= A_ScriptDir " = A_ScriptDir `n"
					msg .= A_ScriptFullPath " = A_ScriptFullPath `n"
					msg .= exist_includeFilePath " = exist_includeFilePath  `n`n"
					lll(A_LineNumber, RegExReplace(A_LineFile,".*\\"), msg )
					
					
					includeFilePath := RegExReplace(includeFilePath ,"^\.\." , "..\ActionLists")
    ; includeFilePath := "ActionLists\" includeFilePath
					exist_includeFilePath := (FileExist(includeFilePath)) ? 1 : 0
					if(!exist_includeFilePath){
						msg .= "`n`n :( includeFile NOT exist here: "  includeFilePath " = includeFilePath  `n"
						msg .= exist_includeFilePath " = exist_includeFilePath  `n`n"
						lll(A_LineNumber, A_LineFile, msg )
						feedbackMsgBox(RegExReplace(A_LineFile,".*\\(.*?)\.ahk","$1") ">" A_LineNumber, msg, 1,1 ) ; temp.ahk is often ignored by config 05.10.2018 08:46
						MsgBox,% msg "(" A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"
                        ; __ __
					}
					msgbox,% msg "(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
				}
				
				;/¯¯¯¯ NOT exist_includeFilePath ¯¯ 181012005821 ¯¯ 12.10.2018 00:58:21 ¯¯\
				if(!exist_includeFilePath){ ; Backwords compatibible 06.03.2018 11:35 allows old include path; TODO: clean that a day in future. Priority: low. really low TODO: change default. default is inside the if
					msg := ":( " includeFilePath " = includeFilePath `n"
					msg .= exist_includeFilePath " = exist_includeFilePath  `n`n"
					includeFilePath := RegExReplace(includeFilePath, "^\.\.\\","") ; ..\ deleted 06.03.2018 11:34
					includeFilePath := removesSymbolicLinksFromFileAdress( ActionListDir "\" includeFilePath) ; user should could includes direcly from his ahk ActionList, without editing the address 05.03.2018 08:15
					exist_includeFilePath := (FileExist(includeFilePath)) ? 1 : 0
					
					msg .= includeFilePath " = includeFilePath  `n"
					msg .= A_WorkingDir " = A_WorkingDir `n"
					msg .= A_ScriptDir " = A_ScriptDir `n"
					msg .= A_ScriptFullPath " = A_ScriptFullPath `n"
					msg .= exist_includeFilePath " = exist_includeFilePath  `n`n"
                ;msgbox,% msg "(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
					lll(A_LineNumber, A_LineFile, msg )
                ;exitapp
				;\____ NOT exist_includeFilePath __ 181012005935 __ 12.10.2018 00:59:35 __/
				}else{
					;/¯¯¯¯ exist_includeFilePath ¯¯ 181012010005 ¯¯ 12.10.2018 01:00:05 ¯¯\
					msg := ":) " includeFilePath " = includeFilePath  `n"
					msg .= A_WorkingDir " = A_WorkingDir `n"
					msg .= A_ScriptDir " = A_ScriptDir `n"
					msg .= A_ScriptFullPath " = A_ScriptFullPath `n"
					msg .= exist_includeFilePath " = exist_includeFilePath  `n`n"
                ;msgbox,% msg "(" RegExReplace(A_LineFile,".*\\") "~" A_LineNumber ")"
					lll(A_LineNumber, A_LineFile, msg )
					;\____ exist_includeFilePath __ 181012010010 __ 12.10.2018 01:00:10 __/
				}
				
				
				
				if(0){
					feedbackMsgBox("isIncludeFileInside = " isIncludeFileInside,A_LineNumber . " " .  A_LineFile,1,1)
					global g_ignReg
					g_ignReg["feedbackMsgBox"]["tit"]  =.^
					g_ignReg["feedbackMsgBox"]["text"] =.^
					feedbackMsgBox("isIncludeFileInside = " isIncludeFileInside,A_LineNumber . " " .  A_LineFile,1,1)
					msg='%ActionListNEWarchivePath%' = ActionListNEWarchivePath `n '%foundPos%' = foundPos  `n '%includeFilePath%' = includeFilePath  `n '%exist_includeFilePath%' = exist_includeFilePath `n  ActionListDir = '%ActionListDir%' `n (line:%A_LineFile%~%A_LineNumber%)
					ToolTip5sec(msg  . " `n " . A_LineNumber . " " .  RegExReplace(RegExReplace(A_LineFile,".*\\") , ".*\", "") " " Last_A_This)
					msgbox,% msg
				}
				
				
				
				lineInRegEx         := (matchs4) ? matchs3 . matchs4 : "|.*" ; | ist a positvie rule. alle matching lines goes inside the new file.
				lll(A_LineNumber, A_LineFile,A_ThisFunc ": "  matchs1 "," matchs2 "," matchs3 "," matchs4 )
				lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "lineInRegEx=>" . lineInRegEx . "<" )



            ; Msgbox,'%lineInRegEx%' = lineInRegEx  n (line:%A_LineNumber%) n
				lineInRegExArray.Insert(lineInRegEx)
				if(!exist_includeFilePath){
					msg =:-( ERROR %exist_includeFilePath% = exist_includeFilePath `n ActionListDir = %ActionListDir% `n includeFilePath = %includeFilePath% `n  >%ActionListNEWarchivePath%< = ActionListNEWarchivePath (from: %A_LineFile%~%A_LineNumber%)
					Tooltip,%msg%
					g_doSaveLogFiles := true
					lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   msg)
				}
				
				lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   ":| exist_includeFilePath =" . exist_includeFilePath . "   '" . ActionListNEWarchivePath . "' = ActionListNEWarchivePath ")
				
				lll(A_LineNumber, A_LineFile,  ":| exist_includeFilePath =" . exist_includeFilePath . "   '" . ActionListNEWarchivePath . "' = ActionListNEWarchivePath ")
				
;<<<<<<<<<<<<<<  if(exist_includeFilePath)  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
				if(exist_includeFilePath){
					ActionListNEWarchivePathBackup := ActionListNEWarchivePath
					ActionListGeneratedPath := ActionListNEWarchivePath . "._Generated.ahk"
					
					lll(A_LineNumber, A_LineFile, "'" . ActionListGeneratedPath . "' = ActionListGeneratedPath `n'" . ActionListNEWarchivePath . " = ActionListNEWarchivePath ")
					
					lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . ActionListGeneratedPath . "' = ActionListGeneratedPath `n'" . ActionListNEWarchivePath . " = ActionListNEWarchivePath " )
					lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . ActionListGeneratedPath . "' = ActionListGeneratedPath `n'" . ActionListNEWarchivePath . " = ActionListNEWarchivePath " )
					
					
					exist_ActionListGeneratedPath := FileExist(ActionListGeneratedPath)
					
					FileGetTime, ActionListNEWarchivePathBackupModifiedTime, %ActionListNEWarchivePathBackup%
					FileGetTime, includeFileModifiedTime, %includeFilePath%
					
					; Pause,On
					msg=%ActionListNEWarchivePathBackup%`n=ActionListNEWarchivePathBackup `n (%A_LineFile%~%A_LineNumber%)
					;feedbackMsgBox(msg)
					
					
					ActionListGeneratedModifiedTime := 0
					if(exist_ActionListGeneratedPath)
						FileGetTime, ActionListGeneratedModifiedTime, %ActionListGeneratedPath%
					
					isActionListNewer_as_Generated := (ActionListNEWarchivePath > ActionListGeneratedModifiedTime)
					isIncludeFileNewer_as_Generated := (includeFileModifiedTime > ActionListGeneratedModifiedTime)
					
					msg= '%ActionListNEWarchivePathBackupModifiedTime%' > '%ActionListGeneratedModifiedTime%' (ActionListNEWarchivePathBackupModifiedTime > ActionListGeneratedModifiedTime)  `n' isIncludeFileNewer_as_Generated=%isIncludeFileNewer_as_Generated% `n '%includeFilePath%' = '%includeFilePath%' `n`n(A_LineNumber, A_LineFile)
					lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   msg)
 ; msgbox, % msg
					
					if( false 
                || !exist_ActionListGeneratedPath
                || ActionListNEWarchivePathBackupModifiedTime > ActionListGeneratedModifiedTime
                || includeFileModifiedTime > ActionListGeneratedModifiedTime ){
						includeFileSContentWillBeNeedsSaved := true
                     ; continue ; include is old. older.
					}{
						
						
						
                  ; lll(A_LineNumber, A_LineFile, "includeFilePathArray.Insert(" . includeFilePath . " `n 17-07-29_12-01" )
						includeFilePathArray.Insert(includeFilePath)
					}
					
				} ; endo of if(exist_includeFilePath)
				;\____ isIncludeFileInside __ 181012005024 __ 12.10.2018 00:50:24 __/
				
			} else
				break
;>>>>>>>>>>>>>>>>> if(exist_includeFilePath)  >>>>>>>>>>>>>>>>>>>>>>>>>>>>>
			
			lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . ActionListGeneratedPath . "' = ActionListGeneratedPath `n'" . ActionListNEWarchivePath . " = ActionListNEWarchivePath " )
			
		} 
		;\____ Loop,read,%ActionListNEWarchivePath __ 181012012859 __ 12.10.2018 01:28:59 __/
		
		
; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   includeFileSContentWillBeNeedsSaved . " = includeFileSContentWillBeNeedsSaved `n" . ActionListNEWarchivePath . " = ActionListNEWarchivePath `n" . "17-07-16_17-07")
		
		
		if(includeFileSContentWillBeNeedsSaved ) {
; loop throw alls include files
; Loop % Array.MaxIndex()   ; More traditional approach.
			for fileId, includeFilePath in includeFilePathArray ; Recommended approach in most cases.
			{ ; for fileId, includeFilePath in includeFilePathArray
				
				lll(A_LineNumber, A_LineFile,A_ThisFunc ": "  includeFilePath)
				
				lineInRegEx := lineInRegExArray[fileId]
				regEx := SubStr( lineInRegEx , 2 )
				regExPREFIX := SubStr( lineInRegEx  , 1 , 1 ) ; its a | ir a bit !
				
				lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "lineInRegEx=" . lineInRegEx)
				lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "regEx=" . regEx)
				
				
				includeFileContent := ""
				if(lineInRegEx == "|.*"){
					FileRead, includeFileContent, %includeFilePath%
					includeFileContent .= "`n"
				}else{
					Loop, read, %includeFilePath%
					{
						foundPos := RegExMatch( A_LoopReadLine , regEx  )
						
						if( ( regExPREFIX =="|" && foundPos ) || ( regExPREFIX == "!" && !foundPos ) )
							includeFileContent .= RTrim(A_LoopReadLine) . "`n"
					} ; END loop
				} ; END else
				if(includeFileContent)
					includeFileSContent .= includeFileContent
			}
		} ; END if(includeFileSContentWillBeNeedsSaved )
		
		
; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . includeFileSContentWillBeNeedsSaved . "' = includeFileSContentWillBeNeedsSaved" )
		
; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . ActionListGeneratedPath . "' = ActionListGeneratedPath `n'" . ActionListNEWarchivePath . " = ActionListNEWarchivePath " )
		
		if(includeFileSContentWillBeNeedsSaved )
			save_ActionListGeneratedPath(ActionListGeneratedPath,includeFileSContent,ActionListNEWarchivePath)
		
; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . ActionListGeneratedPath . "' = ActionListGeneratedPath `n'" . ActionListNEWarchivePath . " = ActionListNEWarchivePath " )
		
		if(isIncludeFileInside && ActionListGeneratedPath){
			ActionListNEWarchivePath := ActionListGeneratedPath ; that it will be used as your actionlist with all sugestions :) 12.07.2017 22:58
			
			ExitAPP_if_NOT_ActionListGeneratedPath (A_LineNumber, A_ThisFunc, ActionListNEWarchivePath, ActionListGeneratedPath , ActionListNEW)
            ;ExitAPP_if_NOT_ActionListNEWarchivePath_and_NOT_ActionListNEW(A_LineNumber, A_ThisFunc, ActionListNEWarchivePath, ActionListGeneratedPath , ActionListNEW)
		}
;>>>>>>>>>>>>>>>>>> includeFileSContentWillBeNeedsSaved >>>>>>>>>>>>>>>>>>>>>>>>>>>
	} ; EndOf: Loop, read, % ActionListNEWarchivePath
	
; lll(A_LineNumber, A_LineFile,A_ThisFunc ": "   "'" . ActionListGeneratedPath . "' = ActionListGeneratedPath `n'" . ActionListNEWarchivePath . " = ActionListNEWarchivePath " )
	
  ; All we have to do know is to  use this file. therefore we only copying it to the active used file. it will be overwritten. 12.07.2017 21:31
	
	ExitAPP_if_NOT_ActionListNEWarchivePath_and_NOT_ActionListNEW(A_LineNumber, A_ThisFunc, ActionListNEWarchivePath, ActionListGeneratedPath , ActionListNEW)
	if(0){ ; deprecated 21.03.2018 11:00
		Msgbox,%ActionListNEWarchivePath% 2 %ActionListActivePath% `n (%A_LineFile%~%A_LineNumber%)
		lll(A_LineNumber, A_LineFile, ActionListNEWarchivePath " FileCopy too " ActionListActivePath)
		FileCopy, % ActionListNEWarchivePath, % ActionListActivePath  , 1
	}
	return, 1
} ; EndOf function ActionListNEWactivate( ActionListDir , ActionListNEW, ActionListActive , gi_everywhereSourcePath )
;\____ ActionListNEWactivate( __ 181012023243 __ 
















restoreOldClipboard(idBackup, ClipboardBackup) {

disableCopyQ() ; enableCopyQ() ;


 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   MsgBox, 17-03-10_08-06
   ; by restoring we cant us a token or id becouse we dont know what the real value of clipboard was. 07.03.2017 08:08
   l := StrLen(idBackup)
   i:=0
   iMax:=99
   while(i++ < iMax )
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

         result:=SubStr(ClipboardBackup,l+1)
         Clipboard := result
         if(Clipboard <> ClipboardBackup)
            break
         ToolTip, '%Clipboard%' = Clipboard  `n '%result%' = result  `n  '%idBackup%' = idBackup  `n '%ClipboardBackup%' = ClipboardBackup  `n (line:%A_LineNumber%) `n 
         Sleep,5
   }
   if(i == iMax )
      MsgBox, :( '%iMax%' = '%iMax%' = iMax  `n (line:%A_LineNumber%) `n 
      Sleep, 3000 ; the time of the clipboard could get its real clipboard content. shorter maxes mor performant longer less errors 07.03.2017 09:39
   ;      MsgBox, '%Clipboard%' = Clipboard  `n (line:%A_LineNumber%) `n
   enableCopyQ() 
         return, 1
}
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<


ActionListOLDbackup( ActionListDir , ActionListOLD){
    if(!ActionListDir) ; TODO dirty bugFix 21.03.2018 11:36
          Return
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%
    lll(A_LineNumber, A_LineFile, ActionListDir ActionListOLD " FileCopy too " ActionListDir ActionListOLD . ".backup.ahk")
   FileCopy, % ActionListDir . "\" . ActionListOLD , % ActionListDir . "\" . ActionListOLD . ".backup.ahk", 1
    ;Msgbox,`n (%A_LineFile%~%A_LineNumber%)
   return 1
} 



ActionListOLDdisable( gi_everywhereSourcePath, ActionListActive){
      Return 1 ; Todo: dirtyBugFix  , deprecated 21.03.2018 11:33
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   ActionListActive = % gi_everywhereSourcePath . "\" . ActionListActive
   ActionListDisable = % gi_everywhereSourcePath . "\" . ActionListActive ".backup.ahk"
    lll(A_LineNumber, A_LineFile, ActionListActive " FileCopy too " ActionListDisable)
   FileCopy, % ActionListActive  , % ActionListDisable , 1
   return 1
} 
rungi_everywhereAHKifNotExist( gi_everywhereAHK ){
   DetectHiddenWindows,on
   SetTitleMatchMode,2
    IfWinNotExist,gi-everywhere.ahk
    {
        g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%
        IfWinNotExist,gi-everywhere
        {
            g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

        ;   MsgBox,,gi-everywhere  is running, :( `n are you sure gi-everywhere  is running? `n  IfWinNotExist gi-everywhere  `n (line:%A_LineNumber%) `n   lets try start it   automatically, 2
        ; lets wait and try again. maybe its reload its self and needs only a second
            Sleep, 2000 ; 1 Sekunde
            IfWinNotExist,gi-everywhere
            {

                ; gosub,couldIfindMyself
                msg := "Run, gi_everywhereAHK"
                ; Run, % gi_everywhereAHK
                if(0){
                    MsgBox, run gi-everywhere `n  `n (%A_LineFile%~%A_LineNumber%)
                RunAs,Administrator, % gi_everywhereAHK
                }
                tooltip, '%msg%' = msg  `n (line:%A_LineNumber%)
global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, msg )

            }

            g_tooltipText = WinWait gi-everywhere.ahk
            g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%
            WinWait,gi-everywhere.ahk,, 9
            IfWinNotExist,gi-everywhere
            {
global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, "IfWinNotExist,gi-everywhere -> exitapp")
                exitapp
            }
        }
    }
    return
}
checkFilePathExistens1704291222(ActionListDir, destinDir, sourceDir, gi_everywhereAHK ){


 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   DetectHiddenWindows,on
   SetTitleMatchMode,1
IfWinNotExist,gi-everywhere.ahk
{
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%
   IfWinNotExist,gi-everywhere
   {
    g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

;   MsgBox,,gi-everywhere  is running, :( `n are you sure gi-everywhere  is running? `n  IfWinNotExist gi-everywhere  `n (line:%A_LineNumber%) `n lets try start it automatically, 2
; lets wait and try again. maybe its reload its self and needs only a second
    Sleep, 2000 ; 1 Sekunde
    IfWinNotExist,gi-everywhere
    {
        ; gosub,couldIfindMyself
        Run, % gi_everywhereAHK
;        lll(A_LineNumber, A_LineFile, "Run, % gi_everywhereAHK")
global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, "Debuggging!  NOT Run % gi_everywhereAHK " )

    }
    g_tooltipText = WinWait gi-everywhere.ahk
    g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%
   WinWait,gi-everywhere,, 9
    IfWinNotExist,gi-everywhere
    {
global g_doSaveLogFiles

lll(A_LineNumber, A_LineFile, "IfWinNotExist,gi-everywhere -> exitapp")
        exitapp
    }
    }
} 
DetectHiddenWindows,On
SetTitleMatchMode,2
IfWinNotExist,gi-everywhere
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   MsgBox,,NotExist?, :( IfWinNotExist '%gi_everywhereAHK%' = gi_everywhereAHK  `n (line:%A_LineNumber%) `n , 2
}

   if(! FileExist(ActionListDir) )
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   FileCreateDir, % ActionListDir
   Sleep,100
   }
   if(! FileExist(ActionListDir) )
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   Last_A_This:=A_ThisFunc . A_ThisLabel 
   ToolTip1sec(A_LineNumber . " " .  RegExReplace(RegExReplace(A_LineFile,".*\\") , ".*\", "") " " Last_A_This) ;
   msg = 
   (
   :-(
   `n '%ActionListDir%' = ActionListDir
   do not exist.
   )
   MsgBox,% ":( =>Reload  `n  ! Exist(" ActionListDir ") " msg "`n("A_LineNumber " " RegExReplace(A_LineFile,".*\\") ")"

   Reload
   }
   if(! FileExist(sourceDir) )
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   Last_A_This:=A_ThisFunc . A_ThisLabel 
   ToolTip1sec(A_LineNumber . " " .  RegExReplace(RegExReplace(A_LineFile,".*\\") , ".*\", "") " " Last_A_This) ;
   msg_sourceDir = `n '%sourceDir%' = sourceDir  `n (line:%A_LineNumber%) `n
   MsgBox, :(  `n  ! Exist(sourceDir) %msg_sourceDir%
   }
   return  
}







simplifyNameOfActionListNEWstep1( ActionListNEW ) {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

;   ActionListNEW := "superSimple" . ".txt"
   return ActionListNEW ;
   
FoundPos := InStr(ActionListNEW, "\",0,-1 )
if( FoundPos )
   ActionListNEW:=SubStr(ActionListNEW,1,FoundPos) . "_" . SubStr(ActionListNEW,FoundPos)
ActionListNEW := RegExReplace(  ActionListNEW, "(\w)[^\\]+\\", "$1")  ; ChromeWidgetWin1\GmailGoogleChrome.ahk - Notepad++ ahk_class Notepad++ ==> EfpHAtTWCGmailGoogleChrome_txt_Notepad_.ahk

 ;~ MsgBox, '%ActionListNEW%' = ActionListNEW  `n (line:%A_LineNumber%) `n
ActionListNEW := RegExReplace(  ActionListNEW , "\s*\[[^\[\]]+\]+", "")  ; clone.ahk * SciTE4AutoHotkey [2 von 2]
ActionListNEW := RegExReplace(  ActionListNEW, "[\W_]+", "_")  . ".ahk"
; MsgBox,'%ActiveClass%' = ActiveClass  `n (line:%A_LineNumber%) `n 



ActionListNEW := "dummiTestFromLine" . A_LineNumber . ".ahk"
return ActionListNEW
}


encodeAHKchars( s ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   s := RegExReplace( s , "(""|``)", "$1$1")
   s := RegExReplace( s , "(``n|`%|\(|\))", "``$1")
   return s
}
encodeAHKcharsOLD( s ){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   s := RegExReplace( s , "(""|``)", "$1$1")
;   hi3 := RegExReplace( s , "(``)", "$1$1")
   s := RegExReplace( s , "`n", "``n")
   return s
}


selfPerformanceTest()
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

disableCopyQ() ; enableCopyQ() ;

   ClipboardBackup1703061259 := Clipboard
   ahkCode =
(
Clipboard = selfPerformanceTest
)
   ; test how long it takes , that clipboard will updated at this computer 06.03.2017 16:00
   ; ergebniss log:
 ; Sleep 156 ; millisec 20170306165639
 ; Sleep 62 ; millisec 17-03-06_17-29
 
   TickCount1 := A_TickCount ; YYYYMMDDHH24MISS 
   Loop,9
   {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   i := 0
      while(i++ < 99){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   Sleep,10
   result := DynaRunGetClipboard(ahkCode)
   if ( i > 100 || "selfPerformanceTest" == result)
      break
 }
    if ( "selfPerformanceTest" == result)
      break
}
millisec := A_TickCount - TickCount1
      Clipboard := "`; Sleep " . millisec . " `; millisec " . A_Now . " , line= " . A_LineNumber
    if ( "selfPerformanceTest" <> result)
      MsgBox, %   ":-( ERROR wrong result " . Clipboard
else {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

; MsgBox, % ":-)  " .  Clipboard
}

      Clipboard := ClipboardBackup1703061259

      enableCopyQ() ; enableCopyQ() ;
   return result
}

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
DynaRunGetClipboard2(ahkCode){

disableCopyQ() ; enableCopyQ() ;

 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   MsgBox, that function is obsolte now 11.03.2017 16:57 `n  '%ahkCode%' = ahkCode  `n (line:%A_LineNumber%) `n 
   ClipboardBackup1703061259 := Clipboard   
   Loop,9
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   DynaRun(ahkCode)
   i := 0
      while(i++ < 99){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   Sleep,10
   result  = %Clipboard%
   if ( i > 100 || ClipboardBackup1703061259 <> result )
      break
 }
    if ( ClipboardBackup1703061259 <> result )
      break
}
Clipboard := ClipboardBackup1703061259
   return result 
}
selfPerformanceTest2(){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   ClipboardBackup1703061259 := Clipboard
   ahkCode =
(
Clipboard = selfPerformanceTest2
)
   ; test how long it takes , that clipboard will updated at this computer 06.03.2017 16:00
   ; ergebniss log:
   ; Sleep 47 ; millisec 20170306171409
   ; Sleep 1623 ; millisec , now= 20170306172251, result=17-03-06_12-56, line:433
   ; Sleep 47 ; millisec , now= 20170306172412, result=17-03-06_12-56, line:431
   ; Sleep 47 ; millisec , now= 20170306172500, result=17-03-06_12-56, line:432
   ; Sleep 47 ; millisec , now= 20170306172844, result=17-03-06_12-56, line:450
   
   TickCount1 := A_TickCount ; YYYYMMDDHH24MISS 
   Loop,9
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   DynaRun(ahkCode)
   i := 0
      while(i++ < 99){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   Sleep,10
   result  = %Clipboard%
   if ( i > 100 || "selfPerformanceTest2" == result)
      break
 }
;    if ( i > 100 || "selfPerformanceTest2" == result)

    if ( "selfPerformanceTest2" == result)
      break
}
millisec := A_TickCount - TickCount1
      Clipboard := "`; Sleep " . millisec . " `; millisec , now= " . A_Now . ", result=" . result . ", line:" . A_LineNumber
    if ( "selfPerformanceTest2" <> result)
MsgBox, ERROR !!! :-( `n %Clipboard% `n (line:%A_LineNumber%) `n 
else{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

m = %Clipboard% `n (line:%A_LineNumber%) `n 
   ToolTip4sec(m)
}
MsgBox, 17-03-10_08-04
      Clipboard := ClipboardBackup1703061259
     enableCopyQ() ; enableCopyQ() ;
   return result 
}
;<<<<<<<<<<<<<< FileDeleteAsyncDynaRun <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
 FileDeleteAsyncDynaRun(fileAbsAdress , waitMiliBefore=3000){
  ahkCode =
  (
  Sleep, %waitMiliBefore%
  FIleDelete, %fileAbsAdress%
  exitapp
  )
  DynaRun(ahkCode)
  return
}
;>>>>>>>>>>>>> FileDeleteAsyncDynaRun >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

DynaRunENDarrsldkjfarrsldkjfl(TempScript, pipename="") {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   static _:="uint",@:="Ptr"
   If pipename =
      name := "AHK" A_TickCount
   Else
      name := pipename
   __PIPE_GA_ := DllCall("CreateNamedPipe","str","\\.\pipe\" name,_,2,_,0,_,255,_,0,_,0,@,0,@,0)
   __PIPE_    := DllCall("CreateNamedPipe","str","\\.\pipe\" name,_,2,_,0,_,255,_,0,_,0,@,0,@,0)
   if (__PIPE_=-1 or __PIPE_GA_=-1)
      Return 0
   ; gosub,couldIfindMyself
;IfNotExist, %A_AhkPath% "\\.\pipe\%name%"
;    Return 0
   Run, %A_AhkPath% "\\.\pipe\%name%",,UseErrorLevel HIDE, PID
   If ErrorLevel
      tooltip, % "Could not open file:`n" __AHK_EXE_ """\\.\pipe\" name """"
   DllCall("ConnectNamedPipe",@,__PIPE_GA_,@,0)
   DllCall("CloseHandle",@,__PIPE_GA_)
   DllCall("ConnectNamedPipe",@,__PIPE_,@,0)
   script := (A_IsUnicode ? chr(0xfeff) : (chr(239) . chr(187) . chr(191))) TempScript
   if !DllCall("WriteFile",@,__PIPE_,"str",script,_,(StrLen(script)+1)*(A_IsUnicode ? 2 : 1),_ "*",0,@,0)
        Return A_LastError,DllCall("CloseHandle",@,__PIPE_)
   DllCall("CloseHandle",@,__PIPE_)
while(WinExist(substr(name,1,-5)) && A_Index < 9)
WinClose,

   Return PID
}
FileWriteAndRun(sayHelloCode, sayHelloFunctionInc){
 global g_lineNumberFeedback

 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%


    DetectHiddenWindows,On
    SetTitleMatchMode,2
    winTC := sayHelloFunctionInc . " ahk_class AutoHotkey"
    if(winexist(winTC)){
        WinClose,% winTC
        WinWaitClose,% winTC,,1
    }
    if(winexist(winTC)){
        ToolTip,DONT WANT RUN '%winTC%'. its already exist. `n (line:%A_LineNumber%) `n 18-02-15_13-00bbb
        WinKill,% winTC
        WinWaitClose,% winTC,,2
        tooltip,
        return false
    }

   isFileExist := false
   ;feedbackMsgBox(sayHelloCode . "`n`n`n" . sayHelloFunctionInc,A_LineNumber . " Typing_Aid_everywhere_multi_clone.inc.ahk")
   FileWrite(sayHelloCode, sayHelloFunctionInc)
   Loop,200 ;  
   {
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   if(GetKeyState("Ctrl", "P"))
    KeyWait Control  ; Wartet darauf, dass sowohl STRG als auch ALT losgelassen wird.

   if(FileExist(sayHelloFunctionInc)){
    g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%
      isFileExist := true
      break
   }
   Sleep,20
   }
   
   ;gosub,couldIfindMyself
   if(FileExist(sayHelloFunctionInc))
    run, % sayHelloFunctionInc
;   MsgBox, '%sayHelloFunctionInc%' = sayHelloFunctionInc  `n (line:%A_LineNumber%) `n 
    return isFileExist 
}
FileWrite(sayHelloCode, sayHelloFunctionInc){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   if(FileExist(sayHelloFunctionInc))
      FileDelete, % sayHelloFunctionInc
   Sleep,100
   lll(A_LineNumber, A_LineFile, "FileAppend too " sayHelloFunctionInc)
    ;msgbox,% sayHelloCode
   FileAppend, % sayHelloCode, % sayHelloFunctionInc
   return 1
}
mvarInjects(ActionListDir, ActionListNEW, ActiveClass, activeTitle){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

if(!ActionListDir)
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

msgbox,!ActionListDir exitap (line:`%A_LineNumber`%) `n 17-03-19_14-06
exitapp
}
if(!ActionListNEW)
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

msgbox,!ActionListNEW exitap (line:`%A_LineNumber`%) `n
exitapp
}
if(!ActiveClass)
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

msgbox,!ActiveClass exitap (line:`%A_LineNumber`%) `n
exitapp
}
if(!activeTitle)
{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%
}

   varInjects =
   (
   ActionListDir = %ActionListDir%
   ActionListNEW = %ActionListNEW%
   ActiveClass = %ActiveClass%
   activeTitle = %activeTitle% `n
   )
   return varInjects
}
getWelcomeMsg(){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

msg = 
(
this `n `n  %A_LineFile% `n 

if you try to find which file belongs to your ActionList type _____ it hopefully helps
   
descriptions:
<word>|d|<description>
"Word descriptions can be added to 'ActionList .ahk' that will appear in the ActionList next to the word. These descriptions should be in the form of
<word>|d|<description>, e.g., Tylenol|d|Pain Reliever. 
This could be used for things like definitions, translation aids, or function arguments. When Fixed Width fonts are used in the ActionList, the description columns will be tabbed evenly so they line up."
04.03.017 16:16 from https://github.com/ManiacDC/gi-everywhere

replacements:
<word>|rr|<description> todo: descrip

<word>|r|<description>
"Word replacements can be added to 'ActionList.ahk' that will appear in the ActionList next to the word. These replacements should be in the form of
<word>|r|<description>, e.g., fire|r|fuego. 
When the word is chosen, it will be backspaced out and replaced with the new word. If Case Correction is off, the first letter will be changed to match the case of the word being replaced. This could be used for spelling replacements, text expansion, or translation aids. Multiple replacements can be defined for a word (put each on a separate line)."
04.03.017 16:16 from https://github.com/ManiacDC/gi-everywhere

problems:
may have problems with cooding. may save your ActionLists as UTF-8 or convert it. for e.g. with notepad. codierung > convert to UTF-8
hint from hints: http://stackoverflow.com/questions/2527269/any-tool-to-convert-bulk-php-files-to-utf-8-without-bom :
Before trying this, you must make a backup of your files.
You need to create a macro that does this:
Convert the currently opened file to UTF-8 w/o BOM;
Select all the text in your file, and copy it (why this? it looks like a bug. if you won't do this, your file will be replaced with your current clipboard content...);
Save the current file;
Close the current file.
Save this macro.
Now, open your files, and run it with the "Run a Macro Multiple Times..." command. If you opened 100 files, let it run for 100 times.

its not a bug, its a feature ;)
you may think first letters want replace. yes thats true. thats a feature ;) not a bug. you could choose by yourself to write it upper or lowercase. 05.03.2017 02:11

05.03.2017 01:26
)
return msg
}



;/¯¯¯¯ getAhkCodeInsideFile ¯¯ 181023081117 ¯¯ 23.10.2018 08:11:17 ¯¯\
getAhkCodeInsideFile(ActionListDir, ActionListFilterPath ) {
 global g_lineNumberFeedback
 g_lineNumberFeedback  := "(" A_ThisFunc "~" A_LineNumber "~" RegExReplace(A_LineFile,".*\\") ")"

ahkCodeInsideFile =
(
#SingleInstance, force
`; dontDeleteThisPlaceholder %g_lineNumberFeedback%
#Include %ActionListDir%\..\ActionListNameFilter.inc.ahk `; global ActionList . pleas dont delete this line! 17-03-06_10-59
ActionListFilterPath = %ActionListFilterPath% `n ; (line:`%A_LineNumber`%) `n

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
ActionListNEW_time_between := ActionListNEW
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

`; if you want you could use the follwong global variables fot calculating you new ActionListNEW : ActionListDir, ActionListNEW, ActiveClass, activeTitle
if `(!ActionListNEW `){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

    MsgBox, ERROR ActionListNEW is EMPTY 17-03-05_14-51
    exitapp
}
if `(!ActionListDir `){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

    MsgBox, ERROR ActionListDir is EMPTY 17-03-19_11-52
    exitapp
}

; this days i have to many files into hiere... i want first to activate the superglobal 10.08.2017 09:29
if(0 && !RegExMatch(trim(ActionListNEW),"\.ahk$")) ; dirty bug fix TODO: not pretty
    ActionListNEW .= ".ahk"
if( SubStr( ActionListNEW , -3 ) <> ".ahk" ) ; 06.03.2018 13:09
    ActionListNEW .= ".ahk"





`; Clipboard := ActionListNEW    we dont need that anymore. becouse now we work without the clipboard 09.03.2017 21:21 isInternMsgTransportIsClipboard := false `; false. then using fileSystem: readfile, include copyfile
`; Clipboard := ActionListNEW ``n %A_LineFile%~%A_ThisFunc%~%A_LineNumber% ``n we dont need that anymore. becouse now we work without the clipboard 09.03.2017 21:21 isInternMsgTransportIsClipboard := false `; false. then using fileSystem: readfile, include copyfile
`; tooltip,`%Clipboard`% = Clipboard 123496854
)



return ahkCodeInsideFile
}
;\____ getAhkCodeInsideFile __ 181023081130 __ 23.10.2018 08:11:30 __/





;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
DynaRunGetClipboard(value){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

disableCopyQ() ; enableCopyQ() ;

   MsgBox, 17-03-10_08-06
   ; if you make much clipboard work during the test, you could see its not working fine :( 07.03.2017 01:05
;   id = 17-03-07_00-32 ; without this nummer you get some 1000 without any false, some with some false 07.03.2017 00:49
   id := A_TickCount . "_line_" . A_LineNumber ; ; first teset no error with value
      ;~ value := RegExReplace(value,"(Clipboard\s*:=)\s*(\w+)", "$1" . " . """ . id . """ " . "$2" )  ; Clipboard := ActionListNEW
      ;~ value := RegExReplace(value,"(Clipboard\s*:=)\s*(\w+)", "$1" . " . """ . id . """ " . "$2" )  ; Clipboard := ActionListNEW
if(RegExMatch(value, "Clipboard\s*:?=") ) {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   ahkCode  := RegExReplace(value,"(Clipboard\s*:=)\s*(\w+)", "$1" . " """ . id . """ . " . "$2" )  ; Clipboard := ActionListNEW
   ;~ Clipboard := ahkCode ; debugging only
   ;~ MsgBox, '%Clipboard%' = Clipboard  `n (line:%A_LineNumber%) `n  ; debugging only
}
else{
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   yesValueShouldGetEqualResult := true
token = %id%%value%
ahkCode =
(
Clipboard =  %token%
)
}
; Clipboard := ahkCode  ; debugging reasons 17-03-07_19-14
; MsgBox, '%ahkCode%' = ahkCode  `n (line:%A_lineNumber%) `n 
   k := 0
   while( k++ < 1000) {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

      
         idBackup := A_TickCount  . "_line_" . A_LineNumber
   ClipboardBackup1703061255 =%idBackup%%Clipboard% ; this only allows text clipboard 07.03.2017 09:15


   result := DynaRunGetClipboard2(ahkCode)
   restoreOldClipboard(idBackup, ClipboardBackup1703061255 )
;      Clipboard := ClipboardBackup1703061255 ; sometimes this not turn to old value :( 07.03.2017 01:01
    ;  ToolTip, % result
   if(foundPos:=InStr(result,id)) ; usually its the first try. if there is no user action all are ok. if you act every 100 it could one false
      break
   Sleep,10 ; its needet. if you chunk your clipboad it takes a  little time (few seconds) sometimes, till the script runs again. 07.03.2017 00:57
   ;restoreOldClipboard(idBackup, ClipboardBackup1703061255 ) ; Clipboard := ClipboardBackup1703061255 ; sometimes not work :( 07.03.2017
}
   if(foundPos){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

               result:=SubStr(result , StrLen(id)+1)
   }  else
      MsgBox, :( id not found `n  '%id%' = id  `n`n   result= '%result%' `n `n  token = '%token%'  `n (line:%A_LineNumber%) `n 
   if( yesValueShouldGetEqualResult && result <> value )
      MsgBox, :( '%id%' = id  `n  result= '%result%' <> '%token%'  `n (line:%A_LineNumber%) `n ; and sometimes it happens anyway . id was not wiped out 07.03.2017 08:18



;Sleep,100
;   restoreOldClipboard(idBackup, ClipboardBackup1703061255 )

; sure id cant be inside. or not?
   if(foundPos:=InStr(result, id )) ; usually its the first try. if there is no user action all are ok. if you act every 100 it could one false
MsgBox, :( '%id%' = id   `n  '%result%' = result  `n (line:%A_LineNumber%) `n 

enableCopyQ() ; enableCopyQ() ;

   return result
}
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

selfTestLoop1000(loopMax){
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

   MsgBox, 17-03-10_08-04
   ; if you make much clipboard work during the test, you could see its not working fine :( 07.03.2017 01:05
   i := 0
;   id = 17-03-07_00-32 ; without this nummer you get some 1000 without any false, some with some false 07.03.2017 00:49
   while( i++ < loopMax)    {
 global g_lineNumberFeedback
 g_lineNumberFeedback=%A_LineFile%~%A_ThisFunc%~%A_LineNumber%

      ToolTip, %i% < %loopMax%
      value = selfTest1703061808i%i%
      ;ahkCode := "Clipboard . " = "" . value . """"
 result :=  DynaRunGetClipboard(value)

    }
    if(result <> value )
        MsgBox, :( value = '%value%' <> '%result%' = result  `n (line:%A_LineNumber%) `n
    return result
}

;<<<<<<<<<<<<<<<<<<< getInitialActionList <<<<<<<<<<<<<<<<<<<<<<<<<<<
getInitialActionList(ActionListNEWarchivePath,ActionListNEW){
; Start filling the template variable with useful examples 12.07.2017 21:18

if(!ActionListNEWarchivePath)
    Msgbox,Oops !ActionListNEWarchivePath `n (Typing_Aid_everywhere_multi_clone.inc.ahk~%A_ThisFunc%~%A_`LineNumber%) `

ActionListFileName := RegExReplace(ActionListNEWarchivePath,".*\\([^\\]+)$","$1") ; 20.03.2018 00:15

calledFromStr := A_ThisFunc ":" A_LineNumber " " RegExReplace(A_LineFile, ".*\\")
initialActionList =
(
; only meta info (not importand): %calledFromStr%
___open ActionList|rr||ahk|openInEditor,%ActionListFileName%
; if you could read this germen special character (umlaute) your file format is correct (please use UTF8)
; ä = thats a au
)
; EndOf filling the template variable with useful examples 12.07.2017 21:18
return initialActionList
}
;>>>>>>>>>>>>>>>>>>>>> getInitialActionList >>>>>>>>>>>>>>>>>>>>>>>>>

#Include *i %A_ScriptDir%\inc_ahk\functions_global.inc.ahk
;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
;~ subroutinen beispielsweise müsen ans Dateiende
#Include *i %A_ScriptDir%\inc_ahk\functions_global_dateiende.inc.ahk


;/¯¯¯¯ ExitAPP_if_NOT_ActionListNEWarchivePath_and_NOT_ActionListNEW ¯¯ 181023104727 ¯¯ 23.10.2018 10:47:27 ¯¯\
ExitAPP_if_NOT_ActionListNEWarchivePath_and_NOT_ActionListNEW(ALineNumber, AThisFunc, ActionListNEWarchivePath, ActionListGeneratedPath , ActionListNEW){

    return ; todo: thats only for testing. 23.10.2018 10:50
    ;


  if( !FileExist(ActionListNEWarchivePath) ) {
    global g_lineNumberFeedback
    g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.inc.ahk / %A_LineFile% ~%AThisFunc%~%ALineNumber%
    msg = :( !FileExist(%ActionListNEWarchivePath%)) `n `n '%ActionListNEWarchivePath%' = ActionListNEWarchivePath  `n '%ActionListGeneratedPath%' = ActionListGeneratedPath  `n ActionListNEW= %ActionListNEW% `n ==> ExitAPP 17-08-11_01-01
    tooltip,%msg% `n`n ( %g_lineNumberFeedback% )

    lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  msg)


    ; lll(AThisFunc . "~" . ALineNumber, A_ScriptName, msg)
    Sleep,3000 ; function ActionListNEWactivate ??? right ??
    ExitAPP
  }
  return
}
;\____ ExitAPP_if_NOT_ActionListNEWarchivePath_and_NOT_ActionListNEW __ 181023104733 __ 23.10.2018 10:47:33 __/


;<<<<<<<<<<<<<<<<<< ExitAPP_if_NOT_ActionListGeneratedPath <<<<<<<<<<<<<<<<<<<<<<<<<<<<
ExitAPP_if_NOT_ActionListGeneratedPath(ALineNumber, AThisFunc, ActionListNEWarchivePath, ActionListGeneratedPath , ActionListNEW){
  if(!FileExist(ActionListGeneratedPath)) {
    global g_doSaveLogFiles
    g_doSaveLogFiles := 1
    global g_lineNumberFeedback
    ;g_lineNumberFeedback=%A_LineFile%~%AThisFunc%~%ALineNumber%
    g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.inc.ahk / %A_LineFile% ~%AThisFunc%~%ALineNumber%
    msg = :( !FileExist(%ActionListNEWarchivePath%)) `n `n '%ActionListNEWarchivePath%' = ActionListNEWarchivePath  `n '%ActionListGeneratedPath%' = ActionListGeneratedPath  `n ActionListNEW= %ActionListNEW% `n ==> ExitAPP 17-08-11_00-00 `n %g_lineNumberFeedback%
    tooltip,% msg


    lll_if_g_doSaveLogFiles(ALineNumber, A_ScriptName, msg)

    ;lll(AThisFunc . "~" . ALineNumber, A_ScriptName, msg)
    Sleep,3000 ; function ActionListNEWactivate ??? right ??
    ExitAPP
  }
  return
}
;>>>>>>>>>>>>>> ExitAPP_if_NOT_ActionListGeneratedPath >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<<<<< lll_if_g_doSaveLogFiles <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,msg ){
    lll(AThisFunc . "~" . ALineNumber, "Typing_Aid_everywhere_multi_clone.inc.ahk" , msg)
    ; llll(A_LineNumber, A_LineFile, "")
; Msgbox,'%g_doSaveLogFiles%' = g_doSaveLogFiles   (%A_LineFile%~%A_LineNumber%) `
return
}
;>>>>>>>>>>>>>>>>> lll_if_g_doSaveLogFiles >>>>>>>>>>>>>>>>>>>>>>>>>>><>

; ActionListNEWarchivePath
save_ActionListGeneratedPath(ActionListGeneratedPath,includeFileSContent,ActionListNEWarchivePath) {

if(!ActionListNEWarchivePath){
    Tooltip, >%fileContent%< =fileContent `n (from: %A_LineFile%~%A_LineNumber%)
    ; msgbox,cant read  >%fileContent%< =fileContent `n  becouse !ActionListNEWarchivePath `n (from: %A_LineFile%~%A_LineNumber%)

        global g_doSaveLogFiles
        g_doSaveLogFiles := 1
        global g_lineNumberFeedback

        g_lineNumberFeedback=Typing_Aid_everywhere_multi_clone.inc.ahk / %A_LineFile% ~%A_ThisFunc%~%A_LineNumber%

        msg=:( !fileContent `n `n ==> ExitApp  `n `n (g_lineNumberFeedback)
        tooltip,% msg
        lll_if_g_doSaveLogFiles(A_LineNumber, A_ScriptName, msg)
    ExitApp
}

    ExitAPP_if_NOT_ActionListGeneratedPath (A_LineNumber, A_ThisFunc, ActionListNEWarchivePath, ActionListGeneratedPath , ActionListNEW)
    ;ExitAPP_if_NOT_ActionListGeneratedPath (A_LineNumber, A_ThisFunc, ActionListNEWarchivePath, ActionListGeneratedPath , ActionListNEW)

    if(FileExist(ActionListGeneratedPath))
        FileDelete, %ActionListGeneratedPath%
    Sleep,60
    lll(A_LineNumber, A_LineFile, "FileAppend too " ActionListGeneratedPath)
    FileAppend,% includeFileSContent, % ActionListGeneratedPath
    ; Sleep,20
    FileRead, fileContent, %ActionListNEWarchivePath%
    ;Sleep,20
    lll(A_LineNumber, A_LineFile, "FileAppend too " ActionListGeneratedPath)
    FileAppend,% fileContent, % ActionListGeneratedPath
    if(false)lll(A_LineNumber, A_LineFile, "SAVED: " . ActionListGeneratedPath)
    Sleep,60
    return
}

lll_if_g_doSaveLogFiles_matches(ALineNumber, AThisFunc, matchs1,matchs2,matchs3,matchs4){
if(0){
lll:=";<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<", "matchs1: " . matchs1
tooltip,'%lll%' = lll    (line:%A_LineNumber%)
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  lll)
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  "matchs2=" . matchs2)
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  "matchs3=" . matchs3)
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  "matchs4=" . matchs4)
lll_if_g_doSaveLogFiles(ALineNumber, AThisFunc,  ";>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>")
}
return
}