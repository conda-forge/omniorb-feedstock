setlocal EnableDelayedExpansion

set "PYTHONPATH=%PREFIX%\Lib"
cygpath %PYTHON% > tmpFile
set /p PYTHONPATHOMNI= < tmpFile
del tmpFile

cd src
make export
if errorlevel 1 exit 1

cd ..

XCOPY bin\x86_win32\*.exe %LIBRARY_BIN% /s /i /y
if errorlevel 1 exit 1

XCOPY bin\x86_win32\*_rt.dll %LIBRARY_BIN% /s /i /y
if errorlevel 1 exit 1

XCOPY lib\x86_win32\*_rt.lib %LIBRARY_LIB% /s /i /y
if errorlevel 1 exit 1

XCOPY include\* %LIBRARY_INC% /s /i /y
if errorlevel 1 exit 1

XCOPY lib\python\* %SP_DIR% /s /i /y
if errorlevel 1 exit 1
