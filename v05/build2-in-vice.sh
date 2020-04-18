#!/bin/bash
set -e

keybuf="$1"

ascii2petscii notdone c64files/notdone

x64 \
  -virtualdev \
  +truedrive \
  -drive8type 1541 \
  -drive9type 1541 \
  -drive10type 1541 \
  -drive11type 1541 \
  -fs8 c64files \
  -9 ./src/cc64src1.d64 \
  -10 ./src/cc64src2.d64 \
  -11 ./src/peddi_src.d64 \
  -autostart uf-build-base.T64 \
  -keybuf "$keybuf" \
  -warp \
  &

while  test -f c64files/notdone
  do sleep 1
done
sleep 1

kill %1

make
