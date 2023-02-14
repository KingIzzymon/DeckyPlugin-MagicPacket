# SteamDeckPlugin-MagicPacket

A [Decky Loader](https://github.com/SteamDeckHomebrew/decky-loader) plugin that will wake/sleep a remote computer (aka desktop gaming rig).

---

## Goals

The goal of this project is to create a simple button, accessible via Decky Loader, that will display "Wake" or "Sleep" depending on the remote computer's status.

It will also have a configurator, thanks to [Scawp](https://github.com/scawp/Steam-Deck.Wake-Up-Rig), that will scan your network for running systems where you can initially select your default connection.

More connections will be supported via the plugin's settings menu where the user can run the configurator again, create other connections and change the default.

## Server Setup

A server application, provided by [SR-G](https://github.com/SR-G/sleep-on-lan), is required on the remote computer to listen for the wake signal.

1) Grab the latest release [here](https://github.com/SR-G/sleep-on-lan/releases)
2) Right click and download our modified "[sol.json](https://raw.githubusercontent.com/KingIzzymon/DeckyPlugin-MagicPacket/main/defaults/sol.json)" file
3) Copy and overwrite the prepackaged json file
4) Run "sol.exe" to start the server

---

## Development

### ToDo

- [ ] Add "hostname" to configurator
- [ ] Create function to reverse set mac address and create alternate config variable
- [ ] Create config file editor function
- [ ] Read/display remote computer status
- [ ] Rework "Wake.sh" to receive the forward mac or reverse mac address from config based on computer status

Note: Always search for dev comments (#dev), todo comments (#todo), and work-in-progress (#wip) can can be cleared before committing

### Dev Resources

- [Plugin-dev Wiki](https://wiki.deckbrew.xyz/en/plugin-dev/getting-started)
- [Template Readme](https://github.com/SteamDeckHomebrew/decky-plugin-template/blob/main/README.md)
- [Database Readme](https://github.com/SteamDeckHomebrew/decky-plugin-database/blob/main/README.md)

---

Sources:

- https://github.com/scawp/Steam-Deck.Wake-Up-Rig
- https://github.com/SR-G/sleep-on-lan
