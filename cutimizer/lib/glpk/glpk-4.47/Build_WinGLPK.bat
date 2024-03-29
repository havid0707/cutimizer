rem Build winglpk with Visual C++ 2010 Express Edition,
rem Windows SDK for Windows 7, and .NET Framework 4.0
rem on 64bit Windows

set glpkvers=4.47
set glpkjavavers=1.0.18

rem set gnuwin32="C:\Program Files\gnuwin32\bin\"
set gnuwin32="c:\Program Files (x86)\gnuwin32\bin\"
rem set http_proxy=http://proxy-server:8080

xcopy /I /Y . release\glpk-%glpkvers%
xcopy /S /I /Y doc release\glpk-%glpkvers%\doc
xcopy /S /I /Y examples release\glpk-%glpkvers%\examples
xcopy /S /I /Y patch release\glpk-%glpkvers%\patch

%gnuwin32%\wget ftp://ftp.gnu.org/gnu/glpk/glpk-%glpkvers%.tar.gz
%gnuwin32%\wget http://downloads.sourceforge.net/project/glpk-java/glpk-java/glpk-java-%glpkjavavers%/glpk-java-%glpkjavavers%.tar.gz
%gnuwin32%\gzip -d glpk-java-%glpkjavavers%.tar.gz
%gnuwin32%\tar -xf glpk-java-%glpkjavavers%.tar
%gnuwin32%\gzip -d glpk-%glpkvers%.tar.gz
%gnuwin32%\tar -xf glpk-%glpkvers%.tar

%gnuwin32%\find patch -name "*.patch" -exec patch.bat {} ;

echo "Adjust flags for compiler"
%gnuwin32%\sed "s/CFLAGS =/CFLAGS = \/Zi/g" < glpk-%glpkvers%\w32\Makefile_VC_DLL > glpk-%glpkvers%\w32\Makefile_VC_DLL.bak
copy /Y glpk-%glpkvers%\w32\Makefile_VC_DLL.bak glpk-%glpkvers%\w32\Makefile_VC_DLL
del glpk-%glpkvers%\w32\*.bak

%gnuwin32%\sed "s/CFLAGS =/CFLAGS = \/Zi/g" < glpk-%glpkvers%\w64\Makefile_VC_DLL > glpk-%glpkvers%\w64\Makefile_VC_DLL.bak
copy /Y glpk-%glpkvers%\w64\Makefile_VC_DLL.bak glpk-%glpkvers%\w64\Makefile_VC_DLL
del glpk-%glpkvers%\w64\*.bak

xcopy /S /I /Y glpk-java-%glpkjavavers% build32\glpk-%glpkvers%
xcopy /S /I /Y glpk-%glpkvers% build32\glpk-%glpkvers%

xcopy /S /I /Y glpk-java-%glpkjavavers% build64\glpk-%glpkvers%
xcopy /S /I /Y glpk-%glpkvers% build64\glpk-%glpkvers%

xcopy /S /I /Y glpk-java-%glpkjavavers% release\glpk-%glpkvers%
xcopy /S /I /Y glpk-%glpkvers% release\glpk-%glpkvers%

echo "Adjust paths in build files"
%gnuwin32%\sed "s/Program Files/Program Files \(x86\)/g" < build32\glpk-%glpkvers%\w32\Build_GLPK_with_VC10_DLL.bat > build32\glpk-%glpkvers%\w32\Build_GLPK_with_VC10_DLL.bak
copy build32\glpk-%glpkvers%\w32\Build_GLPK_with_VC10_DLL.bak build32\glpk-%glpkvers%\w32\Build_GLPK_with_VC10_DLL.bat

%gnuwin32%\sed "s/HOME=\x22C:\\Program Files/HOME=\x22C:\\Program Files \(x86\)/g" < build32\glpk-%glpkvers%\w32\Build_JNI_with_VC10_DLL.bat > build32\glpk-%glpkvers%\w32\Build_JNI_with_VC10_DLL.bak
copy /Y build32\glpk-%glpkvers%\w32\Build_JNI_with_VC10_DLL.bak build32\glpk-%glpkvers%\w32\Build_JNI_with_VC10_DLL.bat
%gnuwin32%\sed "s/SWIG=\x22C:\\Program Files/SWIG=\x22C:\\Program Files \(x86\)/g" < build32\glpk-%glpkvers%\w32\Build_JNI_with_VC10_DLL.bat > build32\glpk-%glpkvers%\w32\Build_JNI_with_VC10_DLL.bak
copy /Y build32\glpk-%glpkvers%\w32\Build_JNI_with_VC10_DLL.bak build32\glpk-%glpkvers%\w32\Build_JNI_with_VC10_DLL.bat
del build32\glpk-%glpkvers%\w32\*.bak

echo "Copy completed"
pause

rem goto skip32
cd build32\glpk-%glpkvers%\w32
set oldpath = %path%
call Build_GLPK_with_VC10_DLL.bat
path %oldpath%
call Build_JNI_with_VC10_DLL.bat
path %oldpath%
cd ..\..\..
copy build32\glpk-%glpkvers%\w32\*.jar release\glpk-%glpkvers%\w32
copy build32\glpk-%glpkvers%\w32\*.dll release\glpk-%glpkvers%\w32
copy build32\glpk-%glpkvers%\w32\*.exp release\glpk-%glpkvers%\w32
copy build32\glpk-%glpkvers%\w32\*.lib release\glpk-%glpkvers%\w32
copy build32\glpk-%glpkvers%\w32\*.exe release\glpk-%glpkvers%\w32
copy build32\glpk-%glpkvers%\w32\*.pdb release\glpk-%glpkvers%\w32
:skip32

rem goto skip64
cd build64\glpk-%glpkvers%\w64
set oldpath = %path%
call Build_GLPK_with_VC10_DLL.bat
path %oldpath%
call Build_JNI_with_VC10_DLL.bat
path %oldpath%
cd ..\..\..
copy build64\glpk-%glpkvers%\w64\*.jar release\glpk-%glpkvers%\w64
copy build64\glpk-%glpkvers%\w64\*.dll release\glpk-%glpkvers%\w64
copy build64\glpk-%glpkvers%\w64\*.exp release\glpk-%glpkvers%\w64
copy build64\glpk-%glpkvers%\w64\*.lib release\glpk-%glpkvers%\w64
copy build64\glpk-%glpkvers%\w64\*.exe release\glpk-%glpkvers%\w64
copy build64\glpk-%glpkvers%\w64\*.pdb release\glpk-%glpkvers%\w64

:skip64
cd release
%gnuwin32%\zip -r winglpk-%glpkvers%.zip glpk-%glpkvers%
%gnuwin32%\md5sum winglpk-%glpkvers%.zip > winglpk-%glpkvers%.md5
cd ..
