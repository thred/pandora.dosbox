#!/bin/bash

MKSQUASHFS="mksquashfs"
BUILD="build"
PNDNAME="pandora.dosbox.thred"

mkdir $BUILD
cp -r src/* $BUILD
cp dosbox/dosbox $BUILD

$MKSQUASHFS $BUILD $PNDNAME.iso -all-root -force-gid 0 -comp xz -Xbcj arm,armthumb

cat $PNDNAME.iso $BUILD/PXML.xml $BUILD/icon.png > $PNDNAME.pnd
