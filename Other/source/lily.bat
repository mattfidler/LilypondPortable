:: Lilypond batch file.
@echo off
echo All Arguments %*
for  %%i in (%*) do (
    echo Attempting to convert %%i
    %%~di
    cd %%~pi
    lilypond %%~ni
    
)
:: PAUSE
