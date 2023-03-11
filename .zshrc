# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Switch off underlining
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path]=bold
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

export ZPLUG_HOME="$HOME/.zplug"

#export ZPLUG_LOG_LOAD_SUCCESS=false
#export ZPLUG_LOG_LOAD_FAILURE=false

if [[ ! -d "${ZPLUG_HOME}" ]];then
  git clone https://github.com/zplug/zplug "${ZPLUG_HOME}"
fi

source "${ZPLUG_HOME}/init.zsh"

if (( ${+ZPLUG_LOADFILE} )); then
  touch $ZPLUG_LOADFILE
fi

export PYENV_ROOT="$HOME/.pyenv"
export UMZ_PLAY_SOUND=1

# zplug
export SPACESHIP_VI_MODE_SHOW=false
zplug "zsh-users/zsh-history-substring-search"
#zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
#zplug "aperezdc/zsh-fzy"
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/sudo", from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh
zplug "plugins/copybuffer", from:oh-my-zsh
zplug "romkatv/powerlevel10k", use:powerlevel10k.zsh-theme

# Load completion library for those sweet [tab] squares
zplug "lib/completion", from:oh-my-zsh

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load

# History
setopt histignorespace
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

bindkey '\ec'     fzy-cd-widget
bindkey '^T'      fzy-file-widget
bindkey '^R'      fzy-history-widget
bindkey '^P'      fzy-proc-widget
bindkey '^ '      autosuggest-execute
bindkey "^[[H"    beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey '^[[1;2A' up-line-or-history 
bindkey '^[[1;2B' down-line-or-history 

case `uname` in
  Darwin)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PYTHON_CONFIGURE_OPTS="--enable-framework"
  ;;

  FreeBSD)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
  ;;

  Linux)
export LC_ALL=C.UTF-8
export LANG=C.UTF-8
  ;;
esac

export HOSTALIASES=$HOME/.hosts

export EDITOR=nvim
export DOTPUP_HOME="$HOME/Git/dotfiles"
export PLZ_SCRIPTS_PATH=$DOTPUP_HOME/scripts
export TERM=xterm-256color
export CONAN_VERBOSE_TRACEBACK=1
export DOTNET_TELEMETRY_OPTOUT=1

# Load general profiles
[[ -f ~/.zprofile ]] && source ~/.zprofile
[[ -f ~/.profile ]] && source ~/.profile

# Load host-specific profile
LOCAL_RC=~/.zshrc_$(hostname)
[[ -f "${LOCAL_RC}" ]] && source "$LOCAL_RC"

# Load powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Load terminal color-specific config
[[ -f ~/.term-theme ]] && source ~/.term-theme

# Load config from ~/.zshrc.d/
for config in ~/.zshrc.d/*; do
  source ${config}
done

# McFly
eval "$(mcfly init zsh)"

# Alias to rewrite current terminal color settings
nox() {
    DARKMODE=1 ~/Git/scripts/dark-mode-callback.sh
}
lumos() {
    DARKMODE=0 ~/Git/scripts/dark-mode-callback.sh
}
reload-term-colors()
{
    source ~/.term-theme
}
typeset -a preexec_functions
preexec_functions+=(reload-term-colors)

