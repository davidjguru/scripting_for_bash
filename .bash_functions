## Disabling, cleaning and enabling a Drupal module after executing changes.
### DDEV versions
dclin () {
  varkeyname=$1
  ddev drush pmu $varkeyname
  ddev drush cr
  ddev drush en -y varkeyname
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
