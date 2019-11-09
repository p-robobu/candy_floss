#!/bin/bash
# Setup candy_floss project

cd `dirname $0`

# Prompt the user to approve installation
read -p "#### Setup candy_floss project? (Y/N): " res_prompt

if [ "$res_prompt" == "N" ]; then
    echo "Setup cancelled..."
    exit 0
fi

# Install Baxter SDK
cd ..
wstool init .
wstool merge https://raw.githubusercontent.com/RethinkRobotics/baxter/master/baxter_sdk.rosinstall
wstool update
source /opt/ros/kinetic/setup.bash

cd ..
catkin_make
catkin_make install

# Copy the baxter.sh to in the workspace folder
cp -af ./src/candy_floss/baxter.sh .

# Check 
read -p "#### Do you want to connect a real robot? (Y/N): " res_prompt

if [ "$res_prompt" == "Y" ]; then
    bash ./baxter.sh

    echo "If no response, something wrong with connection"
    ping 011411P0028.local
fi

