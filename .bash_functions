## Disabling, cleaning and enabling a Drupal module after executing changes.
### DDEV versions
dclin () {
  varkeyname=$1
  ddev drush pmu $varkeyname
  ddev drush cr
  ddev drush en -y $varkeyname
}

dxclin () {
   varkeyname=$1
   ddev xdebug off
   ddev drush cr
   ddev drush pmu $varkeyname
   ddev drush cr
   ddev drush en -y $varkeyname
   ddev drush cr 
   ddev xdebug on
}

### Lando versions
lxclin () {
   varkeyname=$1
   lando xdebug off
   lando drush cr
   lando drush pmu $varkeyname
   lando drush cr
   landodrush en -y $varkeyname
   lando drush cr
   lando xdebug on
}

## Creating Drupal projects by using DDEV. 

d10ddev () {
  # If you don't provide a name the script will get a random name for the site.
  if [ -z "$1" ]
  then
      check=$(shuf -n1  /usr/share/dict/words)
      shortened=${check::-2}
      varkeyname=${shortened,,}
  else
      varkeyname=$1
  fi
  # Create main project folder.
  mkdir $varkeyname && cd $varkeyname
  # Prepare basic configuration.
  ddev config --project-type=drupal10 --docroot=web --create-docroot
  yes | ddev composer create "drupal/recommended-project:^10"
  # Require some extra Drupal resources.
  ddev composer require drush/drush drupal/admin_toolbar drupal/devel drupal/coffee
  ddev composer update --lock
  # Execute site install.
  ddev exec drush si --site-name=$varkeyname --account-name=admin --account-pass=admin -y
  # Enable modules and clean cache.
  ddev drush en -y admin_toolbar admin_toolbar_tools admin_toolbar_search admin_toolbar_links_access_filter devel devel_generate coffee
  ddev drush cr
  # Start the new site and open it in browser.
  ddev start && ddev launch
}

d9ddev () {
  if [ -z "$1" ]
    then
      check=$(shuf -n1  /usr/share/dict/words)
      shortened=${check::-2}
      varkeyname=${shortened,,}
  else
      varkeyname=$1
  fi
  mkdir $varkeyname && cd $varkeyname
  ddev config --project-type=drupal9 --docroot=web --create-docroot
  yes | ddev composer create "drupal/recommended-project:^9"
  ddev composer require drush/drush drupal/admin_toolbar drupal/devel
  ddev exec drush si --site-name=$varkeyname --account-name=admin --account-pass=admin -y
  ddev drush en -y admin_toolbar admin_toolbar_tools admin_toolbar_search admin_toolbar_links_access_filter devel devel_generate
  ddev drush cr
  ddev start && ddev launch
}

d8ddev () {
  if [ -z "$1" ]
    then
      check=$(shuf -n1  /usr/share/dict/words)
      shortened=${check::-2}
      varkeyname=${shortened,,}
  else
      varkeyname=$1
  fi
  mkdir $varkeyname && cd $varkeyname
  ddev config --project-type=drupal8 --docroot=web --create-docroot
  yes | ddev composer create "drupal/recommended-project:^8"
  ddev composer require drush/drush drupal/admin_toolbar drupal/devel
  ddev exec drush si --site-name=$varkeyname --account-name=admin --account-pass=admin -y
  ddev drush en -y admin_toolbar admin_toolbar_tools admin_toolbar_search admin_toolbar_links_access_filter devel devel_generate
  ddev drush cr
  ddev start && ddev launch
}

## Prepares a Drupal 9 installation for testing with PHPUnit executing from project folder.
d9phpunit () {
  varkeyname=${PWD##*/}
  string_url="<env name='BROWSERTEST_OUTPUT_BASE_URL' value='http://${varkeyname}.ddev.site/'/>"
  ddev composer require --dev phpunit/phpunit symfony/phpunit-bridge \
                              behat/mink-goutte-driver behat/mink-selenium2-driver \
                              phpspec/prophecy-phpunit --with-all-dependencies
  cd web/core
  cp phpunit.xml.dist phpunit.xml
  sed -i 's+<env name="SIMPLETEST_BASE_URL" value=""/>+<env name="SIMPLETEST_BASE_URL" value="http://localhost"/>+g' phpunit.xml
  sed -i 's+<env name="SIMPLETEST_DB" value=""/>+<env name="SIMPLETEST_DB" value="mysql://db:db@db/db"/>+g' phpunit.xml
  sed -i 's+<env name="BROWSERTEST_OUTPUT_DIRECTORY" value=""/>+<env name="BROWSERTEST_OUTPUT_DIRECTORY" value="/var/www/html/web/sites/default/simpletest/browser_output/"/>+g' phpunit.xml
  sed -i 's+<env name="BROWSERTEST_OUTPUT_BASE_URL" value=""/>+'"$string_url"'+g' phpunit.xml
  cd ../..
  ddev exec ./vendor/bin/phpunit -c web/core /var/www/html/web/modules/contrib/admin_toolbar
}

## Same but for Drupal 8.
d8phpunit () {
  varkeyname=${PWD##*/}
  string_url="<env name='BROWSERTEST_OUTPUT_BASE_URL' value='http://${varkeyname}.ddev.site/'/>"
  ddev composer require --dev phpunit/phpunit:^7 symfony/phpunit-bridge:^3.4.3 \
                              behat/mink-goutte-driver:^1.2 behat/behat:^3.4 behat/mink:^1.8 \
                              behat/mink-selenium2-driver:^1.5.0 --with-all-dependencies
  cd web/core
  cp phpunit.xml.dist phpunit.xml
  sed -i 's+<env name="SIMPLETEST_BASE_URL" value=""/>+<env name="SIMPLETEST_BASE_URL" value="http://localhost"/>+g' phpunit.xml
  sed -i 's+<env name="SIMPLETEST_DB" value=""/>+<env name="SIMPLETEST_DB" value="mysql://db:db@db/db"/>+g' phpunit.xml
  sed -i 's+<env name="BROWSERTEST_OUTPUT_DIRECTORY" value=""/>+<env name="BROWSERTEST_OUTPUT_DIRECTORY" value="/var/www/html/web/sites/default/simpletest/browser_output/"/>+g' phpunit.xml
  sed -i 's+<env name="BROWSERTEST_OUTPUT_BASE_URL" value=""/>+'"$string_url"'+g' phpunit.xml
  cd ../..
  ddev exec ./vendor/bin/phpunit -c web/core /var/www/html/web/modules/contrib/admin_toolbar

}

## Destroy enabled Drupal site based in DDEV by name from project folder.
ddevdestroy () {
  varkeyname=${PWD##*/}
  ddev stop
  yes |ddev delete -O
  cd ..
  rm -rf $varkeyname
}
