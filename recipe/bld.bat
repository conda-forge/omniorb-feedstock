setlocal EnableDelayedExpansion

set "PYTHONPATH=%PREFIX%\Lib"
cygpath %PYTHON% > tmpFile
set /p PYTHONPATHOMNI= < tmpFile
del tmpFile

cd omniorb\src
make export
if errorlevel 1 exit 1
