# syntax=docker/dockerfile:1

FROM eclipse-temurin:17.0.15_6-jre-noble

ENV MINECRAFT_PORT=25565
#ENV JAVA=/usr/local/openjdk-22/bin/java
ENV JAVA=java

LABEL version="12.2.0"
LABEL homepage.group=Minecraft
LABEL homepage.name="Create Ultimate Selection 12.2.0"
LABEL homepage.icon="https://media.forgecdn.net/avatars/thumbnails/1156/169/64/64/638723864734826252.jpg"
LABEL homepage.widget.type=minecraft
LABEL homepage.widget.url=udp://CreateUltimateSelection:25565
RUN apt-get update && apt-get install -y curl unzip && \
 adduser --uid 99 --gid 100 --home /data --disabled-password minecraft
RUN apt-get upgrade -y
RUN rm -rf /var/lib/apt/lists/*

COPY launch.sh /launch.sh
RUN chmod +x /launch.sh

USER minecraft

VOLUME /data
WORKDIR /data

#minecraft Server port
EXPOSE 25565/tcp
#create mod voice chat
EXPOSE 24454/tcp 

ENV MOTD=" Server"

ENTRYPOINT ["/bin/bash"]
CMD ["/launch.sh"]