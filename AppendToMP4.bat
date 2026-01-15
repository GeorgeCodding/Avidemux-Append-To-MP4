@echo off
setlocal enabledelayedexpansion

:: Set to avidemux path
set "ADM=C:\Program Files\Avidemux 2.8 VC++ 64bits\avidemux.exe"

:: --- 2. GET FILENAME ---
set "target=%~1"

:: Check if the user passed a filename
if "%target%"=="" (
    echo.
    echo Error: No file name was provided
    echo Example: If you have video1.mkv, video2.mkv, video3.mkv..., enter video.mkv
    echo.
    set /p "target=Enter the base filename: "
)

:: Clean up quotes if the user typed them manually
set "target=%target:"=%"

set "name=%~n1"
set "file_ext=%~x1"


:: If the user typed it manually %~x1 might be empty
if "%name%"=="" (
    for %%A in ("%target%") do (
        set "name=%%~nA"
        set "file_ext=%%~xA"
    )
)

set "count=1"
set "firstFile=!name!!count!!file_ext!"


if not exist "!firstFile!" (
    if not exist "!target!" (
	
    	echo Error: Could not find the starting file "!firstFile!" or "!target!", Exiting...
	pause
	exit /b
)
    	echo Base file !target! was found. Converting to mp4...

	set "outputFile=!name!.mp4"
	"!ADM!" --load "!target!" --video-codec copy --audio-codec copy --output-format MP4 --save "!outputFile!" --quit
	if !ERRORLEVEL! EQU 0 (
            echo Success: "!outputFile!" created.
        ) else (
            echo An error occurred during conversion.
        )

	pause
	exit /b
	
)

if not exist "

:: Building the argument
set "args=--load "!firstFile!""


:: --- 3. LOOP AND APPEND ---
:loop
set /a count+=1
set "nextFile=!name!!count!!file_ext!"
echo Checking for: "!nextFile!"

if exist "!nextFile!" (
    echo Found: !nextFile!
    set "args=!args! --append "!nextFile!""
    goto loop
)


echo No more files found. Total parts to merge: %count%-1
echo Running Avidemux...


"!ADM!" !args! --video-codec copy --audio-codec copy --output-format MP4 --save "!target!" --quit

if %ERRORLEVEL% EQU 0 (
    echo Success: "!target!" created.
) else (
    echo An error occurred during the merge.
)

pause