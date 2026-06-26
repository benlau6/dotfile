# dotfile

files in root folder, except ~/.gitignore, should be put at home directory, i.e. ~, such as

- ~/.gitconfig
- ~/.tmux.conf

## Sync dotfiles

to sync local machine dotfiles outside of this folder, use symlink

```
ln -s ~/dotfiles/.zshrc ~/.zshrc
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.config/ranger ~/.config/ranger
ln -s ~/dotfiles/.config/lazygit ~/.config/lazygit
ln -s ~/dotfiles/.config/nvim ~/.config/nvim
```

check script

```
```

ls -l ~/.zshrc
ls -l ~/.tmux.conf
ls -l ~/.gitconfig
ls -l ~/.config/ranger
ls -l ~/.config/lazygit
ls -l ~/.config/nvim

```

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


# nvim
sudo snap install nvim --classic


# tmux
sudo apt install tmux
# tmux tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
# copy config
nvim ~/.tmux.conf
# update by ctrl+b+I


# fzf
sudo apt install fd-find
sudo apt install ripgrep
brew install fzf
# make fzf with a default preview
# save it to .zshrc
export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}' --preview-window right:57%:wrap --bind ctrl-b:half-page-up,ctrl-f:half-page-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down,'ctrl-y:execute-silent(echo -n {} | /mnt/c/Windows/System32/clip.exe)+abort'"


# power10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
# fzf-tab
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
# autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# copy github zshrc to ~/.zshrc
nvim ~/.zshrc
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


# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# brew config
echo >> $HOME/.zshrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"' >> $HOME/.zshrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"


# uv
curl -LsSf https://astral.sh/uv/install.sh | sh
uv python install 3.12
# fnm (node manager)
curl -fsSL https://fnm.vercel.app/install | bash
# codex
npm install -g @openai/codex


# ranger, a tui file explorer with nvim motion
# z+h to see hidden file
# y+p to copy path
# hjkl to navigate
# to use ranger, just type `ranger`
uvx tool install ranger-fm


# just
sudo apt install just
# autocompletion
just --completions zsh > just


# zoxide, a better cd with memory
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh


# bat
sudo apt install bat
# create symlink cuz "bat" was used by other library
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat


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
