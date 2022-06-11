#!/bin/bash
# https://docs.microsoft.com/en-us/dotnet/core/install/linux-ubuntu#2204

# Add repository
wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt update
sudo apt install dotnet-sdk-6.0 dotnet-runtime-6.0

# Opt-out telemetry
echo 'export DOTNET_CLI_TELEMETRY_OPTOUT=1' >>~/.bashrc

