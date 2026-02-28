# 🔊 FAHHH
Make your Linux terminal shout **FAHHH** every time you mess up a command or type something that doesn't exist! 

Supports: **Ubuntu, Debian, Fedora, and Arch (Tested on Fedora)**.

## 🚀 Quick Install
This command will clone the repository, make the installer executable, and set up FAHHH automatically:

```bash
git clone https://github.com/snowwysillycat/FAHHH.git && cd FAHHH && chmod +x install.sh && ./install.sh
```

> **Note:** After installing, restart your terminal or run `source ~/.bashrc` (or `source ~/.zshrc`) to activate the shouting!

---

## 🛠️ How it Works

1. **The Sound Engine:** The installer detects your package manager (`apt`, `dnf`, or `pacman`) and installs `mpv`.
2. **Fahh:** It adds a hidden function to your shell configuration (`.bashrc` or `.zshrc`) that listens for "Command Not Found" errors or any failed exit codes.
3. **Background Play:** The audio plays in the background so you can keep typing immediately.

---

## 🗑️ How to Remove

If you want to stop the shouting and delete all files, run this command:

```bash
# Remove the code from your shell configs
sed -i '/# --- FAHHHH START ---/,/# --- FAHHHH END ---/d' ~/.bashrc ~/.zshrc 2>/dev/null

# Delete the sound folder
rm -rf ~/.fahhhh

# Refresh shell to apply changes
source ~/.bashrc 2>/dev/null || source ~/.zshrc 2>/dev/null

echo "FAHHH has been removed. Silence restored."
```

---

## ✨ Credits

Inspired by the original [FAHHHH](https://github.com/ServerDeveloper9447/fahhhh/tree/master) project. Adapted for Linux by **snowwy**.
