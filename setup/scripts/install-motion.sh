#!/bin/bash

if which motion > /dev/null
then

    info "motion is installed, skipping motion setup..."

else

    MOTION_SETUP_FILE="motion-installer.deb"
    MOTION_SETUP_URL="https://github.com/Motion-Project/motion/releases/download/release-4.3.1/buster_motion_4.3.1-1_armhf.deb"

    info "Installing gdebi-core"
    sudo apt-get install -y gdebi-core

    info "Downloading latest Motion software"
    wget "$MOTION_SETUP_URL" -O "$MOTION_SETUP_FILE"

    info "Install Moition software"
    sudo gdebi "$MOTION_SETUP_FILE"
    # remove install file
    sudo rm -f "$MOTION_SETUP_FILE"

    info "Copy motion config"
    mkdir ~/.motion
    # create a copy of the config and replace placeholders
    cp $MC_RASP_LITE_DIR/templates/motion/motion.conf ~/.motion/motion.conf
    sudo sed -i -e "s|%%MC_APP_CAPTURES_DIR%%|$MC_APP_CAPTURES_DIR|g" ~/.motion/motion.conf

fi

echo "Motion version:"
motion -v