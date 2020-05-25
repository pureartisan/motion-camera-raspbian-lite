#!/bin/bash

# remove files older than 7 days
find %%MC_APP_CAPTURES_DIR%% -mtime +7 -exec rm -rv * {} +
