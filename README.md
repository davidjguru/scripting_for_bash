# scripting_for_bash
Some bash scripting for daily life.

# Use
Just go to your /home and edit .bashrc main file. Then just add:  
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

And finally reload the main .bashrc file by doing: 
```
$ source .bashrc
```
Now you will have all the aliases and functions available from your prompt. Check new features with a single example, cleaning your console: 
```
$ c
```

This alias is for command `clear` and if it clean your console, It works! enjoy and happy hacking! 

@davidjguru, davidjguru@gmail.com  2021 - 2022
