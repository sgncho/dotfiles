export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"

export LESSHISTFILE=-

# matplotlib
export MPLCONFIGDIR="$HOME/.config/matplotlib"

# homebrew
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# PATH
if [ -f "$HOME/.paths" ]; then
  while IFS= read -r line; do
    case "$line" in ''|\#*) continue ;; esac
    expanded=$(eval echo "$line")
    case ":$PATH:" in
      *":$expanded:"*) ;;
      *) PATH="$PATH:$expanded" ;;
    esac
  done < "$HOME/.paths"
fi

# source .profile.d
if [ -d "$HOME/.profile.d" ]; then
    for script in "$HOME/.profile.d/"*; do
        [ -f "$script" ] && [ -r "$script" ] && . "$script"
    done
fi

if [ -n "$BASH_VERSION" ]; then
    # Check interactive shell
    if [[ "$-" != *i* ]]; then return; fi

    if [ -f "$HOME/.bashrc" ]; then
        source "$HOME/.bashrc"
    fi
fi
