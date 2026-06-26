# dotfile

files in root folder, except ~/.gitignore, should be put at home directory, i.e. ~, such as

- ~/.gitconfig
- ~/.tmux.conf

## Setup new computer

```bash
# wsl linux
wsl --install Ubuntu-24.04
wsl --set-default Ubuntu-24.04
sudo apt update
sudo apt upgrade
sudo apt install build-essential
sudo apt install gcc
sudo apt install clang 
sudo apt install xclip


git config --global user.name "<name>"
git config --global user.email "<email>"


# zsh
sudo apt install zsh
# omz
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# power10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
# p10k config
vim ~/.zshrc
# change ZSH_THEME="powerlevel10k/powerlevel10k"
source ~/.zshrc
p10k configure


# install gh
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
 && sudo mkdir -p -m 755 /etc/apt/keyrings \
 && out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
 && cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
 && sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
 && sudo mkdir -p -m 755 /etc/apt/sources.list.d \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
 && sudo apt update \
 && sudo apt install gh -y


# tmux
sudo apt install tmux
# tmux tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
# copy config
nvim ~/.tmux.conf
# update by ctrl+b+I


# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew config
echo >> $HOME/.zshrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> $HOME/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"


# uv
curl -LsSf https://astral.sh/uv/install.sh | sh
uv python install 3.12
# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
nvm install node
npm install -g yarn
# codex
npm install -g @openai/codex


# just
sudo apt install just
just --completions zsh


# fzf
sudo apt install fd-find
sudo apt install ripgrep
brew install fzf
# bat
sudo apt install bat
# create symlink cuz "bat" was used by other library
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
# make fzf with a default preview
# save it to .zshrc
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}' --preview-window right:57%:wrap --bind ctrl-b:half-page-up,ctrl-f:half-page-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,'ctrl-y:execute-silent(echo -n {} | /mnt/c/Windows/System32/clip.exe)+abort'"


# nvim
sudo snap install nvim --classic
# lazyvim prereq
brew install lazygit
# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# rustup setup
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
# tree-sitter
cargo install --locked tree-sitter-cli
# lazyvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
# for lazyvim Mason python stuffs
sudo apt install python3-venv
# setup
nvim ~/.config/nvim/lua/plugins/custom.lua
nvim ~/.config/nvim/lua/config/keymaps.lua
# python debugger
uv tool install debugpy
# ai
curl -fsSL https://opencode.ai/install | bash


# manim
sudo apt install build-essential python3-dev libcairo2-dev libpango1.0-dev
sudo apt install ffmpeg
sudo apt install texlive-full


# r
# Install dependencies
sudo apt install --no-install-recommends software-properties-common dirmngr
# Add the CRAN GPG key
wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | sudo tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
# Add the CRAN repository
sudo add-apt-repository "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -cs)-cran40/"
# Update and install R
sudo apt update
sudo apt install r-base
```
