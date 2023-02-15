#!/bin/bash

WORKING_DIR="$(dirname "$(realpath "$0")")"
CONFIG="$WORKING_DIR/config.txt"
LOG="$WORKING_DIR/log.txt"

source "$WORKING_DIR/config.txt"

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

# Check if listening on port 9 and mark as "Server Ready"
isReady="Readiness Unknown" #todo
#isReady="SOL is ready"

if [ "$SERVERSTATUS" == "REACHABLE" ]; then
    changeSetting "SERVER_IS_RUNNING=" "SERVER_IS_RUNNING=true" "$CONFIG"
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo $(date +"%Y-%m-%d-%T") -- "Status(Server): PC Online - $isReady" >> "$LOG"
    fi
elif [ "$SERVERSTATUS" == "STALE" ]; then
    changeSetting "SERVER_IS_RUNNING=" "SERVER_IS_RUNNING=false" "$CONFIG"
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo $(date +"%Y-%m-%d-%T") -- "Status(Server): PC Offline - $isReady" >> "$LOG"
    fi
else
    changeSetting "SERVER_IS_RUNNING=" "SERVER_IS_RUNNING=false" "$CONFIG"
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo $(date +"%Y-%m-%d-%T") -- "Status(Server): PC Unknown" >> "$LOG"
    fi
fi

# Delete oldest log entry after XX entries #todo
