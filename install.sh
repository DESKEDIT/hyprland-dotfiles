#!/bin/bash

stty -echo

echo "DESKEDIT HYPRLAND DOTFILES INSTALLER"

echo "Updating the system"
apt update

echo "installing dependencies"
apt install -y thunar kitty rofi chromium waybar

echo "hyprlock"
echo "  dependencies"
apt install -y libcairo-dev libpam-dev libpango-1.0-0 libsdbus-c++-dev libwayland-client0 wayland-protocols  libxkbcommon-dev
echo "    OpenGL"
apt install -y libgbm-dev libdrm-dev freeglut3-dev mesa-common-dev libglew-dev libsdl2-dev libsdl2-image-dev libglm-dev libfreetype6-dev
echo "  building"
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -S . -B ./build
cmake --build ./build --config Release --target hyprlock -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

cmake --install build

echo "hyprpaper"
echo "  dependencies"
apt install -y libwayland-dev file libglvnd-dev libglvnd-core-dev libturbojpeg-dev libwebp-dev libjxl-dev
echo "  building"
cmake --no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr -S . -B ./build
cmake --build ./build --config Release --target hyprpaper -j`nproc 2>/dev/null || getconf _NPROCESSORS_CONF`

cmake --install ./build

echo "Copying dotfiles"

cp --update -r dotfiles/ ~/

stty echo
