#!/bin/bash

WORKING_DIR="$(dirname "$(realpath "$0")")"
CONFIG="$WORKING_DIR/config.txt"
LOG="$WORKING_DIR/log.txt"
echo $(date +"%Y-%m-%d-%T") -- "Log(Script): Called 'sendpacket'" >> "$LOG" #dev

source "$WORKING_DIR/config.txt"

wakePC() {
    echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $MAC_ADDRESS_FWD | sed 's/://g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | socat - UDP-DATAGRAM:255.255.255.255:9,broadcast
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo $(date +"%Y-%m-%d-%T") -- "Log: Sent wake packet" >> "$LOG"
    fi
}

sleepPC() {
    echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $MAC_ADDRESS_REV | sed 's/://g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | socat - UDP-DATAGRAM:255.255.255.255:9,broadcast
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo $(date +"%Y-%m-%d-%T") -- "Log: Sent sleep packet" >> "$LOG"
    fi
}

##################
# Initialization #
##################

# If mac address variable empty, run configurator
if [ "$MAC_ADDRESS_FWD" == "" ]; then
    bash "$WORKING_DIR/configurator.sh"
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo $(date +"%Y-%m-%d-%T") -- "Log: Running first time setup" >> "$LOG"
    fi
fi

# If is not running, wake. Else if server is running, sleep.
if [ "$SERVER_IS_RUNNING" == "false" ]; then
    wakePC
elif [ "$SERVER_IS_RUNNING" == "true" ]; then
    sleepPC
else
    echo "I don't know if the server is running or not."
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo $(date +"%Y-%m-%d-%T") -- "Debug: Unable to send packet. Server status unknown." >> "$LOG"
    fi
fi
