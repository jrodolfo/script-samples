#!/bin/bash

#------------
cd project-01
echo project-01
git stash
git pull
mvn clean install -D skipTests
cd ..

#------------
cd project-02
echo project-02
git stash
git pull
mvn clean install -D skipTests
cd ..

#------------
cd project-03
echo project-03
git stash
git pull
mvn clean install -D skipTests
cd ..
