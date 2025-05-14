@echo off
setlocal enabledelayedexpansion
cd %~dp0



:start0
:: check if gmt.exe is present
set cnt=0
for %%A in (contours_*.img) do set /a cnt+=1
set multimode=null
if %cnt% EQU 1 set multimode=single
if not exist %~dp0\resources\gmt.exe goto :error
if not exist %~dp0contours_*.img goto :error3
set str1=%~1
ECHO.%str1% | FiND /i ".img">Nul && ( set multimode=drop ) || ( goto :check for both .img files )

:: Action if Multimode Drop Below
if %multimode% == drop set gmapsuppfiles=%str1%
if %multimode% == drop goto :start


:: if not Multimode Drop then carry on here
:check for both .img files
if exist "%~dp0contours_*part1.img" if exist "%~dp0contours_*part2.img" set multimode=multi
if exist "%~dp0contours_*part1.img" if exist "%~dp0contours_*part2.img" if exist "%~dp0contours_*part3.img" set multimode=triple

:: Action if Multiple Part gmapsupp contourlines Below
if %multimode% == multi for /r %%i in (contours_*part1.img) DO set gmapsuppfile1=%%i
if %multimode% == multi for /r %%i in (contours_*part2.img) DO set gmapsuppfile2=%%i
if %multimode% == multi set gmapsuppfiles="%gmapsuppfile1% & %gmapsuppfile2%"

if %multimode% == triple for /r %%i in (contours_*part1.img) DO set gmapsuppfile1=%%i
if %multimode% == triple for /r %%i in (contours_*part2.img) DO set gmapsuppfile2=%%i
if %multimode% == triple for /r %%i in (contours_*part3.img) DO set gmapsuppfile3=%%i
if %multimode% == triple set gmapsuppfiles="%gmapsuppfile1% & %gmapsuppfile2% & %gmapsuppfile3%"

:Stop if more than a single .img file is found:
set cnt=0
if %multimode% == single goto :standard_check
for %%A in (contours_*part*.img) do set /a cnt+=1
if %cnt% GEQ 4 echo.
if %cnt% GEQ 4 echo "Attention - 4 or more contours_*part*.img files have been found - only two parts are expected!"
if %cnt% GEQ 4 echo "Please leave only *part1.img and *part2.img and *part3.img from one country in this folder"
if %cnt% GEQ 4 echo 
if %cnt% GEQ 4 echo.
if %cnt% GEQ 4 pause
if %cnt% GEQ 4 echo.
if %cnt% GEQ 4 echo.
if %cnt% GEQ 4 goto :start0
if %multimode% == multi goto :start
if %multimode% == triple goto :start
if %multimode% == drop goto :start
set cnt=0
for %%A in (contours_*.img) do set /a cnt+=1
if %cnt% GEQ 2 echo.
if %cnt% GEQ 2 echo Attention - several contours*.img files have been found
if %cnt% GEQ 2 echo the typfile will be changed for all of them
if %cnt% GEQ 2 for /r %%i in (contours_*.img) DO echo %%i
if %cnt% GEQ 2 echo.
goto :start

:: Action if only single *.img file is found below
:standard_check
for /r %%i in (contours_*.img) DO set gmapsuppfiles=%%i 


:start
echo.
echo Attention - this script is only intended to change the layout of OpenMTBMap or VeloMap contourlines gmapsupp.img files. 
echo.
echo.
if %multimode% == multi echo Contourlines gmapsupp in 2 parts has been detected. 
if %multimode% == multi echo This program will change the layout for: 
if %multimode% == multi echo %gmapsuppfile1%
if %multimode% == multi echo %gmapsuppfile2%
if %multimode% == triple echo Contourlines gmapsupp in 3 parts has been detected. 
if %multimode% == triple echo This program will change the layout for: 
if %multimode% == triple echo %gmapsuppfile1%
if %multimode% == triple echo %gmapsuppfile2%
if %multimode% == triple echo %gmapsuppfile3%
if %multimode% == drop echo You started this program by dropping a gmapsupp.img. File. Note layout will be only changed for 
if %multimode% == drop echo.
if %multimode% == drop echo %str1%
if %multimode% == drop echo.
if %multimode% == drop echo Note: dropping multiple files at once is not supported!
if %multimode% == single echo This program will change the layout for:
if %multimode% == single echo %gmapsuppfiles%
echo.
echo.
echo Select the desired TYP file:
 

:: List of .TYP files
echo 1: Thin     - Contourlines are Thin (1pixel)
echo 2: Medium   - Major Contourlines (500m) are a bit wider (2pixel)
echo 3: Thick    - All contourlines are 2 pixel wide
echo 4: Extra Thick - All contourlines are 2 pixel wide
echo 5: Default  - Your GPS device decides how to display the contourlines.
echo X: Exit - no change (Standard is Default - your GPS decides how to display the contourlines)
echo.

set /p input=Enter your choice (1-4, X):
set input=%input:~0,1%

if /i "%input%"=="1" set TYPfile=thin*.TYP
if /i "%input%"=="2" set TYPfile=mid*.TYP
if /i "%input%"=="3" set TYPfile=bold*.TYP
if /i "%input%"=="4" set TYPfile=xbol*.TYP
if /i "%input%"=="5" set TYPfile=def*.TYP
if /i "%input%"=="x" exit
if /i "%input%"=="q" exit
if "%TYPfile%"=="" goto :start

:: check if the chosen .TYP file exists
if not exist %~dps0resources\%TYPfile% goto :error2

