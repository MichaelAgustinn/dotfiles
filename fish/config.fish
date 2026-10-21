pfetch

#PATH
fish_add_path /opt/nvim-linux-x86_64/bin $HOME/.puro/bin $HOME/.puro/envs/stable/flutter/bin $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools

# function/alias
function start-pma
    php -S localhost:8081 -t /usr/share/webapps/phpMyAdmin
end

function start-db
    sudo systemctl start mariadb
end

function status-db
    systemctl status mariadb
end

function stop-db
    sudo systemctl stop mariadb
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    command rm -f -- "$tmp"
end
