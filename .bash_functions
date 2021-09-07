## Creating Drupal projects by using DDEV 
d9ddev () {
  varkeyname=$1
  mkdir $varkeyname && cd $varkeyname
  ddev config --project-type=drupal9 --docroot=web --create-docroot
  yes | ddev composer create "drupal/recommended-project"
  ddev composer require drush/drush drupal/admin_toolbar drupal/devel
  ddev exec drush si --site-name=$varkeyname --account-name=admin --account-pass=admin -y
  ddev drush en -y admin_toolbar devel
  ddev drush cr
  ddev start && ddev launch
}

d8ddev () {
  varkeyname=$1
  mkdir $varkeyname && cd $varkeyname
  ddev config --project-type=drupal8 --docroot=web --create-docroot
  yes | ddev composer create "drupal/recommended-project:^8"
  ddev composer require drush/drush drupal/admin_toolbar drupal/devel
  ddev exec drush si --site-name=$varkeyname --account-name=admin --account-pass=admin -y
  ddev drush en -y admin_toolbar devel
  ddev drush cr
  ddev start && ddev launch
}
