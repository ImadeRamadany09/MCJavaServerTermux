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
    ["1.17.1"]="https://example.com/minecraft_server.1.17.1.jar"
    ["1.17"]="https://example.com/minecraft_server.1.17.jar"
    ["1.16.5"]="https://example.com/minecraft_server.1.16.5.jar"
)