#!/usr/bin/env bash

sudo pacman -S --needed --noconfirm base-devel

if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay-bin.git
  cd yay-bin
  makepkg -si --noconfirm
  cd ~
  rm -rf yay-bin
fi

sudo pacman -S --noconfirm --needed \
	ttf-jetbrains-mono-nerd ttf-nerd-fonts-symbols ttf-font-awesome \
	zsh starship \
	go \
	wget curl unzip fzf ripgrep wl-clipboard fastfetch btop man-db less copyq fd jq \
	ghostty wezterm neovim lazygit \
	nautilus sushi \
	chromium \
	pavucontrol wireplumber blueberry \
	hyprpaper hyprlock hypridle hyprshot waybar \
	power-profiles-daemon \


yay -S --noconfirm --needed \
	appimagelauncher \
	lazydocker \
	tldr \
	pinta libreoffice \
	node npm pnpm
