@echo on

if [%PKG_NAME%] == [omniorb-libs] (
  XCOPY bin\x86_win32\*_rt.dll %LIBRARY_BIN% /s /i /y
  if errorlevel 1 exit 1

  XCOPY lib\x86_win32\*_rt.lib %LIBRARY_LIB% /s /i /y
  if errorlevel 1 exit 1

  del include\GNUmakefile.in
  XCOPY include\* %LIBRARY_INC% /s /i /y
  if errorlevel 1 exit 1
)

if [%PKG_NAME%] == [omniorb] (
  XCOPY bin\x86_win32\*.exe %LIBRARY_BIN% /s /i /y
  if errorlevel 1 exit 1

  XCOPY lib\python\* %SP_DIR% /s /i /y
  if errorlevel 1 exit 1
)
