#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#
#-----------------------------------------------------------------------------------------
# Install Docker Engine and DDEV on Ubuntu
# [David Rodríguez, @davidjguru] [davidjguru@gmail.com]
# Title: install_docker_engine_ddev
# Description: Install the latest available versions of Docker Engine and DDEV.
#
# Links:
# - https://www.therussianlullaby.com
# - https://davidjguru.github.io/
# - https://dev.to/davidjguru
# - https://github.com/davidjguru
#-----------------------------------------------------------------------------------------

# Ask for confirmation
echo -e "\n\e[1;4;31mThis script will execute important changes on your system.\e[0m"
echo -e "\e[1;4;31mThese changes can be risky. Consider using an isolation layer such as VirtualBox.\e[0m"
read -p "Are you sure you want to continue? [Y/y]: " -n 1 -r
echo    # New line

if [[ $REPLY =~ ^[Yy]$ ]]; then

  # Enable automatic stop on error
  set -e

  # Update package list
  echo -e "\n\e[1;4;31mUpdating package list...\e[0m"
  sudo apt update

  # Install basic system resources
  echo -e "\n\e[1;4;31mInstalling basic system dependencies...\e[0m"
  sudo apt install -y build-essential apt-transport-https ca-certificates jq curl software-properties-common file git

  # Install Docker
  echo -e "\n\e[1;4;31mInstalling Docker from the official repository...\e[0m"
  
  # Add Docker's official GPG key
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add Docker repository
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt update

  # Install Docker packages
  sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  # Configure Docker user group
  echo -e "\n\e[1;4;31mConfiguring Docker group permissions...\e[0m"
  sudo groupadd docker || true
  sudo usermod -aG docker "$USER"
  newgrp docker

  echo -e "\n\e[1;4;31mGranting Docker socket permissions...\e[0m"
  sudo chmod 666 /var/run/docker.sock

  # Docker validation
  echo -e "\n\e[1;4;31mDocker status:\e[0m"
  systemctl is-active docker

  echo -e "\n\e[1;4;31mDocker version:\e[0m"
  docker --version

  echo -e "\n\e[1;4;31mRunning Docker hello-world test...\e[0m"
  docker run hello-world

  # Install DDEV
  echo -e "\n\e[1;4;31mInstalling DDEV...\e[0m"

  if command -v brew &> /dev/null; then
    echo -e "\n\e[1;4;31mHomebrew detected. Upgrading DDEV using Brew...\e[0m"
    brew update
    brew upgrade ddev
    ddev version
  else
    echo -e "\n\e[1;4;31mInstalling DDEV from official repository...\e[0m"

    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://pkg.ddev.com/apt/gpg.key | gpg --dearmor | \
      sudo tee /etc/apt/keyrings/ddev.gpg > /dev/null
    sudo chmod a+r /etc/apt/keyrings/ddev.gpg

    echo "deb [signed-by=/etc/apt/keyrings/ddev.gpg] https://pkg.ddev.com/apt/ * *" | \
      sudo tee /etc/apt/sources.list.d/ddev.list > /dev/null

    sudo apt update
    sudo apt install -y ddev

    echo -e "\n\e[1;4;31mRunning mkcert one-time initialization...\e[0m"
    mkcert -install

    echo -e "\n\e[1;4;31mDDEV version:\e[0m"
    ddev version
  fi

  # Ask for if a new Drupal project is required
  echo -e "\n\e[1;4;31mWould you like to create a new DDEV project now? (e.g., for Drupal development)\e[0m"
  read -p "Create new DDEV project? [Y/y]: " -n 1 -r
  echo    # New line

  if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n\e[1;4;31mCreating a new DDEV project...\e[0m"
    read -p "Enter the project name: " PROJECT_NAME
    mkdir "$PROJECT_NAME"
    cd "$PROJECT_NAME"
    ddev config --project-type=drupal10 --docroot=web --create-docroot
    yes | ddev composer create "drupal/recommended-project:^10"
    ddev composer require drush/drush drupal/admin_toolbar drupal/devel drupal/coffee
    ddev composer update --lock
    ddev exec drush si --site-name=$PROJECT_NAME --account-name=admin --account-pass=admin -y
    ddev drush en -y admin_toolbar admin_toolbar_tools admin_toolbar_search admin_toolbar_links_access_filter devel devel_generate coffee
    ddev drush cr
    ddev start && ddev launch
    echo -e "\n\e[1;4;31mDDEV project '$PROJECT_NAME' has been created and started.\e[0m"
    echo -e "\e[1;4;31mYou can now access it at: http://$PROJECT_NAME.ddev.site\e[0m"
  else
    echo -e "\n\e[1;4;31mNo project created. You can always create one later using 'ddev config'.\e[0m"
  fi
else
  echo -e "\nExecution cancelled by user. Exiting...\n"
fi

