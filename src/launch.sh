#!/bin/bash

export SDL_MOUSE_RELATIVE=0
export HOME="$(pwd)"

DIR="$(dirname $0)"
DIR="$(readlink -f "$DIR")"

BIN="${DOSBOX:-$DIR/dosbox}"

# prepare the mounted path

path="/media"

# init the last path

if [ -f "path" ]; then
    path=`cat path`
fi

# request the path

path=$(zenity --file-selection --directory --filename="$path" --window-icon=./dosbox.png --title "Choose your DosBox C directory")

if [ -z "$path" ]; then
    echo Aborting.
    exit 1
fi

# store the path

echo "$path" > path

# copy default data to appdata folder

cp $DIR/dosbox-0.74.pandora.conf .
cp $DIR/mapper-0.74.pandora.map .

echo "Launching DOSBox in $path"

# create a config file

config="$path/dosbox.cfg"
mapping="$path/dosbox.map"

if [ ! -f "$config" ]; then
    zenity --info --text="I will prepare a 'dosbox.cfg' and a 'dosbox.map' file for you. It's located in the selected directory. Modify these files to override the configuration of the DOSBox."  --ok-label="Cool!" 
    cp "$DIR/blank-dosbox.cfg" "$config"
    cp "$DIR/blank-dosbox.map" "$mapping"
fi

"$BIN" "$path" -fullscreen -conf dosbox-0.74.pandora.conf -conf "$config" 
