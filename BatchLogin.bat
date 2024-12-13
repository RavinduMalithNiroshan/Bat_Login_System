@echo off
title Login Page

setlocal enabledelayedexpansion

rem Set your username and password
set "username=admin"
set "password=12345"
set "data_file=data.txt"

:login
cls
echo ==========================
echo        LOGIN PAGE
echo ==========================
echo.
set /p "input_username=Username: "
set /p "input_password=Password: "

if "!input_username!"=="%username%" (
    if "!input_password!"=="%password%" (
        call :main_menu
        exit
    ) else (
        echo.
        echo Incorrect password! Please try again.
        pause
        goto login
    )
) else (
    echo.
    echo Incorrect username! Please try again.
    pause
    goto login
)

:main_menu
cls
echo ==========================
echo         MAIN MENU
echo ==========================
echo 1. Add
echo 2. Update
echo 3. View
echo 4. Exit
echo.
set /p "choice=Choose an option: "

if "%choice%"=="1" (
    call :add_data
    goto main_menu
) else if "%choice%"=="2" (
    call :update_data
    goto main_menu
) else if "%choice%"=="3" (
    call :view_data
    goto main_menu
) else if "%choice%"=="4" (
    exit
) else (
    echo Invalid choice! Please try again.
    pause
    goto main_menu
)

:add_data
cls
echo ==========================
echo          ADD PAGE
echo ==========================
echo.
set /p "name=Enter Name: "
set /p "address=Enter Address: "
set /p "mobile=Enter Mobile Number: "
echo !name!, !address!, !mobile! >> "%data_file%"
echo Data added successfully!
pause
goto main_menu

:update_data
cls
echo ==========================
echo        UPDATE PAGE
echo ==========================
echo.
echo Enter the line number you want to update (starting from 1):
set /p "line_number=Line number: "
setlocal enabledelayedexpansion
set "temp_file=temp.txt"
set "current_line=0"

for /f "delims=" %%a in ('type "%data_file%"') do (
    set /a current_line+=1
    if !current_line! == %line_number% (
        set /p "name=Enter new Name: "
        set /p "address=Enter new Address: "
        set /p "mobile=Enter new Mobile Number: "
        echo !name!, !address!, !mobile! >> "!temp_file!"
    ) else (
        echo %%a >> "!temp_file!"
    )
)

move /y "!temp_file!" "%data_file%"
endlocal
echo Data updated successfully!
pause
goto main_menu

:view_data
cls
echo ==========================
echo          VIEW PAGE
echo ==========================
echo.
if exist "%data_file%" (
    type "%data_file%"
) else (
    echo No data found.
)
pause
goto main_menu