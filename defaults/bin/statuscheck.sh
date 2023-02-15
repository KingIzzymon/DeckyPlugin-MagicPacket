#!/bin/bash

WORKING_DIR="$(dirname "$(realpath "$0")")"
LOG="/tmp/DeckyPlugin-MagicPacket.log"
ENABLE_LOGGING="true"

changeSetting() {
    # Usage: changeSetting "VARIABLE=" "VARIABLE=VALUE" "$FILEPATH"
    local KEYWORD=$1
    local REPLACE=$2
    local FILE=$3
    local OLD=$(printf '%s\n' "$KEYWORD" | sed -e 's/[]\/$*.^[]/\\&/g')
    local NEW=$(printf '%s\n' "$REPLACE" | sed -e 's/[]\/$*.^[]/\\&/g')
    sed -i "/^${OLD}/c\\${NEW}" "$FILE"
}

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
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Status(Server): PC Offline" >> "$LOG"
    fi
elif [ "$SERVERSTATUS" == "STALE" ]; then
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Status(Server): PC Offline" >> "$LOG"
    fi
else
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Status(Server): PC Unknown" >> "$LOG"
    fi
fi
