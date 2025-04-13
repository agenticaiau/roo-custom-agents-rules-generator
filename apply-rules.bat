@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul

echo DEBUG: Script started

if "%~1"=="" (
    echo Error: Please provide the target project directory
    echo Usage: %~nx0 ^<target-project-directory^>
    exit /b 1
)
set "TARGET_DIR=%~1"

if not exist "%TARGET_DIR%\" (
    echo Creating new project directory: %TARGET_DIR%
    mkdir "%TARGET_DIR%"
    (
        echo # New Project
        echo.
        echo This project has been initialized with agile workflow support and auto rule generation configured from [roo-auto-rules-agile-workflow](https://github.com/bmadcode/roo-auto-rules-agile-workflow)
        echo.
        echo For workflow documentation, see [Workflow Rules](docs/workflow-rules.md)
    ) > "%TARGET_DIR%\README.md"
)

REM Create .roo directory if it doesn't exist
if not exist "%TARGET_DIR%\.roo\" (
    mkdir "%TARGET_DIR%\.roo"
)

REM Function to copy file if it doesn't exist
:copy_if_not_exists
set "src=%~1"
set "dest=%~2"
if not exist "%dest%" (
    echo 📦 Copying new file: %~nx2
    copy "%src%" "%dest%" >nul
) else (
    echo ⏭️  Skipping existing file: %~nx2
)
exit /b

REM Copy all files from .roo directory structure
echo 📦 Copying .roo directory files...
for /r ".roo" %%F in (*) do (
    set "rel_path=%%~pF"
    set "rel_path=!rel_path:.roo\=!"
    
    REM Create target directory if it doesn't exist
    if not exist "%TARGET_DIR%\.roo\!rel_path!" (
        mkdir "%TARGET_DIR%\.roo\!rel_path!"
    )
    
    REM Copy file if it doesn't exist
    call :copy_if_not_exists "%%F" "%TARGET_DIR%\.roo\!rel_path!%%~nxF"
)

REM Create docs directory if it doesn't exist
if not exist "%TARGET_DIR%\docs\" (
    mkdir "%TARGET_DIR%\docs"
)

REM Create workflow documentation
(
    echo # Roo Workflow Rules
    echo.
    echo This project has been updated to use the auto rule generator from [roo-auto-rules-agile-workflow](https://github.com/bmadcode/roo-auto-rules-agile-workflow)
    echo.
    echo ^> **Note**: This script can be safely re-run at any time to update the template rules to their latest versions^. It will not impact or overwrite any custom rules you've created^.
    echo.
    echo ## Core Features
    echo.
    echo - Automated rule generation
    echo - Standardized documentation formats
    echo - Supports all four Note Types automatically
    echo - AI behavior control and optimization
    echo - Flexible workflow integration options
    echo.
    echo ## Getting Started
    echo.
    echo 1^. Review the templates in `xnotes/`
    echo 2^. Choose your preferred workflow approach
    echo 3^. Start using the AI with confidence!
    echo.
    echo For demos and tutorials, visit: [BMad Code Videos](https://youtube^.com/bmadcode)
) > "%TARGET_DIR%\docs\workflow-rules.md"

REM Update .gitignore with xnotes and docs
if exist "%TARGET_DIR%\.gitignore" (
    findstr /L /C:".roo/rules/_*.mdc" "%TARGET_DIR%\.gitignore" >nul
    if errorlevel 1 (
        (
            echo.
            echo # Private individual user roo rules
            echo .roo/rules/_*.mdc
            echo.
            echo # Documentation and templates
            echo xnotes/
            echo docs/
        ) >> "%TARGET_DIR%\.gitignore"
    )
) else (
    (
        echo # Private individual user roo rules
        echo .roo/rules/_*.mdc
        echo.
        echo # Documentation and templates
        echo xnotes/
        echo docs/
    ) > "%TARGET_DIR%\.gitignore"
)

REM Add sample xnotes
echo Setting up sample xnotes file...
if not exist "%TARGET_DIR%\xnotes\" (
    mkdir "%TARGET_DIR%\xnotes"
)
xcopy "xnotes\*.*" "%TARGET_DIR%\xnotes\" /E /I /Y >nul

REM Update .rooignore
if exist "%TARGET_DIR%\.rooignore" (
    findstr /L /C:"xnotes/" "%TARGET_DIR%\.rooignore" >nul
    if errorlevel 1 (
        (
            echo.
            echo # Project notes and templates
            echo xnotes/
        ) >> "%TARGET_DIR%\.rooignore"
    )
) else (
    (
        echo # Project notes and templates
        echo xnotes/
    ) > "%TARGET_DIR%\.rooignore"
)

REM Create or update .rooindexingignore
if exist "%TARGET_DIR%\.rooindexingignore" (
    findstr /L /C:".roo/templates/" "%TARGET_DIR%\.rooindexingignore" >nul
    if errorlevel 1 (
        (
            echo.
            echo # Templates - accessible but not indexed
            echo .roo/templates/
        ) >> "%TARGET_DIR%\.rooindexingignore"
    )
) else (
    (
        echo # Templates - accessible but not indexed
        echo .roo/templates/
    ) > "%TARGET_DIR%\.rooindexingignore"
)

echo.
echo ✨ Deployment Complete!
echo 📁 Core rule generator: %TARGET_DIR%\.roo\rules\core-rules\rule-generating-agent.mdc
echo 📁 Sample sub-folders and rules: %TARGET_DIR%\.roo\rules\{sub-folders}\
echo 📁 Sample Agile Workflow Templates: %TARGET_DIR%\.roo\templates\
echo 📄 Workflow Documentation: %TARGET_DIR%\docs\workflow-rules.md
echo 🔒 Updated .gitignore, .rooignore, and .rooindexingignore

endlocal
