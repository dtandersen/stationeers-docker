# Stationeers Dedicated Server [![](https://images.microbadger.com/badges/image/dtandersen/stationeers.svg)](https://microbadger.com/images/dtandersen/stationeers "Get your own image badge on microbadger.com") [![Docker Pulls](https://img.shields.io/docker/pulls/dtandersen/stationeers.svg)](https://hub.docker.com/r/dtandersen/stationeers/) [![Docker Stars](https://img.shields.io/docker/stars/dtandersen/stationeers.svg)](https://hub.docker.com/r/dtandersen/stationeers/)

Play [Stationeers](https://store.steampowered.com/app/544550/Stationeers/) with your friends!

## Usage

**Interactive**

For a quick test run Stationeers in interactive mode with the `-it` option. `--rm` deletes the container afterward. `CTRL+C` stops the server.

```console
docker run -it --rm \
-p 27500:27500 -p 27500:27500/udp -p 27015:27015/udp \
-v `pwd`/stationeers:/var/opt/stationeers \
dtandersen/stationeers \
-loadworld=myworld
```

**Background**

Run Stationeers as background process with the `-d` (detached) option.

```console
docker run -d \
--name stationeers \
-p 27500:27500 -p 27500:27500/udp -p 27015:27015/udp \
-v `pwd`/stationeers:/var/opt/stationeers \
dtandersen/stationeers \
-loadworld=myworld
```

View the logs:

```console
docker logs stationeers
```

Stop the server:

```console
docker stop stationeers
```

Restart the server:

```console
docker restart stationeers
```

Destroy the server:

```console
docker rm stationeers
```

## Configuration

Put `default.ini` in the root of the mounted volume. If no `default.ini` is found a default `default.ini` is used.

Example `default.ini`:

```INI
[SERVER]
SERVERNAME=Stationeers
GAMEPORT=27500
UPDATERPORT=27015
PASSWORD=
MAPNAME=Moon
DESCRIPTION=Stationeers
MAXPLAYER=10

[RCON]
RCONPASSWORD=stationeers
```

## Saves

Saves are stored in the `/saves` directory of the mounted volume. Saves will be lost if `-v /some/local/path:/var/opt/stationeers` wasn't used.

Start the server with the `-loadworld=<name of save>` option to load a save.

Specify the world type with `-worldtype=Mars|Moon|Europa`.

## Command Line Options

* `-clearallinterval=<time in seconds>` - How often to remove disconnected players ([0=never](https://steamcommunity.com/games/544550/announcements/detail/1692683865304626238), default=immediately)
* `-autosaveinterval=<time in seconds>` - How often to auto save the game (default=never)

Refer to the Unofficial Stationeers Wiki for more information about [command line options](https://stationeers-wiki.com/Dedicated_Server_Guide).

NOTE: `-batchmode`, `-nographics`, and `-autostart` are automatically set.

## Image Layout

Stationeers is installed to `/opt/stationeers`.

Saves and configuration are stored at `/var/opt/stationeers`.

```
/
|-- var
|   `-- opt
|      `-- stationeers
|          |-- default.ini
|          |-- saves
|          |   |-- mysave1
|          |   `-- mysave2
|          `-- log
|              `-- Player.log <- /root/.config/unity3d/Rocketwerkz/rocketstation/Player.log
`-- opt
    `-- stationeers
```

## rcon

The "rcon console" is available at http://HOST:GAMEPORT. Remove `-p 27500` from `docker run` to disable remote access to rcon.

The rcon password is set by `RCONPASSWORD` in `default.ini`. A random password is generated if `default.ini` doesn't exist when the server starts.

### stationeersrcon

[stationeersrcon](https://github.com/matjam/stationeersrcon) is a command line rcon client for Stationeers.

```console
curl -L https://github.com/matjam/stationeersrcon/releases/download/v1.2.0/srcon-1.2.0-linux.zip -o /tmp/srcon.zip
sudo unzip /tmp/srcon.zip srcon -d /bin
rm -f /tmp/srcon.zip
cat << EOF > ~/.srcon
{
  "password": "rconpassword",
  "hostname": "127.0.0.1",
  "port": "27500"
}
srcon status
```

-e STEAMCMD_EXTRA="+workshop_download_item 544550 1322471261"

#!/bin/bash -x
$STEAMCMD +login anonymous +force_install_dir $BASE +workshop_download_item 544550 1322471261 +quit
#cp -f /home/steam/stationeers/steamapps/workshop/content/544550/1322471261/GameData/autolathe.xml /home/steam/stationeers/rocketstation_DedicatedServer_Data/StreamingAssets/Data/autolathe.xml
mkdir -p /home/steam/stationeers/rocketstation_DedicatedServer_Data/mods/OreProducer
cp -r /home/steam/stationeers/steamapps/workshop/content/544550/1322471261/* /home/steam/stationeers/rocketstation_DedicatedServer_Data/mods/OreProducer
