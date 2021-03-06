##Examples directory launcher
## "C:\Program Files\LilyPond\usr\share\doc\lilypond\input"

SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On
Icon    "..\..\App\AppInfo\note.ico"
OutFile "..\..\LilypondTutorial.exe"

CRCCheck On
WindowIcon Off
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user


Function openLinkNewWindow
  Push $3
  Exch
  Push $2
  Exch
  Push $1
  Exch
  Push $0
  Exch
  
  ReadRegStr $0 HKCR "http\shell\open\command" ""
  # Get browser path
  DetailPrint $0
  StrCpy $2 '"'
  StrCpy $1 $0 1
  StrCmp $1 $2 +2 # if path is not enclosed in " look for space as final char
  StrCpy $2 ' '
  StrCpy $3 1
  loop:
    StrCpy $1 $0 1 $3
    DetailPrint $1
    StrCmp $1 $2 found
    StrCmp $1 "" found
    IntOp $3 $3 + 1
    Goto loop
    
  found:
    StrCpy $1 $0 $3
    StrCmp $2 " " +2
    StrCpy $1 '$1"'
    
    Pop $0
    Exec '$1 $0'
    Pop $0
    Pop $1
    Pop $2
    Pop $3
FunctionEnd

!macro _OpenURL URL
  Push "${URL}"
  Call openLinkNewWindow
!macroend

!define OpenURL '!insertmacro "_OpenURL"'

Section
  ${OpenURL} "lilypond.org/tutorial"
SectionEnd
