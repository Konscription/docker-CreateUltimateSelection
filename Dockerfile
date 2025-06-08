# syntax=docker/dockerfile:1

FROM openjdk:11-jdk-buster

ENV MINECRAFT_PORT=25565

LABEL version="12.2.0"
LABEL homepage.group=Minecraft
LABEL homepage.name="Create Ultimate Selection 12.2.0"
LABEL homepage.icon="https://media.forgecdn.net/avatars/thumbnails/1156/169/64/64/638723864734826252.jpg"
LABEL homepage.widget.type=minecraft
LABEL homepage.widget.url=udp://CreateUltimateSelection:25565
RUN apt-get update && apt-get install -y curl unzip && \
 adduser --uid 99 --gid 100 --home /data --disabled-password minecraft
RUN rm -rf /var/lib/apt/lists/*

COPY launch.sh /launch.sh
RUN chmod +x /launch.sh

USER minecraft

VOLUME /data
WORKDIR /data

EXPOSE 25565/tcp

ENV MOTD " Server"

CMD ["/launch.sh"]