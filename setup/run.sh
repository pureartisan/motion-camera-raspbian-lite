#!/bin/bash

SETUP_SCRIPTS_DIR=$MC_RASP_LITE_DIR/setup/scripts

# install required packages
. $SETUP_SCRIPTS_DIR/install-motion.sh

# setup options
. $SETUP_SCRIPTS_DIR/copy-app-files.sh
. $SETUP_SCRIPTS_DIR/setup-boot-options.sh
. $SETUP_SCRIPTS_DIR/setup-motion-camera-service.sh
