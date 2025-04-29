# Script Usage Instructions
This folder contains resources to improve the performance of your Linux environment (LDE) by extending console aliases and bash functions for day-to-day use.  

## Available scripts

1. **Aliases for bash**: `.bash_aliases` - It is a hidden type file (it has a starting point in its name) that contains aliases for common commands.  
2. **Functions for bash**: `.bash_functions` - It is a hidden type file (it has a leading dot in its name) that contains functions for bash.


## Steps

1. Download the hidden files and move the resources to your `/home` directory.  
  ```
  mv .bash_aliases .bash_functions /home
  ```

2. Just go to your /home and edit .bashrc main file. Then just add:  
  ```
  # Alias definitions.
  # You may want to put all your additions into a separate file like
  # ~/.bash_aliases, instead of adding them here directly.
  # See /usr/share/doc/bash-doc/examples in the bash-doc package.

  if [ -f ~/.bash_aliases ]; then
      . ~/.bash_aliases
  fi
  if [ -f ~/.bash_functions ]; then
      . ~/.bash_functions
  fi
  ```

3. Reload the main .bashrc file by doing: 
  ```
  $ source .bashrc
  ```
  
4. Now you will have all the aliases and functions available from your prompt. Check new features with a single example, cleaning your console: 
  ```
  $ c
  ```
  This alias is for command `clear` and if it clean your console, then **it works!** enjoy and **happy hacking!** 