@echo off
if [%1]==[] (
	title Hash Checker
	mode 80,20
	goto :start
)
if not exist %1 goto :notfound
set file=%1
if [%2]==[] set algoname=ALL&goto :calculate
if /i %2==all set algoname=ALL&goto :calculate
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
echo (MD2/MD4/MD5/SHA1/SHA256/SHA512/ALL)
set /p "algo=Enter one hash algorithm from above:"
if /i %algo%==md2 set algoname=MD2&goto :calculate
if /i %algo%==md4 set algoname=MD4&goto :calculate
if /i %algo%==md5 set algoname=MD5&goto :calculate
if /i %algo%==sha1 set algoname=SHA1&goto :calculate
if /i %algo%==sha256 set algoname=SHA256&goto :calculate
if /i %algo%==sha512 set algoname=SHA512&goto :calculate
if /i %algo%==all set algoname=ALL&goto :calculate
cls
echo Please enter one of the following algorithm
goto :choose
:calculate
set count=1
set maxcount=1
if /i %algoname%==sha512 certutil /hashfile %file% SHA512 >>file1.hash
if /i %algoname%==sha256 certutil /hashfile %file% SHA256 >>file1.hash
if /i %algoname%==sha1 certutil /hashfile %file% SHA1 >>file1.hash
if /i %algoname%==md5 certutil /hashfile %file% MD5 >>file1.hash
if /i %algoname%==md4 certutil /hashfile %file% MD4 >>file1.hash
if /i %algoname%==md2 certutil /hashfile %file% MD2 >>file1.hash
if /i %algoname%==all certutil /hashfile %file% SHA512 >>file1.hash
if /i %algoname%==all certutil /hashfile %file% SHA256 >>file2.hash
if /i %algoname%==all certutil /hashfile %file% SHA1 >>file3.hash
if /i %algoname%==all certutil /hashfile %file% MD5 >>file4.hash
if /i %algoname%==all certutil /hashfile %file% MD4 >>file5.hash
if /i %algoname%==all certutil /hashfile %file% MD2 >>file6.hash
if /i %algoname%==all set maxcount=6
cls
timeout /nobreak 0 >nul
echo File : %file%
:readhash
for /f "skip=1 delims= eol=C" %%b in (file%count%.hash) do (
	set hash=%%b
)
if exist file%count%.hash del /q file%count%.hash
if /i not %algoname%==all echo %algoname% Hash : %hash%
if /i %algoname%==all (
	if %count%==1 echo SHA512 Hash : %hash%
	if %count%==2 echo SHA256 Hash : %hash%
	if %count%==3 echo SHA1 Hash : %hash%
	if %count%==4 echo MD5 Hash : %hash%
	if %count%==5 echo MD4 Hash : %hash%
	if %count%==6 echo MD2 Hash : %hash%
)
set /a count+=1
if %count% leq %maxcount% goto :readhash
:end	
if [%1]==[] pause