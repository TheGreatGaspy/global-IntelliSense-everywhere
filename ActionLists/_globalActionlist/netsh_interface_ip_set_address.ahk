___netsh_interface_ip_set_address|rr||ahk|run,..\FreeCommanderXESingleInst1\..\_globalWordLists\netsh_interface_ip_set_address.ahk
; 'C:\Windows\system32\cmd.exe (Admin)' = at  
 
;<<<<<<<< https://www.windowspro.de/wolfgang-sommergut/ping-windows-10-erlauben-gui-powershell-netsh-gpo <<<< 170814052337 <<<< 14.08.2017 05:23:37 <<<<
netsh firewall ping ip remoteip 192.168.0.11|rr||ahk|netsh advfirewall firewall set rule profile=Domain name="Datei- und Druckerfreigabe (Echoanforderung - ICMPv4 eingehend)" new enable=yes remoteip=192.168.0.11

netsh firewall "TCP/IP-Befehl Ping" remoteip 192.168.0.11|rr||ahk|netsh advfirewall firewall set rule profile=Domain name="TCP/IP-Befehl Ping" new enable=yes remoteip=192.168.0.11

netsh firewall ping ip remoteip 192.168.178.11|rr||ahk|netsh advfirewall firewall set rule profile=Domain name="Datei- und Druckerfreigabe (Echoanforderung - ICMPv4 eingehend)" new enable=yes remoteip=192.168.178.11
;>>>>>>>> https://www.windowspro.de/wolfgang-sommergut/ping-windows-10-erlauben-gui-powershell-netsh-gpo >>>> 170814052359 >>>> 14.08.2017 05:23:59 >>>>

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; netsh interface ip set address "SL5Box" static 192.168.0.9 255.255.255.0 192.168.0.1 1
; netsh 168.0.9|r|netsh interface ip set address "SL5Box" static 192.168.0.9 255.255.255.0 192.168.0.1 1
; netsh 168.0.9|rr||ahk|Wingetactivetitle, ActiveTitle `n tc:="cmd.exe (Admin)" `nWinActivate, % tc `n  WinWaitActive,% tc `n send, netsh interface ip set address "SL5Box" static 192.168.0.9 255.255.255.0 192.168.0.1 1{enter} `n WinActivate, % ActiveTitle

netsh ip 192.168.178.10|rr||ahk|address=192.168.178.10 `n#incDynAhk\netsh_interface_ip_set_address.ahk
netsh ip 192.168.0.10|rr||ahk|address=192.168.0.10 `n#incDynAhk\netsh_interface_ip_set_address.ahk

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

;<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
; bei source=dhcp wird auch bei aktivem Wlan automatisch das lan verwendet :) freu :) im speedtest wars üblich schnell (bzw fast, 80mbit wegen dem kleinen hub dazwischen. 27.07.2017 16:05)
; https://de.wikipedia.org/wiki/Netsh#Beispielanwendung
; netsh interface ip set address name="SL5Box" source=dhcp
; netsh dhcp|r|netsh interface ip set address name="SL5Box" source=dhcp
; cmd.exe (Admin) ahk_class VirtualConsoleClassGhost
; found|rr||ahk|tc:="cmd.exe (Admin)" `n WinActivate, % tc `n  WinWaitActive,% tc `n msgbox, netsh interface ip set address name="SL5Box" source=dhcp

; netsh dhcp|rr||ahk|Wingetactivetitle, ActiveTitle `n tc:="cmd.exe (Admin)" `nWinActivate, % tc `n  WinWaitActive,% tc `n send, netsh interface ip set address name="SL5Box" source=dhcp{enter} `n WinActivate, % ActiveTitle

netsh dhcp|rr||ahk|address=dhcp `n#incDynAhk\netsh_interface_ip_set_address.ahk
dhcp netsh|rr||ahk|q=netsh dhcp


;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
ping 192.168.0.11|rr||ahk|ping 192.168.0.11
