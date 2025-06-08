# [Create Ultimate Selection 12.2.0](https://www.curseforge.com/minecraft/modpacks/create-ultimate-selection) on Curseforge

<!-- toc -->

- [Description](#description)
- [Requirements](#requirements)
- [Options](#options)
  * [Adding Minecraft Operators](#adding-minecraft-operators)
- [Troubleshooting](#troubleshooting)
  * [Accept the EULA](#accept-the-eula)
  * [Permissions of Files](#permissions-of-files)
  * [Resetting](#resetting)
- [Source](#source)

<!-- tocstop -->

## Description

This container is built to run on an [Unraid](https://unraid.net) server.

The docker on first run will download the same version as tagged `Create Ultimate Selection 12.2.0` and install it.  This can take a while as the Forge installer can take a bit to complete.  You can watch the logs and it will eventually complete.

After the first run it will simply start the server.

Note: There are no modded minecraft files shipped in the container, they are all downloaded at runtime.

## Requirements

* /data mounted to a persistent disk
* Port 25565/tcp mapped
* environment variable EULA set to "true"

As the end user, you are repsonsible for accepting the EULA from Mojang to run their server, by default in the container it is set to false.

## Options

Available environment variables:
|**Variable**|**Description**|**Required**|
|------------|---------------|------------|
|EULA|default is set to `false`|Yes|
|MAX_RAM|default is `4G`|No|
|MIN_RAM|default is `4G`|No|
|OPS|You can set Ops automatically by adding a comma separated list of player names. <br> example: `OPS="OpPlayer1,OpPlayer2"`|No|
|ALLOWLIST| you can set a whitelist automatically by adding a comma-separated list of player names.|No|
|MINECRAFT_PORT|You can change internal server port|No|
|MOTD|You can change from the default MOTD: "Create Ultimate Selection 12.2.0 Server Powered by Docker"|No|

## Volumes
|**Path**|**Description**|**Required**|
|--------|---------------|------------|
|/data|used to store the server files|Yes|

## Troubleshooting
<details><summary>Expand</summary>

### Accept the EULA
Did you pass in the environment variable EULA = `true`?

### File Permissions
This container is designed for [Unraid](https://unraid.net) so the user in the container runs on uid 99 and gid 100.  This may cause permission errors on the /data mount on other systems.

### Resetting
If the install is incomplete for some reason.  Deleting the downloaded server file in /data will restart the install/upgrade process.
</details>

## Source
Github: https://github.com/Konscription/docker-CreateUltimateSelection

Docker: https://hub.docker.com/repository/docker/konviction/createultimateselection/general