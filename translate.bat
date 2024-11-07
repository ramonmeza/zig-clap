:: This is some AI generated batch file to run the zig translate-c command over 
:: .h files in a directory. It isn't recursive, so you have to manually set each 
:: directory, each run. Kind of annoying, but oh well.
@echo off
setlocal enabledelayedexpansion

:: Set the directory containing .H files
set "sourceDir=D:\code\projects\zig\zig-clap\deps\clap\include\clap\factory"
set "outputDir=D:\code\projects\zig\zig-clap\src"

:: Create output directory if it doesn't exist
if not exist "!outputDir!" (
    mkdir "!outputDir!" || (
        echo Failed to create directory: "!outputDir!"
        exit /b 1
    )
)

:: Iterate through each .H file in the source directory
for %%F in ("%sourceDir%\*.H") do (
    set "filename=%%~nxF"
    set "outputFile=!outputDir!\%%~nF.zig"
    echo Processing !filename!...

    :: Run the zig command
    zig translate-c "%%F" > "!outputFile!" 2>nul
    if errorlevel 1 (
        echo Error processing !filename! with zig.
    ) else (
        echo Successfully processed !filename! to !outputFile!.
    )
)

echo All files processed.
endlocal