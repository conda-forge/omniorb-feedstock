setlocal EnableDelayedExpansion

set "PYTHONPATH=%PREFIX%\Lib"
cygpath %PYTHON% > tmpFile
set /p PYTHONPATHOMNI= < tmpFile
del tmpFile

cd src\lib\omniORBpy
make export
if errorlevel 1 exit 1

cd ..\..\..

@echo on

XCOPY include\* %LIBRARY_INC% /s /i /y
if errorlevel 1 exit 1

XCOPY lib\python\* %SP_DIR% /s /i /y
if errorlevel 1 exit 1
