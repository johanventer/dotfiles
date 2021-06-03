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

## NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

## FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden'

## Extra paths
export PATH=~/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"

## Aliases
alias ls="ls --color=always"
alias ll="ls -lash"
alias vim="nvim"
alias gnvim="GDK_DPI_SCALE=1.5 gnvim"

## X server
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
export LIBGL_ALWAYS_INDIRECT=1

# Java
export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")

export EDITOR=nvim

# Set the window title
function set_win_title() {
  echo -ne "\033]0;${PWD/#$HOME/~}\007"
	printf "\e]9;9;%s\e\\" "$(wslpath -m "$PWD")"
}
precmd_functions+=(set_win_title)

## Starship!
eval "$(starship init zsh)"