set mapfid=-10

if %multimode% NEQ drop goto :singlegmapsupp
:dropgmapsupp
:: find FiD of map in dropped/dragged .iMG file
for /f "tokens=5 delims=, " %%G in ('%~dps0resources\gmt.exe -i "%~1"^|findstr /c:", FID "') do set mapfid=%%G
if %mapfid% LEQ 99 goto :error
echo.
:: echo FiD of this map: %mapfid%
echo.
echo.

:: change FiD of .TYP file (just to make sure if someone uses another .TYP file via renaming or whatever)
%~dps0resources\gmt.exe -w -y %mapfid% %~dps0resources\%TYPfile% >NUL

:: replace the .TYP
%~dps0resources\gmt.exe -w -x %~dps0resources\%TYPfile% "%~1" >NUL

echo.
echo.
echo .TYP file in %gmapsuppfiles% has been replaced by %TYPfile%
goto end

:singlegmapsupp
if %multimode% == multi goto :multigmapsupp
if %multimode% == triple goto :triplegmapsupp
:: find FiD of map in dropped/dragged .iMG file
for /f "tokens=5 delims=, " %%G in ('%~dps0resources\gmt.exe -i "%~dp0contours_*.img"^|findstr /c:", FID "') do set mapfid=%%G
if %mapfid% LEQ 99 goto :error
echo.
:: echo FiD of this map: %mapfid%
echo.
echo.

:: change FiD of .TYP file (just to make sure if someone uses another .TYP file via renaming or whatever)
%~dps0resources\gmt.exe -w -y %mapfid% %~dps0resources\%TYPfile% >NUL

:: replace the .TYP
%~dps0resources\gmt.exe -w -x %~dps0resources\%TYPfile% "%~dp0contours_*.img" >NUL

echo.
echo.
if %multimode% == single echo .TYP file in %gmapsuppfiles% has been replaced by %TYPfile%
if %multimode% == null for /r %%i in (contours_*.img) DO echo .TYP file in %%i have been replaced by %TYPfile%
goto end

:multigmapsupp
:: find FiD of map in dropped/dragged .iMG file
for /f "tokens=5 delims=, " %%G in ('%~dps0resources\gmt.exe -i "%~dp0contours_*.img"^|findstr /c:", FID "') do set mapfid=%%G
if %mapfid% LEQ 99 goto :error
echo.
:: echo FiD of this map: %mapfid%
echo.
echo.

:: change FiD of .TYP file (just to make sure if someone uses another .TYP file via renaming or whatever)
%~dps0resources\gmt.exe -w -y %mapfid% %~dps0resources\%TYPfile% >NUL

:: replace the .TYP
%~dps0resources\gmt.exe -w -x %~dps0resources\%TYPfile% "%~dp0contours_*part1.img" "%~dp0contours_*part2.img" >NUL

echo.
echo.
echo .TYP file in "%gmapsuppfile1% & %gmapsuppfile2%" has been replaced by %TYPfile%
goto end


:triplegmapsupp
:: find FiD of map in dropped/dragged .iMG file
for /f "tokens=5 delims=, " %%G in ('%~dps0resources\gmt.exe -i "%~dp0contours_*.img"^|findstr /c:", FID "') do set mapfid=%%G
if %mapfid% LEQ 99 goto :error
echo.
:: echo FiD of this map: %mapfid%
echo.
echo.

:: change FiD of .TYP file (just to make sure if someone uses another .TYP file via renaming or whatever)
%~dps0resources\gmt.exe -w -y %mapfid% %~dps0resources\%TYPfile% >NUL

:: replace the .TYP
%~dps0resources\gmt.exe -w -x %~dps0resources\%TYPfile% "%~dp0contours_*part1.img" "%~dp0contours_*part2.img"  "%~dp0contours_*part3.img">NUL

echo.
echo.
echo .TYP file in "%gmapsuppfile1% & %gmapsuppfile2% & %gmapsuppfile3%" has been replaced by %TYPfile%
goto end

:error
echo.
echo.
echo.
echo Requirements:
echo.
echo Change_Layout_mtbmap.cmd and the contourlines gmapsupp.img (default name contours_COUNTRY_gmapsupp.img)
echo need to be inside the same folder
echo gmt.exe and the .TYP files need to be in the /resources subfolder
echo.
echo.
echo.
echo Alternative Usage
echo.
echo Drop or Drag the contourlines gmapsupp.img file over the Change_Layout_gmapsupp.cmd file
echo and then select the .TYP file you want to use.
echo.
echo.
echo.
pause
goto :start0

:end
echo.
echo.
echo.
echo Change of .TYP File Successful
if %multimode% NEQ drop echo Just move the .gmapsupp to /garmin folder on the mSD card of your Garmin GPS unit
echo.
echo.
echo.
echo - Press any Key to Exit.
pause >NUL
exit

:error2
echo.
echo.
echo.
echo Cannot Find the chosen .TYP file.
echo You need to have the selected .TYP file in the resources folder.
echo.
echo.
echo.
echo.
echo.
echo General Requirements:
echo.
echo Change_Layout_mtbmap.cmd and the gmapsupp.img needs to be in the same folder
echo gmt.exe and the .TYP files need to be in the /resources subfolder
echo.
echo.
echo.
pause
goto :start0

:error3
set str1="%~1"
if not x%str1:.img=%==x%str1% goto :start
if x%str1:.img=%==x%str1% goto :error
echo on
echo something went wrong here - please contact Felix on openmtbmap.org
pause
exit


