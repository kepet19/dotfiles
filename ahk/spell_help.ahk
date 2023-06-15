#Requires AutoHotkey v2.0


::.obad::
{
    SendInput "https://goto.netcompany.com/cases/GTO399/NCOBAD/Lists/Tasks/DispForm.aspx?ID="
}

::.ddo::
{
    SendInput "https://ordnet.dk/ddo/ordbog?query="
}

::.synonym::
{
    SendInput "https://synonymet.dk/ord/"
}

::.asci::
{
    SendInput "https://patorjk.com/software/taag/#p=display&h=2&v=0&f=Big&t="
}

; :*:]d::  ; This hotstring replaces "]d" with the current date and time via the commands below.
; {
;     SendInput FormatTime(, "M/d/yyyy h:mm tt")
; }
