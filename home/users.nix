{ lib, ... }:

let
  username = "sophie";
  displayName = "Sophie"; # The name that will be displayed

  # Replace this with your profile directory from about:profile
  # after setting up Firefox. It will look like this: "aabb1122.default"
  firefoxProfileName = "mldahcq0.default";
in
{
  users.users.${username} = {
    isNormalUser = true;
    description = displayName;
    extraGroups = [ "corectrl" "networkmanager" "wheel" "plugdev" "docker" ];
  };

  home-manager.users.${username} = { pkgs, ... }: {
    home.stateVersion = "25.11";

    imports = [
      ./sway.nix
      ./fastfetch.nix
      ./fuzzel.nix
      # ./waybar.nix
      ./alacritty.nix
      ./swaybg.nix
      ./zed.nix
      ./quickshell.nix
      ./additional-apps.nix # Comment this out if you don't want none of my bloat
    ];

    home.packages = with pkgs; [
      xfce.thunar
      xfce.thunar-archive-plugin
      mpv

      lxqt.lxqt-archiver
      zip
      unzip
    ];

    programs = {
      home-manager.enable = true;
      firefox.enable = true;
    };

    stylix.targets.firefox.profileNames = [firefoxProfileName];
  };
}
