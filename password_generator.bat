@echo off
setlocal enabledelayedexpansion

:: Password generation settings
set "length=12"
set "includeUppercase=true"
set "includeLowercase=true"
set "includeNumbers=true"
set "includeSpecial=true"

:: Define character sets
set "uppercase=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
set "lowercase=abcdefghijklmnopqrstuvwxyz"
set "numbers=0123456789"
set "special=!@#$%^&*()-_=+[]{};:,.<>?/~"

:: Initialize character pool
set "charset="

if "%includeUppercase%"=="true" set "charset=!charset!!uppercase!"
if "%includeLowercase%"=="true" set "charset=!charset!!lowercase!"
if "%includeNumbers%"=="true" set "charset=!charset!!numbers!"
if "%includeSpecial%"=="true" set "charset=!charset!!special!"

:: Check if charset is empty
if "!charset!"=="" (
    echo No character sets selected. Exiting.
    exit /b
)

:: Prompt user for website name
set /p "website=Enter the website name: "

:: Generate password
set "password="
set "charsetLength=0"

:: Calculate length of character set
for /l %%i in (0,1,61) do (
    set "char=!charset:~%%i,1!"
    if defined char (
        set /a charsetLength+=1
    ) else (
        goto :endCharsetLoop
    )
)
:endCharsetLoop

for /l %%i in (1,1,%length%) do (
    set /a "rand=!random! %% charsetLength"
    for %%j in (!rand!) do (
        set "password=!password!!charset:~%%j,1!"
    )
)

echo Your generated password is: !password!

:: Save to text file
(
    echo Website: !website!
    echo Password: !password!
) >> passwords.txt

echo Password saved to passwords.txt

endlocal
pause
