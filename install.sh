#!/bin/bash

echo "Installing FAHHHH-Linux in linux..."

# Detect Package Manager and Install mpv and everything ( work with arch / fedora / ubonto )
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

mkdir -p ~/.fahhhh
curl -sL https://raw.githubusercontent.com/snowwysillycat/FAHHH/main/fahhhh.mp3 -o ~/.fahhhh/fahhhh.mp3

# 3. Create the FAhhh Code
HOOK='
# --- FAHHHH START ---
_fahhhh_play() {
    mpv --no-video --really-quiet ~/.fahhhh/fahhhh.mp3 &>/dev/null &
}

# Trigger on "Command Not Found"
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

# Trigger on any failed command (exit code > 0)
_fahhhh_check_status() {
    local status=$?
    if [ $status -ne 0 ] && [ $status -ne 127 ]; then
        _fahhhh_play
    fi
}

# Apply to Bash or Zsh
if [ -n "$BASH_VERSION" ]; then
    # Prevent double-adding to PROMPT_COMMAND
    [[ "$PROMPT_COMMAND" != *"_fahhhh_check_status"* ]] && PROMPT_COMMAND="_fahhhh_check_status; $PROMPT_COMMAND"
elif [ -n "$ZSH_VERSION" ]; then
    # Add to Zsh precmd array
    [[ ! " ${precmd_functions[*]} " == *" _fahhhh_check_status "* ]] && precmd_functions+=(_fahhhh_check_status)
fi
# --- FAHHHH END ---
'

# Inject into .bashrc and .zshrc if not already there
if ! grep -q "# --- FAHHHH START ---" ~/.bashrc; then
    echo "$HOOK" >> ~/.bashrc
fi

if [ -f ~/.zshrc ] && ! grep -q "# --- FAHHHH START ---" ~/.zshrc; then
    echo "$HOOK" >> ~/.zshrc
fi

echo "FAHHHH Installed! Restart your terminal to activate it ( its loud :wink: )."
