#!/bin/bash

WORKING_DIR="$(dirname "$(realpath "$0")")"
CONFIG="$WORKING_DIR/config.txt"

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

##################
# Initialization #
##################

# Get status of server
while read -r line; do
    IFS=$" ";column=($line);unset IFS
    if [ "${column[4]}" == "$MAC_ADDRESS_FWD" ]; then
        SERVERSTATUS="${column[5]}"
    fi
done <<< "$(ip n)"

# Return status
if [ "$SERVERSTATUS" == "REACHABLE" ]; then
    changeSetting "SERVER_IS_RUNNING=" "SERVER_IS_RUNNING=true" "$CONFIG"
elif [ "$SERVERSTATUS" == "STALE" ]; then
    changeSetting "SERVER_IS_RUNNING=" "SERVER_IS_RUNNING=false" "$CONFIG"
else
    changeSetting "SERVER_IS_RUNNING=" "SERVER_IS_RUNNING=false" "$CONFIG"
fi
