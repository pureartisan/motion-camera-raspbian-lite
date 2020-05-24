#!/bin/bash

if which motion > /dev/null
then

    info "motion is installed, skipping motion setup..."

else

    MOTION_SETUP_FILE="motion-installer.deb"
    MOTION_SETUP_URL="https://github.com/Motion-Project/motion/releases/download/release-4.3.1/buster_motion_4.3.1-1_armhf.deb"

    echo "Installing gdebi-core"
    sudo apt-get install -y gdebi-core

    echo "Downloading latest Motion software"
    wget "$MOTION_SETUP_URL" -O "$MOTION_SETUP_FILE"

    echo "Install Moition software"
    sudo gdebi "$MOTION_SETUP_FILE"

    echo "Copy motion config"
    mkdir ~/.motion
    # create a copy of the config
    cp $MC_RASP_LITE_DIR/templates/motion/motion.conf ~/.motion/motion.conf

fi

echo "Motion version:"
motion -v