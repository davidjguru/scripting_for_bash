#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#
#-----------------------------------------------------------------------------------------
# Create a new Drupal project using DDEV
# Author: [David Rodríguez, @davidjguru] [davidjguru@gmail.com]
# Title: create_new_drupal_project
# Description: Build up a new Drupal project based on DDEV.
# Date: 2025-24-04
#
# Links:
# - https://www.therussianlullaby.com
# - https://davidjguru.github.io/
# - https://dev.to/davidjguru
# - https://github.com/davidjguru
#-----------------------------------------------------------------------------------------

# Initialize DDEV basic configuration
  ddev config --project-type=drupal10 --docroot=web
  yes | ddev composer create "drupal/recommended-project:^10"

# Require some basic contrib modules
  ddev composer require drush/drush drupal/admin_toolbar drupal/devel drupal/coffee
  ddev composer update --lock

# Execute site install    
  ddev exec drush si --site-name=$KEYNAME --account-name=admin --account-pass=admin -y
  ddev drush en -y admin_toolbar admin_toolbar_tools admin_toolbar_search admin_toolbar_links_access_filter devel devel_generate coffee

# Generate some dummy content
  ddev drush genc 50 4 --types=article

# Clean up the cache and launch the project
  ddev drush cr
  ddev start
  xdg-open $(ddev drush uli --uid=1)