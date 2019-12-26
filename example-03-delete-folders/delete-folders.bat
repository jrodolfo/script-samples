@echo off

rem ####################################################################################################################
rem 
rem  Windows DOS Script to recursively find and delete the folders .metadata, .git, .idea, bin, target, and node_modules
rem 
rem  Assumption:
rem
rem     1) you have a folder C:\dev\workspace with sub-folders, and you want to get rid of the folders mentioned above
rem 
rem     2) this script, delete-folders.bat, is located at C:\dev\workspace
rem 
rem  Based on:
rem
rem     https://stackoverflow.com/questions/26283553/recursively-find-and-delete-a-folder-using-batch-file
rem 
rem 	for /d /r "c:\" %%a in (temp\) do if exist "%%a" echo rmdir /s /q "%%a"
rem 
rem 	For each folder (/d), recursively (/r) under c:\ test for the presence of a temp folder and if it exist, remove
rem     it directory removal command is only echoed to console. If the output is correct, remove the echo command
rem 
rem ####################################################################################################################

for /d /r "C:\dev\workspace" %%a in (.metadata\)    do if exist "%%a" rmdir /s /q "%%a"
for /d /r "C:\dev\workspace" %%a in (.git\)         do if exist "%%a" rmdir /s /q "%%a"
for /d /r "C:\dev\workspace" %%a in (.idea\)        do if exist "%%a" rmdir /s /q "%%a"
for /d /r "C:\dev\workspace" %%a in (bin\)          do if exist "%%a" rmdir /s /q "%%a"
for /d /r "C:\dev\workspace" %%a in (target\)       do if exist "%%a" rmdir /s /q "%%a"
for /d /r "C:\dev\workspace" %%a in (target\)       do if exist "%%a" rmdir /s /q "%%a"
for /d /r "C:\dev\workspace" %%a in (node_modules\) do if exist "%%a" rmdir /s /q "%%a"
