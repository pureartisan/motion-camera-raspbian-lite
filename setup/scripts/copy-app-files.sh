#!/bin/bash

info "Copying app files to '$MC_APP_DIR'"
cp $MC_RASP_LITE_DIR/app/* $MC_APP_DIR

# create capture path
mkdir -p $MC_APP_CAPTURES_DIR

# # replace placeholders
FILES=$MC_APP_DIR/*
for f in $FILES
do
    if [ -f "$f" ]; then
        sudo sed -i -e "s|%%MC_DIR%%|$MC_DIR|g" "$f"
        sudo sed -i -e "s|%%MC_APP_CAPTURES_DIR%%|$MC_APP_CAPTURES_DIR|g" "$f"
    fi
done

# make files executable
sudo chmod a+x -R "$MC_APP_DIR"
sudo chmod 777 -R "$MC_APP_CAPTURES_DIR"
