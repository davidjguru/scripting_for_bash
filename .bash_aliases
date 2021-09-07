## Morning Opertures
alias whatsup='service --status-all'  
alias hello='sudo /etc/init.d/apache2 stop && cd workspace/project && ddev start && ddev launch'   
alias hi='sudo systemctl stop apache2'  
alias iad='systemctl is-active docker'  
alias ports='nmap localhost'
alias dns="sudo systemd-resolve --status | grep 'DNS Servers'"
alias bye='shutdown -r now'  

## Usual Instructions  
alias yep='sudo apt install $1'
alias nop='sudo apt remove $1'
alias c='clear'  
alias h='history'  
alias hg='history | grep $1'  
alias wg='wget -c '  
alias al="echo '------------Your curent aliases are:------------';alias"  
alias sup="sudo apt update && sudo apt upgrade -y"  

## Content in folders  
### Getting info from a position in a folder.
alias ll='ls -la'     
alias lf='ls -alF'  
alias la='ls -A'  
alias ls='ls -CF'  
alias lt='ls --human-readable --size -1 -S --classify'  
alias lh='ls -ahlt'
alias lu='du -sh * | sort -h'  
alias lt='ls -t -1 -long'  
alias lc='find . -type f | wc -l'  
alias ld='ls -d */'  

### Info from Drupal: config files, types of content and existing paragraphs
alias lsc='ls -lah config/sync/ | wc -l'   
alias lsn='ls -lah config/sync/node.type.* | wc -l'    
alias lsp='ls -lah config/sync/paragraphs.paragraphs_type.* | wc -l'  
    
## Files, folders and resources  
alias fh='find . -name '   
alias ..='cd ..'  
alias ....='cd ../..'  
### More Jump down  
alias 1d="cd .."  
alias 2d="cd ..;cd .."  
alias 3d="cd ..;cd ..;cd .."  
alias 4d="cd ..;cd ..;cd ..;cd .."  
alias 5d="cd ..;cd ..;cd ..;cd ..;cd .."  
alias untar='tar -zxvf $1'  
alias tar='tar -czvf $1'  
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"  
alias df="df -Tha --total"   
alias exp='nautilus .'
alias std="stat -c '%y - %n' * | sort -r -t'-' -k1,1"
  ## Gets a list of files ordered by date.

## Git Related Aliases  
### Basic info
alias gs='git status'  
alias gb='git branch'  
alias gr='git remote -v'  

### Getting info from 'Git log'  
alias gl='git log --oneline'  
alias glc="git log --format=format: --name-only --since=12.month | egrep -v '^$' | sort | uniq -c  | sort -nr | head -50"  
alias gld='git log –oneline –decorate –graph –all'  
alias glp="git log -g --grep='PHP' -10 --pretty='%h - %s - %cn - %cd'"
alias glf='git for-each-ref --sort=-committerdate'   

### Pushing to basic branches 
alias gpom='git push origin master'  
alias gpod='git push origin develop'  

## Drush Commands
alias cex='ddev drush cex'  
alias cim='ddev drush cim'  
alias cexy='yes|ddev drush cex'  
alias cimy='yes|ddev drush cim'  
alias dgm='ddev drush generate module'  
alias dws='ddev drush watchdog:show –count=20'  
alias ddc='ddev drush cr'  
alias dpc='ddev drush pmu $1'
alias dec='ddev drush en -y $1'
alias dpe='ddev drush pmu $1 && ddev drush cr && ddev drush en -y $1'
alias dva='ddev drush views:analyze'
alias dpl='ddev drush pml'
alias dle="ddev drush pm-list --status='enabled'"
alias dld="ddev drush pm-list --status='disabled'"
alias dlo='ddev drush pm-list --type=module --status=enabled --no-core'
alias ddu='ddev exec drush user-create admin_drupal --mail="admindrupal@admin.es" --password="admin_drupal" && ddev exec drush user-add-role "administrator" admin_drupal && ddev exec drush cr'


## DDEV Explicit Aliases   
alias dsl='ddev start && ddev launch'   
alias ddy='ddev delete -Oy'  
alias did='ddev import-db'   
alias ddl='ddev list'  
alias dxo='ddev xdebug on'
alias dxf='ddev xdebug off'
alias dcr='ddev composer require $@'
alias dcm='ddev composer remove $@'

## Reviewing Codestyle Aliases  
alias dcs1="ddev exec -d=/var/www/html vendor/bin/phpcs --standard=Drupal --extensions='php,module,inc,install,test,profile,theme,info,txt,md' web/modules/custom/"  
alias dcs2="ddev exec -d=/var/www/html vendor/bin/phpcs --standard=DrupalPractice --extensions='php,module,inc,install,test,profile,theme,info,txt,md' web/modules/custom/"  
alias dcsr='ddev exec -d=/var/www/html vendor/bin/phpcs –report=diff'  
