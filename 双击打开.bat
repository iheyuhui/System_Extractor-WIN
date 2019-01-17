@echo off
title Extract and Repack system.new.dat [4.8]
setlocal EnableDelayedExpansion

::   System extractor
::   Copyright (C) 2015-2019  matrixex 


::mode con:cols=82 lines=27
::NORMAL COLS=82 LINES=25

cd /d "%~dp0"
goto admin_

:home
cls
echo.
echo #                   system解包和重新打包工具    
bin\cecho #               {0f}支持5.0-9.0系统{#}
echo.
bin\cecho #                      {0a}(by matrix){#}   
bin\cecho #                      {0a}(heyuhui汉化){#}                                                                  
echo.
bin\cecho                                                        {0b}%activity%{#} {0f}%recent%{#}
echo.
echo.
echo.
bin\cecho        {0f}请选择一个任务 :{#}
echo.
echo      =-=-=-=-=-=-=-=-=-=
echo.
bin\cecho       1 - {0b}解包{#} {0f}system.new.dat.br{#}
echo.
echo.
bin\cecho       2 - {0b}解包{#} {0f}system.new.dat{#}
echo.
echo.
bin\cecho       3 - {0b}打包{#} {0f}system.new.dat{#}
echo.
echo.
bin\cecho       4 - {0b}解包{#} {0f}system.img{#}
echo.
echo.
bin\cecho       5 - {0b}签名{#} {0f}ZIP文件{#}
echo.
echo.
bin\cecho       6 - {0b}退出{#}  
echo.
echo.
set /p web=选择类型:
if "%web%"=="1" goto brotli
if "%web%"=="2" goto extractor
if "%web%"=="3" goto repack
if "%web%"=="4" goto Image_unpack
if "%web%"=="5" goto sign
if "%web%"=="6" goto ex_t
echo.
echo Select a valid option.....
echo ping -n 200 -w 200 127.0.0.1 > nul
goto home






::////////////////////          Extract Script              ///////////////////////
:extractor     ' System.new.dat script
cls
 echo.
    echo   ////////////////////////////////////////////////////
    echo   /                                                  /
    bin\cecho   /  复制 {0a}"system.new.dat"{#} , {0a}"system.transfer.list"{#}  /
    echo.
    echo   /  到当前文件夹或 %cd%
    echo   /                                                  /
    echo   ////////////////////////////////////////////////////
    echo.
    echo  按Enter键继续 &pause>nul
    cls
      if not exist system.new.dat (cls
                                   echo.
                                   echo.
                                   bin\cecho       {0c}"system.new.dat"{#} 找不到
                                   echo.
                                   echo.
                                   echo    请复制 system.new.dat 到当前目录
                                   echo.
                                   set /a web=0
                                   pause>nul
                                   goto home
                                  ) 
      if not exist system.transfer.list (cls
                                         echo.
                                         bin\cecho      {0c}"system.transfer.list"{#}未找到
                                         echo.
                                         echo.
                                         echo     请复制 system.transfer.list 到当前目录
                                         echo.
                                         set /a web=0
                                         pause>nul
                                         goto home
                                        )
      echo.
      if not exist file_contexts (
                                  echo #DUMMY FILE >> file_contexts
                                 )
      echo.
      echo.
      if exist system.new.dat (  
                                bin\cecho   {0a}Found system.new.dat{#}
                                echo.
                                if exist system.transfer.list (                  
                                                               bin\cecho   {0a}Found system.transfer.list{#}
                                                               echo. 
                                                              )
                              )
      echo.
      echo.
      echo  按回车键继续 &pause>nul
      echo.
      echo.
      echo 转换 "system.new.dat" 为 "system.img.ext4"
  echo.
  python --version 2>NUL
goto ans%ERRORLEVEL% 

:brotli
  cls
  echo.
    echo   ////////////////////////////////////////////////////
    echo   /                                                  /
    bin\cecho   / 复制 {0a}"system.new.dat.br"{#}, {0a}"system.transfer.list"{#} /
    echo.
    echo   /  到当前文件夹或 %cd% 
    echo   /                                                  /
    echo   ////////////////////////////////////////////////////
    echo.
    echo   按Enter继续 &pause>nul
    cls
      if not exist system.new.dat.br (cls
                                   echo.
                                   echo.
                                   bin\cecho       {0c}"system.new.dat.br"{#} 未找到
                                   echo.
                                   echo.
                                   echo   请复制 system.new.dat.br 到当前文件夹
                                   echo.
                                   set /a web=0
                                   pause>nul
                                   goto home
                                  ) 
      if not exist system.transfer.list (cls
                                         echo.
                                         bin\cecho      {0c}"system.transfer.list"{#} is not found
                                         echo.
                                         echo.
                                         echo     请复制 system.transfer.list 到当前文件夹
                                         echo.
                                         set /a web=0
                                         pause>nul
                                         goto home
                                        )
      echo.
      if not exist file_contexts (
                                  echo #DUMMY FILE >> file_contexts
                                 )
      echo.
      echo.
      if exist system.new.dat.br (  
                                bin\cecho   {0a}Found system.new.dat.br{#}
                                echo.
                                if exist system.transfer.list (                  
                                                               bin\cecho   {0a}Found system.transfer.list{#}
                                                               echo. 
                                                              )
                              )
      echo.
      echo.
      echo  按回车键继续 &pause>nul
      echo.
      echo.
      echo 转换 "system.new.dat.br" 为 "system.new.dat"
  echo.
  brotli.exe --decompress --in system.new.dat.br --out system.new.dat
  echo Converted
  python --version 2>NUL
  goto ans%ERRORLEVEL%

:ans0
  echo.
  echo.
  echo      Python已安装
  echo.
  bin\cecho   {e0} Unpacking System.new.dat {#}
  echo.
  echo.
  python bin\python\sdat2img.py system.transfer.list system.new.dat system.img.ext4
  IF EXIST system.img.ext4 goto conv_rt

:ans9009
  echo.
  echo.
  echo.     Python not found!
  echo.     Switching sdat2img.py to sdat2img.exe    
  echo.
  bin\sdat2img.exe system.transfer.list system.new.dat file_contexts
  IF EXIST system.img.ext4 goto conv_rt
  
:conv_rt
echo 转换 "system.img.ext4" 为 "system"
               if not exist system.img.ext4 goto datstop 
               pause
               REN system.img.ext4 system.img
               bin\Imgextractor.exe system.img
               echo 如果提取失败，请安装python并重试:)
               del system.img
               del system.new.dat
               IF EXIST system.new.dat.br del system.new.dat.br
               del system.transfer.list 
               del file_contexts
               echo.
               echo.
               echo.
               ( dir /b /a "system_" | findstr . ) > nul && ( 
                                                             bin\cecho   {e0} Files are找到 in system_ folder {#} 
                                                            ) || (
                                                             echo Error
                                                             pause
                                                             goto home
                                                            )
                 echo.
                 echo.
                 set /a web=0
pause
goto home
::/*                 END , LAST UPDATED ON THU, NOVEMBER , 11                        */


::                 CYANOGENMOD REPACK SCRIPT 
:repack
cls
  echo.
  echo.
  echo   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  echo   ::                                                                  ::
  bin\cecho   :: {0c}Warning{#} 这仅适用于高级用户，它可能工作，也可能不工作    ::
  echo.
  echo   ::                                                                  ::
  echo   :: 如果你是新手，我强烈建议你flash       :: 
  echo   ::                                                                  ::
  echo   :: system 文件夹通过updater-script刷入代替 system.new.dat   ::
  echo   ::                                                                  ::
  echo   ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  echo.
  echo.
  echo.
  bin\cecho     1 - {0b}手动重新打包{#} ( {0f}最好用这个{#} )
  echo.
  echo.
  bin\cecho     2 - {0b}自动重新打包{#} ( {0f}需要更多时间{#} )
  echo.
  echo.
  bin\cecho     3 - {0b}返回{#}
  echo.
  echo.
  set /p "web=选择类型: " 
  if "%web%"=="2" goto cm_pack
  if "%web%"=="1" goto cm_pack_man
  if "%web%"=="3" goto home
goto repack

:cm_pack_man
cls
cls
  echo.
  echo.
   if not exist system md system
   echo.
   echo.  
   echo    1 :- 复制所有子文件夹/文件 (可能有 /app,/bin,/lib build.prop etc.) 
   echo.  
   echo         to "system" folder
   echo.
   echo    2 :- 复制 file_contexts 到当前文件夹                                                
   echo.  
   echo.
   pause
   if not exist system\app goto stop_cyanogenmod
   if not exist file_contexts goto file_c
   CLS
   echo.
   echo.
   echo.
SET /P "SIZE=TYPE THE SIZE IN MB : " 
   ECHO.
   ECHO.
   PAUSE
   cls
   ECHO.
   ECHO.
   ECHO       CONVERTING SYSTEM TO SYSTEM.IMG
   ECHO.
   set /a size+=100
   if exist system bin\make_ext4fs -T 0 -S file_contexts -l %SIZE%M -a system system.img system
   ECHO.
   CLS
   ECHO.
   ECHO.
   ECHO.
   ECHO   CONVERTING SYSTEM.IMG TO SYSTEM.NEW.DAT AND TRANSFER.LIST
   ECHO.
   ECHO.
   IF EXIST system.img bin\rimg2sdat system.img
   del system.img
   if not exist system.new.dat goto stop8
   if not exist system.transfer.list goto stop8
   cls
   bin\fciv -sha1 system.new.dat
   ECHO.
   ECHO JUST IN CASE YOU MIGHT NEED IT IN FUTURE
   bin\fciv -sha1 system.new.dat >> SHA1_VALUE.TXT
   pause
   cls
   echo.
   ECHO                          IMPORTANT READ IT ALL
   echo.
   echo   例如刷入 xyz_ROM.zip对于DAT文件，您需要修改updater-script
   echo.
   echo   Script, "of some roms" , because some roms contains a link b/w updateR-script 
   echo.
   echo   and system.transfer.list. 
   echo.
   echo.  链接包括以下内容：有一行
   echo.
   echo   updateR-script script called 'if range_sha1()' if you found this in 
   echo.
   echo   updateR-script then from here follow the guide Repack_INFO.txt OTHERWISE 
   echo.
   echo   copy UNMODIFIED system.transfer.list and system.new.dat to your desired folder
   echo.
   echo   Then do the flashing work.
   echo.
   echo.
   pause   
 goto home
 
:cm_pack

cls
  echo.
  echo.
   if not exist system md system
   echo.
   echo  ///////////////////////////////////////////////////////////////////////////
   echo  /                                                                        /
   echo  /                                                                        /
   echo  /  复制所有子文件夹/文件 (可能有 /app,/bin,/lib build.prop etc.) / 
   echo  /                                                                        /
   bin\cecho  /  到 {0a}"system"{#} 文件夹并按Enter键                            / 
   echo.                                                                          /
   echo  //////////////////////////////////////////////////////////////////////////
   echo.
   echo.
   echo. 
   pause
   cls
   if not exist system\app goto stop_cyanogenmod
   if not exist file_contexts goto file_c
   echo.
   echo.
   echo.
if exist system\app echo       找到 System FOLDER
   echo.
if exist file_contexts echo       找到 file_contexts
   echo.
   echo Looping Starts
::524288000(bytes)=500MB
   set /A cm_sixe=524288000
   goto cm_calculate

:file_c
cls
  echo.
  echo.
  echo.
  echo.
  echo.
  bin\cecho   {0c}"file_contexts"找不到，请把它复制得太新 当前目录{#}
  echo.
  echo.
  bin\cecho   {0c}目录{#},感谢您的合作 ;)
  echo.
  echo.
  echo.
  pause
  goto home


:cm_calculate
echo.
  set /A cm_sixe+=1048576
  bin\make_ext4fs -T 0 -S file_contexts -l %cm_sixe% -a system system.img system >> bin\log_size.txt
cls
  echo.
  echo    Calculating Size Please Wait....
  echo    size %cm_sixe% (increament By 1048576(bytes)=1Mb(Megabytes))
  echo. 
  bin\cecho    {0f}If this goes on forever than QUIT this and{#}
  echo.
  echo.  
  bin\cecho    {0f}PLEASE only copy file_contexts of your ROM{#}
  echo.
  echo.
  if not exist system.img goto cm_calculate
  if exist system.img goto cm_next


:cm_next
echo.
  echo  Size required in system Partition is %cm_sixe% bytes
  echo.
  echo It will take some time aproxx 1-2 minutes
  echo.
  bin\rimg2sdat system.img 
  del system.img
  if not exist system.new.dat goto stop8
  if not exist system.transfer.list goto stop8
  echo.
  cls
  echo.
  echo.
  bin\cecho    {0a}Sha1_check{#} valus of system.new.dat
  echo.
  echo.
  bin\fciv -sha1 system.new.dat
  echo.
  echo.
  bin\cecho  Also saved in current folder by name {0a}"sha1_system.txt"{#}
  echo.
  bin\fciv -sha1 system.new.dat >> sha1_system.txt
  echo.
  echo.
  bin\cecho DONE {0a}"system.transfer.list"{#} and {0a}"system.new.dat"{#} created in current folder
  echo. 
  echo.
  bin\cecho just copy it(both) to your ROM also keep {0a}"sha1_system.txt"{#} and follow my guide
  echo.
  echo.
  del file_contexts
  pause
goto home


:stop_cyanogenmod
cls
echo.
echo.
echo //////////////////////////////////////////////////////////////////
echo.
echo  你必须复制你的文件夹有app,bin/lib 
echo.
echo   build.prop 到系统文件夹，希望你能找到它
echo.
echo. 以及复制 file_contexts 到当前目录
echo. 
echo \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo.
pause
goto home
::        ----------------------End of script--------------------------   ::
 
::                               IMAGE UNPACK SCRIPT                        ::
:Image_unpack
cls
echo.
echo.
echo.
echo.                                                         
echo   将system.img复制到当前文件夹并确保  
echo   名称为 system.img                                   
echo.                                                       
echo    * 当前文件夹=您放置extractor.bat的文件夹
echo.
echo.
pause
echo.
if exist system.img echo    找到 system.img
if not exist system.img (cls &echo. &echo system.img 找不到 , 请检查文件名称并重试 &pause > NUL &goto :home)
echo.
echo  wait aprox 1-2 minutes
::FOR 
echo.
bin\Imgextractor.exe system.img
if "%errorlevel%"=="0" (if exist system rd /s /q system &MOVE system_ system &del system.img 
echo.
echo Files = "system" folder
echo.
echo  如果提取失败，则img可能是稀少的格式
echo  请通过在bin中找到的simg2img二进制文件将其转换为ext4格式重试。
echo.
pause
goto home)
::        ----------------------End of script--------------------------   ::

::                            Sign Zip Files Script                       ::                  
:sign
cls
   echo. 
   echo.
   if not exist sign_files md sign_files
   bin\cecho   {0f}////////////  签名zip  \\\\\\\\\\\\{#}
   echo.
   echo.
   echo.
   echo.
   echo //////////////////////////////////////////////////////////////
   echo /                                                            /
   echo / 把你的zip文件放在sign_files中                              /
   echo /                                                            /
   echo / 确保您的文件不包含任何空格                                 /
   echo /                                                            /
   echo // JAVA SE DEVELOPMENT KIT 8 OR HIGHER MUST BE INSTALLED OR IT WILL NOT WORK //
   echo /                                                            /
   echo //////////////////////////////////////////////////////////////
   echo.
   echo. 
   set /p "WEB=  继续 (y/n): "
  if "%WEB%"=="Y" goto _HSX
  if "%WEB%"=="y" goto _HSX
  if "%WEB%"=="n" goto home
  if "%WEB%"=="N" goto home
goto _HSX

:_HSX
cls
echo.
echo.
if exist sign_files\*.zip echo           找到 ZIP file
if not exist sign_files\*.zip goto no_ZIP
if exist sign_files cd sign_files
setlocal EnableDelayedExpansion
FOR %%F IN (*.zip) DO (
 set filename=%%F
 cd ..
 goto tests
)
:tests
echo.
echo.
echo    Name file is : %filename%
echo.
echo.
echo.
set /p "oop= Type option (y/n): " 
if "%oop%"=="y" goto nextsign
if "%oop%"=="Y" goto nextsign
if "%oop%"=="N" goto newname
if "%oop%"=="n" goto newname
goto nextsign

:nextsign
cls
  echo.
  echo.
  echo     Signing %filename%.......

  copy bin\signapk.jar sign_files > NUL
  copy bin\testkey.x509.pem sign_files > NUL
  copy bin\testkey.pk8 sign_files > NUL

  cd sign_files

java -jar signapk.jar testkey.x509.pem testkey.pk8 %filename% signed_%filename%.zip 
  del signapk.jar
  del testkey.x509.pem
  del testkey.pk8
pause
cd ..
if not exist sign_files\*.zip goto stop01
if exist sign_files\signed_%filename%.zip move sign_files Signed > nul
cls
echo.
echo.
if exist Signed\signed_%filename%.zip (echo            DONE
                                       echo.
                                       echo    Current Name is signed_%filename%
                                       echo.
                                       echo    and found under Signed Folder
                                       echo.
                                       echo.
                                       )
pause
goto home

:newname
cls
echo.
echo.
echo.
set /p filename=Type name without spaces (also include .zip) : 
goto nextsign

:no_ZIP
cls
echo.
echo.
bin\cecho       {0c}未找到zip文件{#}
echo.
echo.
pause
goto home
::  -------------------   END OF SIGN SCRIPT   -------------------- ::

::
::ADMIN rights used here is to make script flawless not to gain your INFORMATION or delete your documents
:admin_
>>nul 2>>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM -->> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting admin privileges
    goto PERM
) else ( goto start )
:PERM
    echo Set UAC = CreateObject^("Shell.Application"^) >> "%temp%\admin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\admin.vbs"

    "%temp%\admin.vbs"
    del "%temp%\admin.vbs"
    exit /B

:start 
SET count=1 
 FOR %%G IN (.,..) DO (
 ping -n 2 -w 200 127.0.0.1 > nul
 echo %count%
 cls
 echo.
 echo.
 echo.
 bin\cecho     {0f}欢迎来到{#} {0a}matrix's{#} {0f}System解包和重新打包工具{#}
 echo.
 echo.
 bin\cecho     {0f}加载{#} {0a}%%G{#}
 echo.
 set /a count+=1 )
 goto check
 
:check
::Section for checking recent activity'
if not exist %temp% goto home
if exist %temp%\date_log.txt goto _recent
set activity="  First use "
echo %date% >> %temp%\date_log.txt
set recent=
goto home

:_recent
if exist %temp%\date_log.txt (
set /p recent=<%temp%\date_log.txt
)
del %temp%\date_log.txt
set "activity=OLD A/C:" 
echo %date% >> %temp%\date_log.txt
goto home


::NOTE: - there are too many functions of different steps and I think this is unnecessary
:: I did this because of some users but day by day users are getting samrter ;) 
:: So maybe in future I'll remove it or might come up with some Idea to sorten it. 
::
::System FOLDER stop
::
:stop1
cls
echo.
echo.
echo.
echo     ///////////////////////////////////////////////////////
echo.
echo      It seems that the you have not copied sub folder 
bin\cecho      like /app,/bin,/lib build.prop etc. to {0c}"system"{#}
echo. 
echo      folder present in current directry please follow 
echo      Instructions carefully and also read help section
echo.
echo     \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo.
pause
cls
echo.
echo.
bin\cecho  {0a}Cleaning old files....{#}
ping -n 2 -w 200 127.0.0.1 > nul
RD /S /Q system
goto home

:stop2
cls
echo.
echo     ////////////////////////////////////////////////////////////
echo.
bin\cecho       {0f}"system.img"{#} is not found in current folder Please copy
echo. 
bin\cecho       {0f}system.img{#} to current folder or rename your system image 
echo.
bin\cecho       file to {0f}system.img{#}
echo.
echo.
echo     \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo.
pause
goto home

:stop3
cls
echo.
echo      ////////////////////////////////////////////////////////////////
echo.
echo        Something is missing from current folder please copy
bin\cecho        {0c}"system.new.dat"{#} , {0c}"system.transfer.list"{#} and {0c}"file_contexts"{#}
echo.
echo        to CURRENT FOLDER  see help
echo.
echo      \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
echo.
pause
goto home

:stop5
cls
echo.
bin\cecho    {0a}"system.new.dat"{#}未找到
echo.
echo    请复制system.new.dat 到当前目录
echo.
pause
goto home

:stop6
cls
echo.
bin\cecho    {0a}"system.transfer.list"{#} 未找到
echo.
echo     请复制 system.transfer.list 到当前目录
echo.
pause
goto home

:stop7
cls
echo.
bin\cecho    {0a}"file_contexts"{#} 未找到
echo.
echo     请复制 file_contexts 到当前目录
echo.
echo     Trouble in getting file_contexts
echo.
echo     Extract boot.img/Ramdisk/file_contexts
echo.
pause
goto home

:stop8
cls
echo.
echo  It seems like the extractor not worked with your 
echo  provided system folder COMMENT ON XDA THOUGH
ECHO  IT MAY BE DUE TO CORRUPTED SYSTEM.DAT OR UNKNOWN REASON
echo.
pause
goto home

:sizr
cls
echo.
echo.
echo ///////////////////////////////////////////////////////////
echo /                                                         /
echo /   Please enter size correctly or add more size that is  /
echo /   more MB in current size                               /
echo /                                                         /
echo ///////////////////////////////////////////////////////////
echo.
echo.
pause
goto cmatrix

:opensystem
cls
::Under Construction
if not exist system goto stop10
%SystemRoot%\explorer.exe "system"
echo.
echo        Opened
echo.
pause
goto home

:stop10
echo.
echo.
echo  There is no system folder found!
echo  this implies that this extractor 
echo  not worked with your .DAT files
echo.
pause
goto home

:datstop
echo.
echo.
bin\cecho {0c}////////////////////////////////////////////////// {\n}/                                                / {\n}/   There is no system.img.ext4  found!          / {\n}/   this implies that this extractor             / {\n}/   not worked with your .DAT files              / {\n}/   Please contact me , matrix                   / {\n}/   and if possible please proide a              / {\n}/   file that contains following info.           / {\n}/   1. dat file size                             / {\n}/   2. screenshot(use wordpad, can store images) / {\n}/   3. mark and copy info on cmd extractor.      / {\n}/                                                / {\n}//////////////////////////////////////////////////{#}
echo.
echo.
echo  Thanks 
echo  Regards -matrix
echo.
pause
goto home

::
::ZIP FILE STOP
::
:stop01
cls
echo.
echo.
echo  ////////////////////////////////////////////
echo  /                                          /
echo  /    Not worked with your zip file please  /
echo  /    use a simple name like                /
echo  /    Eg. something_maker.zip               /
echo   Possible reason :  JAVA SE DEVELOPMENT KIT 7 OR HIGHER NOT INSTALLED
echo  /                                          /
echo  ////////////////////////////////////////////
echo.
echo.
pause
goto home

:ex_t
cls
echo.
echo.
echo.
echo.
echo.
echo.
:: This below line is to delete log that is found in bin of extractor
bin\cecho              {80}THANKS{#} {20}FOR{#} {40}USING{#}
IF EXIST system__statfile.txt del system__statfile.txt
IF EXIST bin\log_size.txt DEL bin\log_size.txt
exit
