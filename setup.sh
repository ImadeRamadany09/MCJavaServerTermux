#!/bin/bash



echo "Minecraft Server Setup Script for Arm64 Devices"
    sleep 3

echo "Welcome to Minecraft Server Setup Script"
    sleep 1
echo "This script will install the required dependencies to run a Minecraft server on your device."
    sleep 1
echo "Internet connection is required to download the server jar."
    sleep 1

# Updating & Installing dependencies
echo -e "Updating system packages and Install wget"
    pkg upgrade -y && pkg install wget -y 
    sleep 2 
    clear
    echo "System packages updated successfully"
    sleep 2

# Setting up storage permission
echo -e "Setting up storage permission"
    termux-setup-storage 

    # Initialize counter and set timeout limit (e.g., 10 attempts)
    counter=0
    timeout=10

    while true; do
        if [ -d ~/storage/shared ]; then
            echo "Storage permission granted."
            break
        else
            echo "Storage permission denied. Attempt $((counter+1)) of $timeout."
        fi
        
        # Increment counter and check if timeout is reached
        counter=$((counter+1))
        if [ $counter -ge $timeout ]; then
            echo "Timeout reached. Please grant storage permission manually."
            break
        fi
        
        sleep 3
    done

# Creating links for the Minecraft Server Directory with termux home directory
echo "Making a Shortcut for the Minecraft Server Directory with termux home directory"
    sleep 1
    ln -s ~/storage/shared/minecraft_server ~/minecraft_server
    clear

# Selecting Variant
echo -e "Select the variant you want to install"
echo -e "1. Vanilla"
echo -e "2. Paper"
echo -e "3. Spigot"
    read -p "Enter the variant number: " variant

# Selecting Variant on Selected Variant
case $variant in

    # Vanilla Server
    1)
        echo "Vanilla Server Selected" && sleep 3

            # Source the Minecraft Vanilla versions file
            source ./vanilla_versions.sh

        echo "Making Directory for Minecraft Server in ~/storage/shared"
            mkdir -p ~/storage/shared/minecraft_server
            cd ~/storage/shared/minecraft_server && sleep 3

        echo "Installing Vanilla Server" && sleep 1
        echo -e "Select Minecraft Version"
            for version in "${!MINECRAFT_VERSIONS[@]}"; do
                echo -e "$version"
            done
        
        read -p "Enter the version number: " version
            if [[ -n "${MINECRAFT_VERSIONS[$version]}" ]]; then
                echo "Installing Minecraft $version"
                # Download and install the server jar
                wget -O server.jar "${MINECRAFT_VERSIONS[$version]}" 
            else
                echo "Invalid Version Selected"
            fi
            ;;

    # Paper Server
    2)
        echo "Paper Server selected, Installing Paper Server..."

            # Source the Minecraft Paper versions file
            source ./paper_versions.sh

        echo "Making Directory for Minecraft Server in ~/storage/shared"
            mkdir -p ~/storage/shared/minecraft_server
            cd ~/storage/shared/minecraft_server

        echo "Installing Paper Server"
        echo -e "Select Minecraft Version"
            for version in "${!MINECRAFT_VERSIONS[@]}"; do
                echo -e "$version"
            done
        
        read -p "Enter the version number: " version
            if [[ -n "${MINECRAFT_VERSIONS[$version]}" ]]; then
                echo "Installing Minecraft $version"
                # Download and install the server jar
                wget -O server.jar "${MINECRAFT_VERSIONS[$version]}" 
            else
                echo "Invalid Version Selected"
            fi
        ;;

    # Spigot Server
    3)
        echo "Installing Spigot Server"

        # Source the Minecraft Spigot file list
            source ./spigot_versions.sh

        echo "Making Directory for Minecraft Server in ~/storage/shared"
            mkdir -p ~/storage/shared/minecraft_server
            cd ~/storage/shared/minecraft_server

        echo "Installing Spigot Server"
        echo -e "Select Minecraft Version"
            for version in "${!MINECRAFT_VERSIONS[@]}"; do
                echo -e "$version"
            done
        
        read -p "Enter the version number: " version
            if [[ -n "${MINECRAFT_VERSIONS[$version]}" ]]; then
                echo "Installing Minecraft $version"
                # Download and install the server jar
                wget -O server.jar "${MINECRAFT_VERSIONS[$version]}" 
            else
                echo "Invalid Version Selected"
            fi
        ;;


    *)
        echo "Invalid Variant Selected"
        ;;
esac

# Installing Java
# Java 21 is installed for compatibility with Minecraft 1.17 and above
echo -e "Installing Java 21. \n sadly, Java 8 is not available in termux repositories so you must find an alternative way to install it."
    pkg install openjdk-21 -y

# Running the Minecraft Server
echo "Making EULA file"
    read -p "Do you agree to the Minecraft EULA? (yes/no): " eula_agree

    if [ "$eula_agree" == "yes" ]; then
        echo "eula=true" > eula.txt
        echo "Generating Startup JVM Args"
    else
        echo "You must agree to the EULA to run the server."
        sleep 1 && echo "You need to edit the eula.txt file to agree to the EULA" && sleep 1
    fi
echo "Generating Startup JVM Args"

    read -p "Enter the amount of RAM you want to allocate to the server (in MB): " ram
    echo -e "#!/bin/bash \njava -Xms${ram}M -Xmx${ram}M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui" > ~/start.sh
    echo -e "#!/bin/bash \njava -Xms${ram}M -Xmx${ram}M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+ParallelRefProcEnabled -XX:+PerfDisableSharedMem -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:G1HeapRegionSize=8M -XX:G1HeapWastePercent=5 -XX:G1MaxNewSizePercent=40 -XX:G1MixedGCCountTarget=4 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1NewSizePercent=30 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:G1ReservePercent=20 -XX:InitiatingHeapOccupancyPercent=15 -XX:MaxGCPauseMillis=200 -XX:MaxTenuringThreshold=1 -XX:SurvivorRatio=32 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar server.jar nogui" > ~/minecraft_server/start.sh

chmod +x start.sh
chmod +x ~/minecraft_server/start.sh

sleep 3

echo "Setup Completed"
sleep 1 && echo "You can now start the server by running ./start.sh anywhere." && sleep 1 && echo "Don't forget to edit the server.properties file to customize your server settings" && sleep 1 && echo "Thanks for using the script" && sleep 1
read -p "Press enter to exit" exit
exit
