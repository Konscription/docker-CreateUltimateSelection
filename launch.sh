#!/bin/bash

# Enable debug mode: each command will be printed before being executed
set -x

# Change working directory to /data where the server files should reside
cd /data

# Check if the EULA has been accepted via environment variable.
# If not, prompt the user and exit with status code 99.
if ! [[ "$EULA" = "false" ]]; then
    echo "eula=true" > eula.txt
else
    echo "You must accept the Minecraft EULA to install."
    exit 99
fi

# If the Create Ultimate Selection server zip is not already present,
# perform a clean-up of old server files and download/unzip the server package.
if ! [[ -f Create-Ultimate%20Selection%20Serverpack%20MC%201.20.1-12.3.0.zip ]]; then
    # Remove old configuration and mod files that might interfere with setup
    rm -fr config defaultconfigs kubejs libraries mods forge-*.jar \
           start.* Create-Ultimate%20Selection%20Serverpack%20MC%20*.zip

    # Download the Create Ultimate Selection Server zip file from CurseForge and unzip it into /data
    curl -Lo Create-Ultimate%20Selection%20Serverpack%20MC%201.20.1-12.3.0.zip 'https://edge.forgecdn.net/files/6634/365/Create-Ultimate%20Selection%20Serverpack%20MC%201.20.1-12.3.0.zip'
    unzip -u -o 'Create-Ultimate%20Selection%20Serverpack%20MC%201.20.1-12.3.0.zip' -d /data

    # Ensure the server start script is executable
    chmod u+x start.sh
fi

sed -i "s/SKIP_JAVA_CHECK=.*/SKIP_JAVA_CHECK=true/" /data/variables.txt
sed -i "s/USE_SSJ=.*/USE_SSJ=false/" /data/variables.txt

# If a MAX_RAM environment variable is set, update the memory configuration in server-setup-config.yaml
if [[ -n "$MAX_RAM" ]]; then
	sed -i "s/JAVA_ARGS=.*/JAVA_ARGS=\"-Xmx$MIN_RAM -Xms$MAX_RAM\"" /data/variables.txt
fi


# If a MOTD is specified, set it in the server.properties file
if [[ -n "$MOTD" ]]; then
    sed -i "s/motd\s*=/ c motd=$MOTD" /data/server.properties
else
    # If no MOTD is provided, set a default message
    sed -i "s/motd\s*=/ c motd=Create Ultimate Selection 12.3.0 Server Powered by Docker" /data/server.properties
fi

# If operator player list is provided as comma-separated values, split and write it to ops.txt
if [[ -n "$OPS" ]]; then
    echo $OPS | awk -v RS=, '{print}' > ops.txt
fi

# If allowlist (whitelist) is provided, split and write to white-list.txt
if [[ -n "$ALLOWLIST" ]]; then
    echo $ALLOWLIST | awk -v RS=, '{print}' > white-list.txt
fi

# Force the server port to 25565 (standard Minecraft port)
if [[ -z "$MINECRAFT_PORT" ]]; then
	MINECRAFT_PORT=25565
else
sed -i "s/server-port.*/server-port=$MINECRAFT_PORT/g" server.properties
fi



# Download a secure log4j2 configuration file to mitigate known vulnerabilities
curl -Lo log4j2_112-116.xml https://launcher.mojang.com/v1/objects/02937d122c86ce73319ef9975b58896fc1b491d1/log4j2_112-116.xml

# Start the Minecraft server using the provided startup script
./start.sh
