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

##################
# Initialization #
##################

SERVERSTATUS=""
getServerStatus

if [ "$SERVERSTATUS" == "REACHABLE" ]; then
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Status(Server): PC Offline - $MAC_ADDRESS_FWD" >> "$LOG"
    fi
elif [ "$SERVERSTATUS" == "STALE" ]; then
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Status(Server): PC Offline - $MAC_ADDRESS_FWD" >> "$LOG"
    fi
else
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Status(Server): PC Unknown" >> "$LOG"
    fi
fi
