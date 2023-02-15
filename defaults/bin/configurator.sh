#!/bin/bash

WORKING_DIR="$(dirname "$(realpath "$0")")"
CONFIG="$WORKING_DIR/config.txt"
ARP_TEMP="/tmp/arp.txt"
LOG="/tmp/DeckyPlugin-MagicPacket.log"
ENABLE_LOGGING="true"

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

reverseMAC() {
    # Reverses the sequence of the mac address
    IFS=':' read -r -a arrayMACPieces <<< "$MAC_ADDRESS"
    MAC_ADDRESS_REV="${arrayMACPieces[5]}:${arrayMACPieces[4]}:${arrayMACPieces[3]}:${arrayMACPieces[2]}:${arrayMACPieces[1]}:${arrayMACPieces[0]}"
}

configurator() {
    # Create 'arp.txt' and insert a table of IP addresses and their mac addresses for zenity
    true > "$ARP_TEMP"
    while read -r line; do
        IFS=$" ";column=($line);unset IFS
        echo "${column[0]}"$'\t'"${column[4]}" >> "$ARP_TEMP"
    done <<< "$(ip n)"

    # User selects a computer
    MAC_ADDRESS=$(zenity --list --title="Configure a Device to Wake-On-Lan" \
        --width=600 --height=200 --print-column=2 \
        --separator='\t' --extra-button "Manual" --ok-label "Confirm" \
        --column="Name/IP" --column="MAC Adress"\
        $(cat "$ARP_TEMP"))
    if [ "$?" = 1 ] ; then
        # If "Manual" was selected, then user inputs the mac address
        if [ "$MAC_ADDRESS" = "Manual" ]; then
            MAC_ADDRESS=$(zenity --forms --title="Manual Config" \
                --text="Enter MAC Adress" --add-entry="MAC Address")
            if [ "$?" = 1 ] ; then
                echo "Aborted"
                exit 1;
            fi
        else
            echo "Aborted"
            exit 1;
        fi
    fi

    # Write mac addresses to config
    changeSetting "MAC_ADDRESS_FWD=" "MAC_ADDRESS_FWD=$MAC_ADDRESS" "$CONFIG"
    reverseMAC
    changeSetting "MAC_ADDRESS_REV=" "MAC_ADDRESS_REV=$MAC_ADDRESS_REV" "$CONFIG"
    rm "$ARP_TEMP"
    if [ "$ENABLE_LOGGING" == "true" ]; then
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Log: Configurator set MAC_ADDRESS_FWD: $MAC_ADDRESS" >> "$LOG"
        echo "[MagicPacket-bash]" $(date +"%Y-%m-%d-%T") -- "Log: Configurator set MAC_ADDRESS_REV: $MAC_ADDRESS_REV" >> "$LOG"
    fi
}

##################
# Initialization #
##################

configurator
