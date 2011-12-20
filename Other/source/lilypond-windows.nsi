##"C:\Program Files\LilyPond\usr\bin\lilypond-windows.exe" -dgui
## https://github.com/janneke/gub/blob/master/nsis/lilypond.nsi
SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On
Icon    "..\..\App\AppInfo\appicon.ico"
OutFile "..\..\LilypondPortable.exe"

CRCCheck On
WindowIcon Off
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user

!include "FileFunc.nsh"
!insertmacro GetParameters


Function .onInit
  InitPluginsDir
  Delete "$PLUGINSDIR\byte-compile.bat"
  SetOutPath "$PLUGINSDIR"
  File "lily.bat"
FunctionEnd


Section
  ${GetParameters} $R1
  ## Add GnuWin32 tools to executable path.
  System::Call 'Kernel32::GetEnvironmentVariable(t , t, i) i("PATH", .r0, ${NSIS_MAX_STRLEN}).r1'

  System::Call 'Kernel32::SetEnvironmentVariableA(t, t) i("PATH", "$EXEDIR\App\LilyPond\usr\bin;$0").r3'
  StrCmp "$R1" "" 0 +3
  ExecWait '"$EXEDIR\App\LilyPond\usr\bin\lilypond-windows.exe" -dgui'
  Goto +2
  ExecWait '"$PLUGINSDIR\lily.bat" $R1'
  Delete "$PLUGINSDIR\lily.bat"
  RMDir /r '$PLUGINSDIR'
SectionEnd






