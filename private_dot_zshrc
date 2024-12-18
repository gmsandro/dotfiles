# alias ys="yabai --start-service"
# alias yr="yabai --restart-service"
# alias yk="yabai --stop-service"
#
# alias sks="skhd --start-service"
# alias skr="skhd --restart-service"
# alias skk="skhd --stop-service"

# alias
alias vim="nvim"

export GPG_TTY=$(tty)

export PATH="$HOME/opt:$PATH"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Deno
export DENO_INSTALL="/Users/sandro/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/Users/sandro/.bun/_bun" ] && source "/Users/sandro/.bun/_bun"

# fnm
FNM_PATH="/Users/sandro/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
    export PATH="/Users/sandro/Library/Application Support/fnm:$PATH"
    eval "`fnm env`"
fi

# starship
eval "$(starship init zsh)"

export BAT_THEME="ansi"

# cargo
. "$HOME/.cargo/env"

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
[[ ! -r '/Users/sandro/.opam/opam-init/init.zsh' ]] || source '/Users/sandro/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration

# enable vim mode
# bindkey -v
