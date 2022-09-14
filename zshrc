## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

export EDITOR=nvim

## Aliases
alias ls="ls --color=always"
alias ll="ls -lash"
alias vim="nvim"
alias gnvim="GDK_DPI_SCALE=1.5 gnvim"
alias fd="fdfind"

## X server
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
#export LIBGL_ALWAYS_INDIRECT=1

# PulseAudio
#export PULSE_HOST_IP="$(ip route |awk '/^default/{print $3}')"
#export PULSE_SERVER="tcp:$PULSE_HOST_IP"

## Java
#export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
#export ANT_HOME=/opt/apache-ant-1.10.11

## Extra paths
export PATH=$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$ANT_HOME/bin:/opt/sfdx/bin:/usr/local/go/bin:~/go/bin:$PATH

# Set the window title
function set_win_title() {
  echo -ne "\033]0;${PWD/#$HOME/~}\007"
	printf "\e]9;9;%s\e\\" "$(wslpath -m "$PWD")"
}
precmd_functions+=(set_win_title)

## NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden'

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export QT_STYLE_OVERRIDE=kvantum

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# Zoxide
eval "$(zoxide init zsh)"

## Starship!
eval "$(starship init zsh)"

