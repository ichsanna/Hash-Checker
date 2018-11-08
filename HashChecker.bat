@echo off
if [%1]==[] (
	title Hash Checker
	mode 80,20
	goto :start
)
if not exist %1 goto :notfound
set file=%1
if /i %2==md2 set algoname=MD2&goto :calculate
if /i %2==md4 set algoname=MD4&goto :calculate
if /i %2==md5 set algoname=MD5&goto :calculate
if /i %2==sha1 set algoname=SHA1&goto :calculate
if /i %2==sha256 set algoname=SHA256&goto :calculate
if /i %2==sha512 set algoname=SHA512&goto :calculate
:param
cls
:start0
cls
echo.
:start
set /p "file=Enter file location (you can also drag and drop the file here):"
if not exist %file% goto :notfound
cls
goto :choose
:notfound
cls
echo %file%
echo File not found!
goto :start
:choose
echo (MD2/MD4/MD5/SHA1/SHA256/SHA512)
set /p "algo=Enter one hash algorithm from above:"
if /i %algo%==md2 set algoname=MD2&goto :calculate
if /i %algo%==md4 set algoname=MD4&goto :calculate
if /i %algo%==md5 set algoname=MD5&goto :calculate
if /i %algo%==sha1 set algoname=SHA1&goto :calculate
if /i %algo%==sha256 set algoname=SHA256&goto :calculate
if /i %algo%==sha512 set algoname=SHA512&goto :calculate
cls
echo Please enter one of the following algorithm
goto :choose
:calculate
if /i %algoname%==sha512 certutil /hashfile %file% SHA512 >>file.hash
if /i %algoname%==sha256 certutil /hashfile %file% SHA256 >>file.hash
if /i %algoname%==sha1 certutil /hashfile %file% SHA1 >>file.hash
if /i %algoname%==md5 certutil /hashfile %file% MD5 >>file.hash
if /i %algoname%==md4 certutil /hashfile %file% MD4 >>file.hash
if /i %algoname%==md2 certutil /hashfile %file% MD2 >>file.hash
timeout /nobreak 0 >nul
for /f "skip=1 delims= eol=C" %%b in (file.hash) do (
	set hash=%%b
)
cls
if exist file.hash del /q file.hash
echo File : %file%
echo %algoname% Hash : %hash%
REM if /i %algo%==sha512 set sha512=%hash:~0,2%%hash:~3,2%%hash:~6,2%%hash:~9,2%%hash:~12,2%%hash:~15,2%%hash:~18,2%%hash:~21,2%%hash:~24,2%%hash:~27,2%%hash:~30,2%%hash:~33,2%%hash:~36,2%%hash:~39,2%%hash:~42,2%%hash:~45,2%%hash:~48,2%%hash:~51,2%%hash:~54,2%%hash:~57,2%%hash:~60,2%%hash:~63,2%%hash:~66,2%%hash:~69,2%%hash:~72,2%%hash:~75,2%%hash:~78,2%%hash:~81,2%%hash:~84,2%%hash:~87,2%%hash:~90,2%%hash:~93,2%%hash:~96,2%%hash:~99,2%%hash:~102,2%%hash:~105,2%%hash:~108,2%%hash:~111,2%%hash:~114,2%%hash:~117,2%%hash:~120,2%%hash:~123,2%%hash:~126,2%%hash:~129,2%%hash:~132,2%%hash:~135,2%%hash:~138,2%%hash:~141,2%%hash:~144,2%%hash:~147,2%%hash:~150,2%%hash:~153,2%%hash:~156,2%%hash:~159,2%%hash:~162,2%%hash:~165,2%%hash:~168,2%%hash:~171,2%%hash:~174,2%%hash:~177,2%%hash:~180,2%%hash:~183,2%%hash:~186,2%%hash:~189,2%
REM echo %sha512% >>file.hash
if [%1]==[] pause