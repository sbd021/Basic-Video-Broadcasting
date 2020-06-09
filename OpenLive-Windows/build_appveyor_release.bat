@echo off

title qmake and nmake build prompt
cd OpenLive-Windows
set SDKFolderVersion=%~1
set Machine=%~2
set ProjName=OpenLive
echo SDKFolderVersion: %SDKFolderVersion%
echo ProjName:%ProjName%

if %Machine% == x86 (
  set QTDIR=C:\Qt5.14.2\msvc2017
) else (
  set QTDIR=C:\Qt5.14.2\msvc2017_64
)
echo QTDIR=%QTDIR%

set VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build

echo VCINSTALLDIR=%VCINSTALLDIR%
dir %VCINSTALLDIR%

call "%VCINSTALLDIR%\vcvarsall.bat" %Machine%
dir %QTDIR%\mkspecs
%QTDIR%\bin\qmake.exe %ProjName%.pro  -spec %QTDIR%\mkspecs\win32-msvc "CONFIG+=release" "CONFIG+=qml_release"
nmake

if not exist release (
  echo "no release"
  exit
)

cd release
del *.h
del *.cpp
del *.obj
%QTDIR%\bin\windeployqt %ProjName%.exe
cd ..

set PackageDIR=%ProjName%_Win_v%SDKFolderVersion%
if not exist %PackageDIR% (
    mkdir %PackageDIR%
)
cd %PackageDIR%
mkdir %Machine%
xcopy /S /I ..\Release\*.* %Machine% /y
xcopy /S /I ..\sdk\dll\*.* %Machine% /y
cd ..
rmdir /S /Q Release
