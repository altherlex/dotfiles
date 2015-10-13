GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

# load color
source ~/.bash_colors

if [ -s "$HOME/.rvm/bin/rvm-prompt" ]; then
  __rvm_ps1()
  {
    local r=`~/.rvm/bin/rvm-prompt`
    if [ -n "$r" ]; then
      printf " $r"
    fi
  }
fi
# function exists?
fn_exists()
{
  type $1 2>/dev/null | grep -q 'is a function'
}

# start redis port
REDIS_RUNNING=$(ps aux | grep redis | grep -cv grep)
if [[ ($REDIS_RUNNING = 0) ]]; then
  redis-server --port 16379
fi

# makes your terminal line looks like that: "[user@machine:current_directory ruby_version git_branch]"
# i like to leave one blank line between commands
#$CYAN\u$CYANBOLD@$CYAN\h:
PS1="\n$WHITE[$REDBOLD\w"
if fn_exists "__rvm_ps1"; then
  PS1=$PS1"$BLACKBOLD\$(__rvm_ps1)"
fi
if fn_exists "__git_ps1"; then
  PS1=$PS1"$YELLOWBOLD\$(__git_ps1 \" %s\")"
fi
PS1=$PS1"$WHITE] $WHITEBOLD\$$WHITE "

# load exports and aliases files
[[ -s "$HOME/.bash_exports" ]] && . "$HOME/.bash_exports"
[[ -s "$HOME/.bash_aliases" ]] && . "$HOME/.bash_aliases"
