@echo off

title qmake and nmake build prompt
set SDKFolderVersion=%~1
set Machine=%~2
set ProjName=%~3
set WorkingDirectory=%~4
echo SDKFolderVersion: %SDKFolderVersion%
echo ProjName:%ProjName%
echo WorkingDirectory=%WorkingDirectory%
dir

if %Machine% == x86 (
  set QTDIR=C:\Qt5.10.1\5.10.1\\msvc2017
) else (
  set QTDIR=C:\Qt5.10.1\5.10.1\\msvc2017_64
)

set VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build

call "%VCINSTALLDIR%\vcvarsall.bat" %Machine%
%QTDIR%\bin\qmake.exe %WorkingDirectory%\%ProjName%.pro "CONFIG+=release" "CONFIG+=qml_release"
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
xcopy /S /I %WorkingDirectory%\Release\*.* %Machine% /y
xcopy /S /I ..\sdk\dll\*.* %Machine% /y
cd ..
rmdir /S /Q Release
