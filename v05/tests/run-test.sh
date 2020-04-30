#!/bin/bash

ascii2petscii "$1".c c64files/"$1".c
rm -f c64files/"$1" "$1".T64
./compile-in-vice.sh "cc "$1".c\ndos s0:notdone\n"
bin2t64 c64files/"$1" "$1".T64
rm -f c64files/"$1".out "$1".out
./test-in-vice.sh "$1"
petscii2ascii c64files/"$1".out "$1".out
diff "$1".golden "$1".out