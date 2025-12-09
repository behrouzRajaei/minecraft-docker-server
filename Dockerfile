FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV MINECRAFT_PORT=25565
ENV MEMORY_MIN=1G
ENV MEMORY_MAX=2G

RUN apt-get update && \
    apt-get install -y openjdk-21-jre-headless wget curl jq && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/minecraft

RUN mkdir -p mods

COPY fabric-server-launch.jar /opt/minecraft/fabric-server-launch.jar
COPY mods /opt/minecraft/mods

RUN echo "eula=true" > eula.txt

EXPOSE ${MINECRAFT_PORT}

ENTRYPOINT ["bash","-c","java -Xms${MEMORY_MIN} -Xmx${MEMORY_MAX} -jar fabric-server-launch.jar nogui"]

