#!/bin/bash

########################################################################################################################
#
#  Script Name:    update-and-compare.sh
#
#  Description:    This is a shell script that you can run on your Windows machine using Cygwin everyday before you
#                  start changing the code.
#                  It will build and update the local dev setup for the various projects to the latest version. Before
#                  running the build and update, the script creates a backup in a folder named:
#                  
#                      /compare/[today's-date]/projects-before-update
#                  
#                  and after the update, it creates another backup folder named:
#
#                      /compare/[today's-date]/projects-after-update
#
#                  Then some folders are deleted from these backups (e.g.: .metadata, target, bin), and it
#                  calls WinMerge to show what was changed between today and yesterday.
#
#  Assumptions:    1) You have WinMerge (https://winmerge.org) installed on your Windows machine at
#                     C:\Program Files\WinMerge\WinMergeU.exe
#
#                  2) You have git bash and maven installed
#
#                  3) This script, update-and-compare.sh, runs inside a folder that contains 3 folders:
#
#                     3.1) "projects", where you keep all your projects (e.g., project-01, project-02, and project-03)
#                          and also the script update-git-maven-projects.sh
#
#                     3.2) "compare", where all files to be compared are kept. There will be one folder for each date.
#
#                     3.3) "logs", where the logs from the script update-git-maven-projects.sh are kept
#
#  Args:           -d [date] (mandatory argument which format is: yyyy-mm-dd, e.g.: 2019-12-26)
#
#  Author:         Rod Oliveira
#
########################################################################################################################

startedAt=$(date +"%Y-%m-%d %T");
echo "script started at $startedAt";

if [ "$1" = "-d" ]
then
    echo Creating folder compare/$2...;
    mkdir compare/$2;
    echo Copying code from folder projects before update...;
    cp -r projects compare/$2/projects-before-update;
    echo Running update and build on folder projects...;
    cd projects || exit;
    ./update-git-maven-projects.sh > ../logs/update-git-maven-projects-output-$2.log
    cd ..
    echo Copying code folder after update...;
    cp -r projects compare/$2/projects-after-update;
    echo Deleting folders that are not necessary for the comparison, e.g., .metadata, .git, .idea, bin, target...
    find compare/$2/ -name ".metadata" -type d -exec rm -rf "{}" \; > /dev/null 2>&1
    find compare/$2/ -name ".git" -type d -exec rm -rf "{}" \; > /dev/null 2>&1
    find compare/$2/ -name ".idea" -type d -exec rm -rf "{}" \; > /dev/null 2>&1
    find compare/$2/ -name "bin" -type d -exec rm -rf "{}" \; > /dev/null 2>&1
    find compare/$2/ -name "target" -type d -exec rm -rf "{}" \; > /dev/null 2>&1
    find compare/$2/ -name "node_modules" -type d -exec rm -rf "{}" \; > /dev/null 2>&1
    echo Calling WinMerge to compare projects-before-update with projects-after-update;
    "C:\Program Files\WinMerge\WinMergeU.exe" "compare\\$2\projects-before-update" "compare\\$2\projects-after-update";
else
    echo "This script is to be called with a date argument, for example: ./update-and-compare.sh -d 2019-08-24";
fi;

finishedAt=$(date +"%Y-%m-%d %T");
echo "script finished at $finishedAt";
