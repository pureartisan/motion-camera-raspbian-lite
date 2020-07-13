#!/bin/bash

# stop on error
set -e

cd ~/
HOME_DIR=$(pwd)

MC_RASP_LITE="motion-camera-raspbian-lite"
MC_RASP_LITE_GIT="https://github.com/pureartisan/$MC_RASP_LITE.git"
MC_RASP_LITE_DIR="$HOME_DIR/$MC_RASP_LITE"

MC_APP_DIR="$HOME_DIR/motion-camera-app"
MC_APP_CAPTURES_DIR="$MC_APP_DIR/captures"

MC_SETUP=true

REGEX_NUMERIC_ONLY='^[0-9]+$'

# show installer splash
clear

echo -e "\e[33m"
echo '$$\      $$\            $$\     $$\                            '
echo '$$$\    $$$ |           $$ |    \__|                           '
echo '$$$$\  $$$$ | $$$$$$\ $$$$$$\   $$\  $$$$$$\  $$$$$$$\         '
echo '$$\$$\$$ $$ |$$  __$$\\_$$  _|  $$ |$$  __$$\ $$  __$$\        '
echo '$$ \$$$  $$ |$$ /  $$ | $$ |    $$ |$$ /  $$ |$$ |  $$ |       '
echo '$$ |\$  /$$ |$$ |  $$ | $$ |$$\ $$ |$$ |  $$ |$$ |  $$ |       '
echo '$$ | \_/ $$ |\$$$$$$  | \$$$$  |$$ |\$$$$$$  |$$ |  $$ |       '
echo '\__|     \__| \______/   \____/ \__| \______/ \__|  \__|       '
echo -e "\e[1;32m"
echo '                                                               '
echo ' $$$$$$\                                                       '
echo '$$  __$$\                                                      '
echo '$$ /  \__| $$$$$$\  $$$$$$\$$$$\   $$$$$$\   $$$$$$\  $$$$$$\  '
echo '$$ |       \____$$\ $$  _$$  _$$\ $$  __$$\ $$  __$$\ \____$$\ '
echo '$$ |       $$$$$$$ |$$ / $$ / $$ |$$$$$$$$ |$$ |  \__|$$$$$$$ |'
echo '$$ |  $$\ $$  __$$ |$$ | $$ | $$ |$$   ____|$$ |     $$  __$$ |'
echo '\$$$$$$  |\$$$$$$$ |$$ | $$ | $$ |\$$$$$$$\ $$ |     \$$$$$$$ |'
echo ' \______/  \_______|\__| \__| \__| \_______|\__|      \_______|'
echo '                                                               '
echo -e "\e[0m"


function drawLine() {
    printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' =
}

function info() {
    echo -e "\e[1;45m$1\e[0m"
    drawLine
}

function success() {
    echo -e "\e[1;32m$1\e[0m"
}

function error() {
    echo -e "\e[1;91m$1\e[0m"
}

# draw line before asking questions
drawLine

echo "Motion Camera software will be installed on this Raspberry Pi."

echo "Would you like to setup the Motion Camera on this Raspberry Pi? [Y/n]"
while true; do
    read input
    case $input in
        ""|[Yy]* )
            MC_SETUP=true
            break;;
        [Nn]* )
            MC_SETUP=false
            break;;
        * ) echo "Please answer y(es) or n(o).";;
    esac
done

# exit if user didn't give permission to setup
if ! $MC_SETUP; then
    error "Terminating setup..."
    exit 0
fi

drawLine
success "The setup will be automatic, so sit back and relax..."
echo ""
echo ""
drawLine

# Updating package managers
info 'Updating Pi - this may take a while...'
sudo apt-get -y update
info 'Upgrading Pi - this may take a while too...'
sudo apt-get -y upgrade
sudo apt-get -y upgrade --fix-missing

info 'Installing git'
sudo apt install -y git

info 'Cloning "Motion Camera for Raspbian Lite"'
if [ -d "$MC_RASP_LITE_DIR" ]; then
    success "Motion Camera for Raspbian Lite already exists, pulling latest"
    cd "$MC_RASP_LITE_DIR" > /dev/null
    git reset --hard
    git pull origin
    cd > /dev/null
else
    git clone "$MC_RASP_LITE_GIT" "$MC_RASP_LITE"
fi

info 'Creating app directory'
# remove if it already exists
sudo rm -rf "$MC_APP_DIR"
# create app dir
mkdir -p "$MC_APP_DIR"
# list the directory
cd "$MC_APP_DIR" > /dev/null
cd .. > /dev/null
ls -la
cd ~/ > /dev/null

# export so the child scripts can access them
export HOME_DIR
export MC_RASP_LITE_DIR
export MC_APP_DIR
export MC_APP_CAPTURES_DIR
export MC_SETUP

# start the proper setup
. $MC_RASP_LITE_DIR/setup/run.sh
. $MC_RASP_LITE_DIR/setup/cleanup.sh

info 'Rebooting now...'
sudo reboot

# end of the script