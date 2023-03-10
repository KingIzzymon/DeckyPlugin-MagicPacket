# Decky Plugin: MagicPacket

MagicPacket is a [Decky Loader](https://github.com/SteamDeckHomebrew/decky-loader) plugin that will wake/sleep a remote computer (aka desktop gaming rig). This is intended for use with Steam's Remote Play and with applications like [Parsec](https://parsec.app/) for in home game streaming.

---

## Goals

The goal of this project is to create a simple button, accessible via Decky Loader, that will display "Wake" or "Sleep" depending on the remote computer's status.

It will also have a configurator, thanks to [Scawp](https://github.com/scawp/Steam-Deck.Wake-Up-Rig), that will scan your network for running systems where you can initially select and setup the first connection.

More connections will be supported via the plugin's settings menu where the user can run the configurator again, create other connections and select which connections to show in the Decky plugin menu.

---

## Installation

1) [Install Decky Loader](https://github.com/SteamDeckHomebrew/decky-loader#installation)
2) In Decky Settings, set the "Store Channel" to "Testing" <- **Not yet implemented**
3) Search the Decky Store for the "MagicPacket" plugin and click "Install"

## Server Setup

A server application, provided by [SR-G](https://github.com/SR-G/sleep-on-lan), is required on the remote computer to listen for the wake signal.

1) Copy and unzip the SleepOnLan server from your steam deck to your server PC.

```sh
$HOME/homebrew/plugins/MagicPacket/server
```

2) Open the subfolder based on your server operating system and run "sol.exe" to start the server
3) MagicPacket cannot unlock your PC remotely. The easiest solution is to disable password login when you plan on remote play. Just keep in mind that this is a **security risk** since anyone can walk up and access the PC.
4) (Optional) Create a shortcut to the executable and place it in your startup folder so it runs on startup

- Press the Windows logo key + R, then type `shell:startup` and hit enter

---

## Development

### ToDo

- [ ] Connect the button to launch the bash scripts
- [ ] Display server IP and MAC under button
- [ ] Add "Settings" menu
- [ ] Add authentication support for sol
- [ ] Add "hostname" to configurator
- [ ] Add multi-computer functionality

Note: Always search for dev comments (#dev), todo comments (#todo), and work-in-progress (#wip) can can be cleared before committing

### Dev Resources

- [Plugin-dev Wiki](https://wiki.deckbrew.xyz/en/plugin-dev/getting-started)
- [Template Readme](https://github.com/SteamDeckHomebrew/decky-plugin-template/blob/main/README.md)
- [Database Readme](https://github.com/SteamDeckHomebrew/decky-plugin-database/blob/main/README.md)

Plugin Stores

- [Official/Stable](https://plugins.deckbrew.xyz/)
- [Beta](https://beta.deckbrew.xyz/)
- [Testing](https://testing.deckbrew.xyz/)

### Testing / Trouble Shotting

#### Viewing frontend logs

1) On the Steam Deck, go to the Decky Loader settings and enable "Allow Remote CEF Debugging"
2) Open Chrome and go to `chrome://inspect`
3) On the "Devices" page, click "Configure" and add `your-steam-deck-IP:8081`
4) Look for "Steam Shared Context" and click "inspect"
5) The "Console" logs will be in the bottom right corner

Search for "index.js" entries as that will most likely be the Decky plugins

#### Viewing Decky Loader logs

Run `journalctl -eu plugin_loader` in the konsole on the Steam Deck

---

Sources:

- https://github.com/scawp/Steam-Deck.Wake-Up-Rig
- https://github.com/SR-G/sleep-on-lan
