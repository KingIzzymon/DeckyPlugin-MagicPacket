# SteamDeckPlugin-MagicPacket

A wake-on-lan and sleep-on-lan feature for the Steam Deck

---

## Goals

The goal of this project is to create a simple button, accessible via [Decky Loader](https://github.com/SteamDeckHomebrew/decky-loader), that will display "Wake" or "Sleep" depending on the remote computer's status.

It will also have a configurator, thanks to [Scawp](https://github.com/scawp/Steam-Deck.Wake-Up-Rig), that will scan your network for running systems where you can initially select your default connection.

More connections will be supported via the plugin's settings menu where the user can run the configurator again, create other connections and change the default.

## Requirements / Server Setup

A server application, provided by [SR-G](https://github.com/SR-G/sleep-on-lan), is required on the remote computer to listen for the wake signal.

1) Grab the latest release [here](https://github.com/SR-G/sleep-on-lan/releases)
2) Right click and download our modified "[sol.json](https://raw.githubusercontent.com/KingIzzymon/SteamDeckPlugin-MagicPacket/main/sol.json)" file
3) Copy and overwrite the prepackaged json file
4) Run "sol.exe" to start the server

## Dev / Todo

- [ ] Add "hostname" to configurator
- [ ] Create function to reverse set mac address and create alternate config variable
- [ ] Create config file editor function
- [ ] Read/display remote computer status
- [ ] Rework "Wake.sh" to receive the forward mac or reverse mac address from config based on computer status

Note: Always search for dev comments (#dev), todo comments (#todo), and work-in-progress (#wip) can can be cleared before committing

---

Sources:

- https://github.com/scawp/Steam-Deck.Wake-Up-Rig
- https://github.com/SR-G/sleep-on-lan
