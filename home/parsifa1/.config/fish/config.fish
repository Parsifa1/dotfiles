if status is-interactive
    # close fish greeting
    set -U fish_greeting

    # clean screen
    clear
    export COLUMNS=80
    export LINES=30
    export TERM=wezterm

    # set proxy
    git config --global http.proxy "localhost:7891"
    export all_proxy="http://localhost:7891"

    # # set some path
    export PATH="$HOME/.cargo/bin:$PATH"
    export $(dbus-launch)
    export EDITOR=/usr/bin/nvim
    export NODE_OPTIONS="--dns-result-order=ipv4first"  # set nodejs to ipv4 first
    set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/parsifa1/.ghcup/bin $PATH # ghcup-env
    source /opt/miniconda/etc/fish/conf.d/conda.fish
    if test -d "/mnt/c/Windows/System32/"
        export PATH="$PATH:/mnt/c/Windows/System32/"
    end


    # set fzf config
    export FZF_DEFAULT_COMMAND="fd -H -I --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs} --type f"
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse\
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

    # set starship
    starship init fish | source

    # set atuin
    atuin init fish | source

    #set zoxide
    zoxide init fish | source

    # set alias
    alias cls="clear"
    alias v="nvim"
    alias vi="nvim"
    alias py="python"
    alias fa="fastfetch"
    alias ls="exa --icons -F"
    alias ya="yazi"    
    alias vif="vi \$(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')"
    alias cdf="cd \$(find . -type d | fzf)"
    alias dot='sudo git --git-dir=/.dotfiles/ --work-tree=/'

    # set Wezterm tabname
    function set_panetitle
        set -gx panetitle "Arch"
        echo -n (printf "\033]1337;SetUserVar=panetitle=%s\007" (echo -n $panetitle | base64))
    end
    set_panetitle
end

