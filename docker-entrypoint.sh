#!/bin/bash -x
set -e

BASE=/home/steam/stationeers
#STEAMCMD=/home/steam/steamcmd/steamcmd.sh
STEAMCMD=/steamcmd/steamcmd.sh
#mkdir -p $BASE/log
BETA=public

$STEAMCMD +login anonymous +force_install_dir $BASE +app_update 600760 -beta $BETA validate +quit

if [ ! -f $BASE/default.ini ]; then
  cp $BASE/rocketstation_DedicatedServer_Data/StreamingAssets/default.ini $BASE
  # change default password
  sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=$(pwgen 15 1)/g $BASE/default.ini
fi

rm -rf $BASE/core.*

exec $BASE/rocketstation_DedicatedServer.x86_64 \
  -batchmode -nographics -autostart \
  -basedirectory=$BASE \
  "$@"
