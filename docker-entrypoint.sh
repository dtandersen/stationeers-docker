#!/usr/bin/env bash
set -Eeox pipefail
id
export STEAMCMD=/usr/bin/steamcmd
export APP_DIR=/opt/stationeers
export BASE_DIR=/var/opt/stationeers
export LOG_DIR=$STATE_DIR/logs
export SAVE_DIR=$STATE_DIR/saves
#STEAMCMD=/steamcmd/steamcmd.sh

#if [ "$1" = 'rocketstation_DedicatedServer.x86_64' ] && [ "$(id -u)" = '0' ]; then

  # take ownership of stationeers
  # chown -R steam:steam $BASE
  #exec gosu steam "$BASH_SOURCE" "$@"

#fi

if [ "$1" = 'rocketstation_DedicatedServer.x86_64' ]; then

  # update dedicated server
  $STEAMCMD +login anonymous +force_install_dir $APP_DIR +app_update 600760 -beta $BRANCH validate $STEAMCMD_EXTRA +quit

  # create default.ini if it doesn't exist
  #if [ ! -f $BASE/default.ini ]; then
    #cp $BASE/rocketstation_DedicatedServer_Data/StreamingAssets/default.ini $BASE
    # change default password
    #sed -i s/RCONPASSWORD=stationeers/RCONPASSWORD=$(pwgen 15 1)/g $BASE/default.ini
  #fi

  rm -rf $APP_DIR/core.*
fi

if [ "$1" = 'rocketstation_DedicatedServer.x86_64' ]; then
  export PATH=$APP_DIR:$PATH
  #cd $APP_DIR
  #if [ -f prestart.sh ]; then
  #  chmod +x prestart.sh
  #  ./prestart.sh
  #fi
  exec "$@" -batchmode -nographics -autostart -basedirectory=$BASE_DIR
  #| tee -a $LOG_DIR/stationeers.log
else
  exec "$@"
fi
