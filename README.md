# rpi-motion-camera
Camera with Motion detection setup for Raspberry Pi

## Quick Setup

Simply run the command on your Raspberry Pi (this has been tested on Pi Zero W).

*NOTE*: This script can take a while as it updates Rasbian package manager and pulls in all dependencies.

```
bash -c "$(curl -sL https://raw.githubusercontent.com/pureartisan/motion-camera-raspbian-lite/master/install.sh?$(date +%s))"
```

You will be asked one question, and then everything will happen autoamtically. Sit back and relax, or go have a coffee! :)

### Minimum Requirements

It is expected that you have the following already setup:
* Raspbian Lite installed
* The Raspberry Pi has an active internet connection
* You have something better to do while the script does it's magic!!! :)

## What does this do?

This script sets up the following in your Raspbian Lite setup:
* [Motion](https://motion-project.github.io/) Open source motion capture software via camera
* Auto login to Raspberry Pi
