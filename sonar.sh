#!/bin/bash

cd xar || exit 1
mkdir sonar

# find all c sources
csources=$(find . -regex ".*\.c\|.*\.h")

# cppcheck
cppcheck -v --enable=all --xml -Iinclude $csources 2>sonar/cppcheck-report.xml

# vera++
#vera++ - -showrules -nodup |& vera++Report2checkstyleReport.perl >sonar/vera-report.xml

# rats
rats -w 3 --xml $csources >sonar/rats-report.xml

# autoconf and configure
./autogen.sh

# gcc scan
CFLAGS="-fdiagnostics-show-option -Wall -Wextra" make 2>sonar/gcc-build.log
make clean

# clang scan-build
CC="clang" CFLAGS="-fdiagnostics-show-option -Wall -Wextra" \
    scan-build -plist -o sonar/scan-build make

cd src || exit 1

# valgrind
#valgrind --xml=yes --xml-file=sonar/valgrind-report.xml ./xar [arguments]

cd ../../tools || exit 1

mkdir sonar
scan-build -plist -o sonar/scan-build make

cd .. || exit 1

sonar-scanner

# cleanup steps
cd xar || exit 1

make relclean
rm -r sonar

cd ../tools || exit 1

make clean
rm -r sonar

cd .. || exit 1
