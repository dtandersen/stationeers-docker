FROM steamcmd/steamcmd:latest
LABEL MAINTAINER https://github.com/dtandersen/stationeers

RUN apt-get update && \
  yum install -y pwgen gosu

ENV BRANCH=public
COPY docker-entrypoint.sh /

VOLUME /home/steam/stationeers

EXPOSE 27500/udp 27500/tcp 27015/udp

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD [ "rocketstation_DedicatedServer.x86_64" ]
