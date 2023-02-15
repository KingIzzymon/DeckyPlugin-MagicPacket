#!/bin/bash

WORKING_DIR="$(dirname "$(realpath "$0")")"
CONFIG="$WORKING_DIR/config.txt"

source $CONFIG

getServerStatus() {
    # Get status of server
    while read -r line; do
        IFS=$" ";column=($line);unset IFS
        if [ "${column[4]}" == "$MAC_ADDRESS_FWD" ]; then
            SERVERSTATUS="${column[5]}"
        fi
    done <<< "$(ip n)"
}

wakePC() {
    echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $MAC_ADDRESS_FWD | sed 's/://g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | socat - UDP-DATAGRAM:255.255.255.255:9,broadcast
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Log: Sent wake packet to $MAC_ADDRESS_FWD" >> "$LOG"
    fi
}

sleepPC() {
    echo -e $(echo $(printf 'f%.0s' {1..12}; printf "$(echo $MAC_ADDRESS_REV | sed 's/://g')%.0s" {1..16}) | sed -e 's/../\\x&/g') | socat - UDP-DATAGRAM:255.255.255.255:9,broadcast
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Log: Sent sleep packet to $MAC_ADDRESS_REV" >> "$LOG"
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

getServerStatus

# If is not running, wake. Else if server is running, sleep.
if [ ! "$SERVERSTATUS" == "REACHABLE" ]; then
    wakePC
elif [ "$SERVERSTATUS" == "REACHABLE" ]; then
    sleepPC
else
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Log: Can't tell if the server is running or not." >> "$LOG"
    fi
fi
