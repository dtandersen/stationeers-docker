#!/usr/bin/env bash
set -Eeox pipefail
id
export BASE=/home/steam/stationeers
export STEAMCMD=/usr/bin/steamcmd
#STEAMCMD=/steamcmd/steamcmd.sh

#if [ "$1" = 'rocketstation_DedicatedServer.x86_64' ] && [ "$(id -u)" = '0' ]; then

  # take ownership of stationeers
  # chown -R steam:steam $BASE
  #exec gosu steam "$BASH_SOURCE" "$@"

#fi

if [ "$1" = 'rocketstation_DedicatedServer.x86_64' ]; then

  # update dedicated server
  $STEAMCMD +login anonymous +force_install_dir $BASE +app_update 600760 -beta $BRANCH validate $STEAMCMD_EXTRA +quit

  # create default.ini if it doesn't exist
  if [ ! -f $BASE/default.ini ]; then
    cp $BASE/rocketstation_DedicatedServer_Data/StreamingAssets/default.ini $BASE
    # change default password
    sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=$(pwgen 15 1)/g $BASE/default.ini
  fi

  rm -rf $BASE/core.*

fi

if [ "$1" = 'rocketstation_DedicatedServer.x86_64' ]; then
  export PATH=/home/steam/stationeers:$PATH
  cd $BASE
  if [ -f prestart.sh ]; then
    chmod +x prestart.sh
    ./prestart.sh
  fi
  exec "$@" -batchmode -nographics -autostart -basedirectory=/home/steam/stationeers | tee -a /home/steam/stationeers/stationeers.log
else
  exec "$@"
fi
