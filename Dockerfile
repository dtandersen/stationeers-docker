FROM biseque/steamcmd
MAINTAINER https://github.com/dtandersen/stationeers

ARG MANIFEST=6290103400087969170

WORKDIR /

RUN apt-get update && \
  apt-get install pwgen -y && \
  /steamcmd/steamcmd.sh +login anonymous +download_depot 600760 600762 $MANIFEST +quit && \
  mv /steamcmd/linux32/steamapps/content/app_600760/depot_600762 /opt/stationeers && \
  rm -rf /steamcmd/linux32/steamapps/content/app_600760 && \
  find /opt/stationeers -name ".svn" -type d -depth -exec rm -r "{}" \; && \
  mkdir -p /var/opt/stationeers && \
  mkdir -p /root/.config/unity3d/Rocketwerkz/rocketstation && \
  ln -s /var/opt/stationeers/log/Player.log /root/.config/unity3d/Rocketwerkz/rocketstation/Player.log

COPY docker-entrypoint.sh /

VOLUME /var/opt/stationeers

EXPOSE 27500/udp 27015/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
