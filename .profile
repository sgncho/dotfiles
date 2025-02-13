# homebrew
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
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

