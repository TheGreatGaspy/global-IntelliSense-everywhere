; 

temp =
(
Herzliche Gr��e/Herzlichen Gru�
Sch�ne Gr��e/Sch�nen Gru�
Liebe Gr��e/Lieben Gru�
Viele Gr��e
Beste Gr��e
Freundliche Gr��e
Einen guten Start in die Woche/� ins Wochenende
Ein tolles Wochenende
Ein sch�nes Wochenende
Eine tolle Woche
Noch eine erfolgreiche Woche
Noch einen sch�nen [Montag]/angenehmen Wochenausklang
Mit den besten W�nschen f�r �
� in diesem Sinne sch�ne Gr��e
Ich freue mich auf [ein Wiedersehen, das Treffen etc.]
Alles Gute und viele Gr��e
Vielen Dank und bis bald!
Ich freue mich auf Ihre R�ckmeldung und verbleibe mit herzlichen Gr��en �
Liebe Gr��e aus [Wien] nach [M�nchen]
Sch�ne/herbstliche/fr�hlingshafte Gr��e aus dem heute sonnigen [Wien]
)
; Noch einen sch�nen MontagEinen guten Start in die Woche
; Noch einen sch�nen [Montag]/angenehmen Wochenausklang
; Einen guten Start in die Woche
Random,r,1,10
if(r == 10 )
  send,Noch einen sch�nen %A_DDDD% ; Montag / Dienstag usw.
else
; A_WDay Current 1-digit day of the week (1-7). 1 is Sunday in all locales. 
if ( A_WDay  == 6  )  ; 6 freitag
  Send, Noch einen angenehmen Wochenausklang`,
else 
if ( A_WDay  == 7 OR A_WDay  == 1 ) { ; 7 samstag ,  1 sonntag
  ; http://www.zeitblueten.com/news/grussformeln/
  ; https://www.google.de/webhp?q=gru%C3%9Fformeln
;  Einen guten Start in die Woche/� ins Wochenende

; Ein tolles Wochenende
Random, r ,1,2
if( r == 1 )
  Send, Ein sch�nes Wochenende`,
else
  Send, Einen guten Start ins Wochenende`,
} else
if ( A_WDay  == 2  ) { ; 2 montag 
  ; http://www.zeitblueten.com/news/grussformeln/
  ; https://www.google.de/webhp?q=gru%C3%9Fformeln
;  Einen guten Start in die Woche/� ins Wochenende

; Ein tolles Wochenende
Send, Ihnen einen guten Start in die Woche`,
; 2
}  else
if ( A_WDay  == 3  ) { ; 2 dienstag
; https://www.google.de/webhp?q=%2Bweiterhin+eine+erfolgreiche+Woche+dienstag
; Noch eine gute / erfolgreiche Woche
; Send, Ihnen einen guten Start in die Woche`,
; Send, Ihnen einen guten Start in die Woche`,
Send, Beste Gr��e, ; gute Alternative f�r alle, die eine Variante zwischen freundlichen und herzlichen Gr��en suchen. (https://www.impulse.de/management/unternehmensfuehrung/grussformeln/2182826.html)
; �Viele Gr��e� sind als Gru�formel geeignet, wenn man informell und wiederholt schreibt. ( https://www.impulse.de/management/unternehmensfuehrung/grussformeln/2182826.html )
}  else
  Send, Beste Gr��e,
  ;Send, Viele Gr��e,
; Guten Abend

;
; Send , % A_WDay 
; 22Einen guten Start in die Woche/� ins Wochenende
;  "... bis dahin verbleibe ich mit freundlichen Gr��en" 
; Sonnige Gr��e - wenn es die Wetterlage zul�sst
