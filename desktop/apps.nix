{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = false;
  };

  # Thunar thingies
  services.gvfs.enable = true; # Trash folder
  services.tumbler.enable = true; # Thumbnails
  programs.xfconf.enable = true; # Explorer preferences

  # CLI tools that will be available for any user.
  environment.systemPackages = with pkgs; [
    neovim
    python3
    bun
    wget
    curl
    git
  ];
}
