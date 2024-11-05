source ~/.bash_aliases

# Prompt setup
## Colored frowny setup
RESET="\[\017\]"
NORMAL="\[\033[0m\]"
RED="\[\033[31;1m\]"
YELLOW="\[\033[33;1m\]"
WHITE="\[\033[37;1m\]"
SMILEY="${WHITE}:)${NORMAL}"
FROWNY="${RED}:(${NORMAL}"
SELECT="if [ \$? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"

## Throw it all together 
PS1="${RESET}${YELLOW}${NORMAL} \`${SELECT}\` ${YELLOW}\u:\w\$${NORMAL} "
export PS2="&gt; "

# Ask for color by default
export CLICOLOR=1
