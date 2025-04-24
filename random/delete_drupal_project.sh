#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#
#-----------------------------------------------------------------------------------------------
# Delete a Drupal project locally
# Author: [David Rodríguez, @davidjguru] [davidjguru@gmail.com]
# Title: delete_drupal_project
# Description: Delete a Drupal project based on DDEV from a local development environment (LDE).
# Date: 2025-24-04
#
# Links:
# - https://www.therussianlullaby.com
# - https://davidjguru.github.io/
# - https://dev.to/davidjguru
# - https://github.com/davidjguru
#------------------------------------------------------------------------------------------------

# Destroy enabled Drupal site based in DDEV by name from project folder
echo -e "\n\e[1;4;31mThis script will permanently delete a DDEV-based Drupal project. The changes will be irreversible.\e[0m"
echo -e "\e[1;4;31mTo ensure everything works correctly, make sure you are running it from within the folder of a DDEV-based Drupal project.\e[0m"
# Ask for confirmation
read -p "Are you sure you want to continue? [Y/y]: " -n 1 -r
echo    # New line
if [[ $REPLY =~ ^[Yy]$ ]]; then
  KEYNAME=${PWD##*/}
  ddev stop
  yes |ddev delete -O
  cd ..
  rm -rf $KEYNAME
else
  echo -e "\nExecution cancelled by user. Exit...\n"
fi