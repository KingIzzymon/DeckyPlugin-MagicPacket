#!/bin/bash

WORKING_DIR="$(dirname "$(realpath "$0")")"
CONFIG="$WORKING_DIR/config.txt"
LOG="/tmp/DeckyPlugin-MagicPacket.log"
ENABLE_LOGGING="true"

source "$WORKING_DIR/config.txt"

wakePC() {
    echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $MAC_ADDRESS_FWD | sed 's/://g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | socat - UDP-DATAGRAM:255.255.255.255:9,broadcast
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Log: Sent wake packet" >> "$LOG"
    fi
}

sleepPC() {
    echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $MAC_ADDRESS_REV | sed 's/://g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | socat - UDP-DATAGRAM:255.255.255.255:9,broadcast
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Log: Sent sleep packet" >> "$LOG"
    fi
}

##################
# Initialization #
##################

# If mac address variable empty, run configurator
if [ "$MAC_ADDRESS_FWD" == "" ]; then
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Log: First run of configurator" >> "$LOG"
    fi
    bash "$WORKING_DIR/configurator.sh"
fi

# If is not running, wake. Else if server is running, sleep.
if [ "$SERVER_IS_RUNNING" == "false" ]; then
    wakePC
elif [ "$SERVER_IS_RUNNING" == "true" ]; then
    sleepPC
else
    echo "I don't know if the server is running or not."
fi
