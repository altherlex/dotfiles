if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true

source ~/.nvm/nvm.sh
# load color
source ~/.bash_colors

# start redis port
REDIS_RUNNING=$(ps aux | grep redis | grep -cv grep)
if [[ ($REDIS_RUNNING = 0) ]]; then
  cd ~/desenv/ubber-site && DISABLE_SPRING=true rails runner "Rails.application.load_seed"
  redis-server --port 16379 &
  redis-server --port 6379 &
fi

# load exports and aliases files
[[ -s "$HOME/.bash_exports" ]] && . "$HOME/.bash_exports"
[[ -s "$HOME/.bash_aliases" ]] && . "$HOME/.bash_aliases"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# ------------ PS1 load ------------
[ -n "$PS1" ] && source ~/.bash_prompt;
