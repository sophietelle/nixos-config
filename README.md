## Sophie's NixOS flake
<a href="https://ibb.co/Cs7t0syq"><img src="https://i.ibb.co/JF7dkFTN/image.png" alt="image" border="0"></a>
<a href="https://ibb.co/nMQd7V6x"><img src="https://i.ibb.co/KxV42QbT/image.png" alt="image" border="0"></a>

This flake is intended to act as beginner-friendly learning source - it is well-commented and does not suffer from "folder hell"

Though it is very simple, I actually daily-drive it.

## Setup
- Nix modules:
  - Configs: Home Manager
  - Theming: mostly Stylix
- WM/Compositor: Sway
- Terminal: Alacritty
- Bar: Quickshell (Waybar config also present)
- File explorer: Thunar
- Launcher: fuzzel

## How to install
1. Copy `hardware-configuration.nix` from your NixOS config to `./machine-specific`
2. Change the username in `./home/users.nix`
3. Run `sudo nixos-rebuild switch --flake .#base`

## How to use
- At `./home/sway.nix` are keybindings you can look at and change
- At `./home/users.nix` you usually add new programs, for example Spotify or Discord
- At `./themes/main.nix` you can change colors and other theme thingies

## Credits
- Wallpaper: https://t.me/aaiposting (channel history is cleaned for some reason)
- Anything else is credited in the `.nix` files
