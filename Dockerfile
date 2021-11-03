FROM steamcmd/steamcmd
LABEL MAINTAINER https://github.com/dtandersen/stationeers

RUN apt-get update && \
  apt-get install -y pwgen gosu

ENV BRANCH=public
COPY docker-entrypoint.sh /

RUN mkdir -p /home/steam/stationeers && \
    touch /home/steam/stationeers/default.ini && \
    touch /home/steam/stationeers/blocked.txt
VOLUME /home/steam/stationeers

EXPOSE 27500/udp 27500/tcp 27015/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "rocketstation_DedicatedServer.x86_64" ]
