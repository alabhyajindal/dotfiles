if status is-interactive
    /home/alabhya/.rbenv/bin/rbenv init - fish | source
    source /home/alabhya/.config/fish/abbrevations.fish
end

set -gx EDITOR nvim

# opam configuration
source /home/alabhya/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

zoxide init fish | source

set -gx WASMTIME_HOME "$HOME/.wasmtime"

string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH
