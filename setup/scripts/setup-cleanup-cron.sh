#!/bin/bash

# copy dyn dns update script
CLEANUP_SCRIPT="$MC_APP_DIR/cleanup.sh"
sudo chmod 755 $CLEANUP_SCRIPT

echo "Add cron job to check and update ip every minute"
CRONTAB_FILE=/etc/cron.d/motion-camera-cleanup
CRONTAB_USER="pi"
echo "0 * * * * $CRONTAB_USER $CLEANUP_SCRIPT >/dev/null 2>&1" | sudo tee $CRONTAB_FILE