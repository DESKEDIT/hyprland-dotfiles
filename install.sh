#!/bin/bash

stty -echo

echo "DESKEDIT HYPRLAND DOTFILES INSTALLER"

cp --update -r dotfiles/ ~/

stty echo
