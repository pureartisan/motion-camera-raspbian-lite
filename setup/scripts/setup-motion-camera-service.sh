#!/bin/bash

SERVICE_NAME='motion-camera'
SERVICE_FILE="$SERVICE_NAME.service"

TEMPLATE_DIR=$MC_RASP_LITE_DIR/templates
SYSTEMD_PATH=/etc/systemd/system
SERVICE_PATH="$SYSTEMD_PATH/$SERVICE_FILE"

MC_SERVER_STARTUP="$MC_APP_DIR/start-server.sh"

info "Copying service file into '$SYSTEMD_PATH'"
sudo cp "$TEMPLATE_DIR/systemd/$SERVICE_FILE" "$SERVICE_PATH"

# replace placeholders
sudo sed -i -e "s|%%ENTRY_POINT%%|$MC_SERVER_STARTUP|g" "$SERVICE_PATH"

# reset permissions
sudo chmod 755 "$SERVICE_PATH"
sudo chown root:root "$SERVICE_PATH"

ACTION='Enabling'
if ! $MC_SETUP; then
    ACTION='Disabling'
fi

info "$ACTION Motion Camera Service..."
sudo systemctl daemon-reload

# now we can check if the user wants to setup
if $MC_SETUP; then
    success "Enabling service"
    sudo systemctl enable "$SERVICE_NAME"
else
    success "Skipping Motion Camera server setup (per user input)"
    sudo systemctl disable "$SERVICE_NAME"
fi