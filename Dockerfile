#FROM biseque/steamcmd
FROM cm2network/steamcmd:root
LABEL MAINTAINER https://github.com/dtandersen/stationeers

#ARG MANIFEST=6290103400087969170
#USER root
#WORKDIR /
#COPY stationeers.txt /home/steam
#COPY update.sh /home/steam
RUN apt-get update && \
  apt-get install -y pwgen gosu
#RUN  /home/steam/steamcmd/steamcmd.sh +quit && \
#  /home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/stationeers +download_depot 600760 600762 $MANIFEST +quit && \

#RUN $STEAMCMD +login anonymous +app_update 600760 -beta $BETA validate +quit

#RUN  /home/steam/steamcmd/steamcmd.sh +login  && \
#RUN  /home/steam/update.sh && \
#  mv /home/steam/steamcmd/linux32/steamapps/content/app_600760/depot_600762 /opt/stationeers && \
#  rm -rf /home/steam/steamcmd/linux32/steamapps/content/app_600760 && \
#  find /opt/stationeers -name ".svn" -type d -depth -exec rm -r "{}" \; && \
#  mkdir -p /var/opt/stationeers && \
#  mkdir -p /root/.config/unity3d/Rocketwerkz/rocketstation && \
#  ln -s /var/opt/stationeers/log/Player.log /root/.config/unity3d/Rocketwerkz/rocketstation/Player.log

ENV BRANCH=public
COPY docker-entrypoint.sh /

VOLUME /home/steam/stationeers

EXPOSE 27500/udp 27500/tcp 27015/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "rocketstation_DedicatedServer.x86_64" ]
