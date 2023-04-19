@echo off

REM 获取脚本路径和目录
set "script_path=%~f0"
set "script_dir=%~dp0"

REM 定义 vimrc 文件路径和目标路径
set "vimrc=%script_dir%\vimrc"
set "vimrc_dest=%USERPROFILE%\_VIMRC"

REM 检查目标文件是否存在
if exist "%vimrc_dest%" (
  REM 备份目标文件
  echo 备份已经存在的配置文件 %vimrc_dest%
  set "bak_dest=%vimrc_dest%.bak"
  set "i=1"
  :loop
  if exist "%bak_dest%" (
    set "bak_dest=%vimrc_dest%.bak.%i%"
    set /a "i+=1"
    goto :loop
  )
  move "%vimrc_dest%" "%bak_dest%"
  echo 已将 %vimrc_dest% 备份到 %bak_dest%
)

REM 复制 vimrc 文件到目标路径
copy "%vimrc%" "%vimrc_dest%"
echo 已经将 %vimrc% 复制到了 %vimrc_dest%

REM 去除前 24 行
set "temp_file=%temp%\temp_vimrc"
more +24 "%vimrc_dest%" > "%temp_file%"
move /y "%temp_file%" "%vimrc_dest%" > nul
echo Removed first 24 lines from %vimrc_dest%

