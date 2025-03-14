# Description: This file contains the versions of the PaperMC server that you want to install.
#
# The format of the file is:
#
# declare -A MINECRAFT_VERSIONS
# MINECRAFT_VERSIONS=(
#     ["1.16.5"]="https://example.com/minecraft_server.1.16.5.jar"
# )
#
# The key is the version of the Minecraft server and the value is the URL to download the server jar file.
# You can add more versions by following the same format.
#
# Once you have added the versions, you can use the setup.sh script to install the PaperMC server by selecting the Paper variant.

declare -A MINECRAFT_VERSIONS
MINECRAFT_VERSIONS=(
    ["1.17.1"]="https://piston-data.mojang.com/v1/objects/a16d67e5807f57fc4e550299cf20226194497dc2/server.jar"
    ["1.17"]="https://piston-data.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar"
    ["1.16.5"]="https://piston-data.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar"
)