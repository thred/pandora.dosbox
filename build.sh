#!/bin/bash

MKSQUASHFS="mksquashfs"
BUILD="build"
PNDNAME="pandora.dosbox.thred"

if [ ! -d $BUILD ]; then
    mkdir $BUILD
fi

cp -r src/* $BUILD

if [ ! -f src/dosbox ]; then
    echo "src/dosbox binary is missing!"
    exit -1
fi

rm $PNDNAME.iso
rm $PNDNAME.pnd

$MKSQUASHFS $BUILD $PNDNAME.iso -all-root -force-gid 0 -comp xz -Xbcj arm,armthumb

cat $PNDNAME.iso $BUILD/PXML.xml $BUILD/icon.png > $PNDNAME.pnd
