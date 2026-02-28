#!/bin/bash

echo "Installing FAHHHH-Linux..."

# Detect Package Manager and Install mpv ( fedora / arch / ubuntu )
if command -v apt >/dev/null; then
    sudo apt update && sudo apt install mpv -y
elif command -v dnf >/dev/null; then
    sudo dnf install mpv -y
elif command -v pacman >/dev/null; then
    sudo pacman -S mpv --noconfirm
else
    echo "Error: Package manager not found. Please install 'mpv' manually."
    exit 1
fi

# setup sound folder and download
mkdir -p ~/.fahhhh
curl -sL https://raw.githubusercontent.com/snowwysillycat/FAHHH/main/fahhhh.mp3 -o ~/.fahhhh/fahhhh.mp3

# Create the Hook Code
HOOK='
# --- FAHHHH START ---
_fahhhh_play() {
    mpv --no-video --really-quiet ~/.fahhhh/fahhhh.mp3 &>/dev/null &
}

command_not_found_handle() {
    _fahhhh_play
    echo "bash: $1: command not found"
    return 127
}

command_not_found_handler() {
    _fahhhh_play
    echo "zsh: command not found: $1"
    return 127
}

_fahhhh_check_status() {
    local status=$?
    if [ $status -ne 0 ] && [ $status -ne 127 ]; then
        _fahhhh_play
    fi
}

if [ -n "$BASH_VERSION" ]; then
    [[ "$PROMPT_COMMAND" != *"_fahhhh_check_status"* ]] && PROMPT_COMMAND="_fahhhh_check_status; $PROMPT_COMMAND"
elif [ -n "$ZSH_VERSION" ]; then
    [[ ! " ${precmd_functions[*]} " == *" _fahhhh_check_status "* ]] && precmd_functions+=(_fahhhh_check_status)
fi
# --- FAHHHH END ---
'

# Inject into .bashrc and .zshrc
if ! grep -q "# --- FAHHHH START ---" ~/.bashrc 2>/dev/null; then
    echo "$HOOK" >> ~/.bashrc
fi

if [ -f ~/.zshrc ] && ! grep -q "# --- FAHHHH START ---" ~/.zshrc 2>/dev/null; then
    echo "$HOOK" >> ~/.zshrc
fi

echo "FAHHHH Installed! Restart your terminal ( :wink: )"
