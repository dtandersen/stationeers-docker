#!/usr/bin/env bash
set -Eeox pipefail
id
#export STEAMCMD=/usr/bin/steamcmd
#export APP_DIR=/opt/stationeers
#export PROFILE_DIR=/var/opt/stationeers
#export LOG_DIR=$STATE_DIR/logs
#export SAVE_DIR=$STATE_DIR/saves
#STEAMCMD=/steamcmd/steamcmd.sh
export DEFAULT_INI="$PROFILE_DIR/default.ini"


#if [ "$1" = 'rocketstation_DedicatedServer.x86_64' ] && [ "$(id -u)" = '0' ]; then

  # take ownership of stationeers
  # chown -R steam:steam $BASE
  #exec gosu steam "$BASH_SOURCE" "$@"

#fi

if [ "$1" = 'rocketstation_DedicatedServer.x86_64' ]; then

  # update dedicated server
  $STEAMCMD +login anonymous +force_install_dir $APP_DIR +app_update 600760 -beta $BRANCH $STEAMCMD_EXTRA +quit
  #$STEAMCMD +login anonymous +force_install_dir $APP_DIR +app_update 600760 -beta $BRANCH validate $STEAMCMD_EXTRA +quit

  # create default.ini if it doesn't exist
  if [ ! -f $DEFAULT_INI ]; then
    cp "$APP_DIR/rocketstation_DedicatedServer_Data/StreamingAssets/default.ini" "$PROFILE_DIR"
    # change default password
    RCONPASSWORD="${RCONPASSWORD:-`pwgen 7 1`}"
    ADMINPASSWORD="${ADMINPASSWORD:-`pwgen 7 1`}"
    PASSWORD="${PASSWORD:-`pwgen 7 1`}"
    sed -i "s/^SERVERNAME=.*/SERVERNAME=$WORLDTYPE Base $((1 + $RANDOM % 1000))/g" $DEFAULT_INI
    sed -i s/^RCONPASSWORD=.*/RCONPASSWORD=$RCONPASSWORD/g $DEFAULT_INI
    sed -i s/^ADMINPASSWORD=.*/ADMINPASSWORD=$ADMINPASSWORD/g $DEFAULT_INI
    sed -i s/^PASSWORD=.*/PASSWORD=$PASSWORD/g $DEFAULT_INI
#    sed -i s/^WORLDNAME=.*/WORLDNAME=$WORLDNAME/g $DEFAULT_INI
    sed -i s/^MAPNAME=.*/MAPNAME=$WORLDTYPE/g $DEFAULT_INI
  fi

  rm -rf $APP_DIR/core.*
fi

if [ "$1" = 'rocketstation_DedicatedServer.x86_64' ]; then
  export PATH=$APP_DIR:$PATH
  #cd $APP_DIR
  #if [ -f prestart.sh ]; then
  #  chmod +x prestart.sh
  #  ./prestart.sh
  #fi
  exec "$@" \
    -batchmode -nographics -autostart \
    -autosaveinterval="$AUTOSAVEINTERVAL" \
    -basedirectory="$PROFILE_DIR" \
    -loadworld="$WORLDNAME" \
    -worldtype="$WORLDTYPE"
  #| tee -a $LOG_DIR/stationeers.log
else
  exec "$@"
fi
