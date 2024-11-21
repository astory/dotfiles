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

# Git autocompletion, requires `brew install git bash-completion`
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

export EDITOR=nvim

# Keep lots of bash history
shopt -s histappend
HISTSIZE=1000000
HISTFILESIZE=1000000

# Set `USE_CODEOWNERS_RS=true` in your shell init script to use our new
# rust-based `codeowners` pre-commit hook. Significantly faster code ownership
# checks await! 
USE_CODEOWNERS_RS=true
