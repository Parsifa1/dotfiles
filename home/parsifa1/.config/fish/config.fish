if status is-interactive
    # close fish greeting
    set -U fish_greeting

    # clean screen
    clear

    # set proxy
    git config --global http.proxy "localhost:7891"
    export all_proxy="http://localhost:7891"
    export http_proxy="http://localhost:7891"
    export https_proxy="http://localhost:7891"
    export ftp_proxy="http://localhost:7891"
    export no_proxy=localhost,127.0.0.1

    # set alias
    alias cls="clear"
    alias v="nvim"
    alias vi="nvim"
    alias py="python"
    alias fa="fastfetch"
    alias ls="exa --icons -F"
    alias vf="set -l file (fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'); and test -n \"\$file\"; and vi \"\$file\""
    alias zf="z \$(fd --type d --hidden . 2>/dev/null | fzf)"
    alias du="dust"
    alias dot='sudo git --git-dir=/.dotfiles/ --work-tree=/'

    # fix wslg
    export DISPLAY=":0"
    export WAYLAND_DISPLAY=wayland-0    #fix wayland

    # set some path & env
    export TERM=wezterm
    export PATH="$HOME/.cargo/bin:$PATH"
    export PATH="/home/parsifa1/.local/bin:$PATH"
    export $(dbus-launch)
    export EDITOR=/usr/bin/nvim
    export NODE_OPTIONS="--dns-result-order=ipv4first"    # set nodejs to ipv4 first
    export DIRENV_LOG_FORMAT=    # close direnv log
    export GPG_TTY=$(tty)    #fix gpg
    #conda
    source /opt/miniconda/etc/fish/conf.d/conda.fish    #
    # ghcup-env
    set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME    
    set -gx PATH $HOME/.cabal/bin /home/parsifa1/.ghcup/bin $PATH 
    # source windows
    if test -d "/mnt/c/Windows/System32/"
        export PATH="$PATH:/mnt/c/Windows/System32/"
    end
    #pnpm
    set -gx PNPM_HOME "/home/parsifa1/.local/share/pnpm"
    if not string match -q -- $PNPM_HOME $PATH
      set -gx PATH "$PNPM_HOME" $PATH
    end

    # set starship
    starship init fish | source
    # set atuin
    atuin init fish | source
    #set zoxide
    zoxide init fish | source
    #set direnv
    direnv hook fish | source

    # set fzf config
    export FZF_DEFAULT_COMMAND="fd -H -I --exclude={.git,.idea,.vscode,.sass-cache,node_modules,build,.vscode-server,.virtualenvs} --type f"
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --color=bg+:,bg:,gutter:-1,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

    #set yazi wrapper
    function ya
        set tmp (mktemp -t "yazi-cwd.XXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end

    # set Wezterm tabname
    function set_panetitle
        set -gx panetitle "🦄Arch"
        echo -n (printf "\033]1337;SetUserVar=panetitle=%s\007" (echo -n $panetitle | base64))
    end
    set_panetitle
end
