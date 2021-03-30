#!/usr/bin/env bash
# 
# Bash shell script that runs the duologsync Docker image on Linux or macOS. 
#
#
# Version:  1.0.0
# Author:   Roberto Meléndez  [Cambridge, USA]
# GitHub:   https://github.com/rcmelendez/duologsync-docker
# Contact:  @rcmelendez on LinkedIn, Medium, and GitHub
# Released: March 29, 2021


set -euo pipefail

# Get kernel name
declare -r kernel_name=$(uname)

# Get host timezone
# Linux (CentOS/Ubuntu)
if [[ "${kernel_name}" == 'Linux' ]]; then
  TZ=$(timedatectl | awk '/Time zone:/ {print $3}')
# macOS
elif [[ "${kernel_name}" == 'Darwin' ]]; then  
  TZ=$(readlink /etc/localtime | sed 's#/var/db/timezone/zoneinfo/##')
else
  echo "Sorry, OS not supported. Run this script on Linux or macOS"
  exit 1
fi	

# Run Docker container
# Confirm Duo & Devo settings in config.yml are correct 
# before starting the container:
# Duo:  Admin API ikey, skey, and api-hostname
# Devo: Devo relay hostname, ports, protocol, and server mappings
if [[ -x "$(command -v docker)" ]]; then
  docker run -d \
    -e "TZ=${TZ}" \
    -v "${PWD}"/config.yml:/usr/src/app/duo_log_sync/config.yml \
    -v "${PWD}":/tmp \
    --name duologsync \
    --restart always \
    rcmelendez/duologsync config.yml
else
  "Please install Docker to run this script"
  exit 1
fi
