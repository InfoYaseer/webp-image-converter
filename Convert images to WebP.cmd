@echo off
setlocal EnableExtensions DisableDelayedExpansion

rem Drag one or more square PNG/JPG images onto this file.
rem Each batch is saved under WebP Images next to this script.
set "encoder=%~dp0bin\cwebp.exe"
if not exist "%encoder%" set "encoder=%~dp0cwebp.exe"
if exist "%encoder%" goto encoder_found
set "encoder=cwebp.exe"
where cwebp.exe >nul 2>&1
if errorlevel 1 goto missing_encoder
:encoder_found
if "%~1"=="" goto usage
set "outputRoot=%~dp0WebP Images"
set "batchFolder="
set /a converted=0
set /a failed=0

goto next

:create_batch
if not exist "%outputRoot%" mkdir "%outputRoot%"
if not exist "%outputRoot%" goto folder_error
for /f %%T in ('powershell -NoProfile -Command "Get-Date -Format yyyy-MM-dd_HH-mm-ss-fff"') do set "stamp=%%T"
if not defined stamp goto folder_error
set "batchFolder=%outputRoot%\%stamp%"
set /a batchNumber=2
:unique_batch
if not exist "%batchFolder%" goto make_batch
set "batchFolder=%outputRoot%\%stamp%_%batchNumber%"
set /a batchNumber+=1
goto unique_batch

:make_batch
mkdir "%batchFolder%"
if errorlevel 1 goto folder_error
goto encode_ready

:next
if "%~1"=="" goto done
if not exist "%~f1" goto missing_input
if /i "%~x1"==".png" goto encode
if /i "%~x1"==".jpg" goto encode
if /i "%~x1"==".jpeg" goto encode
echo Skipped unsupported file: "%~nx1"
goto advance

:missing_input
echo Skipped missing file: "%~1"
goto advance

:encode
if not defined batchFolder goto create_batch
:encode_ready
set "outputFile=%batchFolder%\%~n1.webp"
set /a fileNumber=2
:unique_file
if not exist "%outputFile%" goto convert
set "outputFile=%batchFolder%\%~n1_%fileNumber%.webp"
set /a fileNumber+=1
goto unique_file

:convert
echo Converting "%~nx1" ...
"%encoder%" -preset photo -q 85 -m 6 -sharp_yuv -resize 720 720 "%~f1" -o "%outputFile%" -quiet
if errorlevel 1 goto conversion_failed
set /a converted+=1
for %%I in ("%outputFile%") do set "sizeBytes=%%~zI"
set /a "sizeKb=(sizeBytes+1023)/1024"
echo Created "%outputFile%" - %sizeKb% KB
if %sizeBytes% GTR 512000 echo Note: This image exceeds 500 KB. Review its quality and size.
goto advance

:conversion_failed
set /a failed+=1
echo Failed to convert "%~nx1".

:advance
shift
goto next

:done
echo.
echo Finished: %converted% converted, %failed% failed.
if defined batchFolder echo Output folder: "%batchFolder%"
pause
exit /b 0

:missing_encoder
echo cwebp.exe was not found.
echo Place cwebp.exe in the bin folder beside this script, or add it to PATH.
echo Download: https://developers.google.com/speed/webp/download
pause
exit /b 1

:usage
echo Drag one or more square PNG or JPG images onto this file.
pause
exit /b 1

:folder_error
echo Could not create a new output folder under "%outputRoot%".
pause
exit /b 1
