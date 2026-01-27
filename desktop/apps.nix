{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
  };

  # Thunar thingies
  services.gvfs.enable = true; # Trash folder
  services.tumbler.enable = true; # Thumbnails
  programs.xfconf.enable = true; # Explorer preferences

  # CLI tools that will be available for any user.
  environment.systemPackages = with pkgs; [
    neovim
    wget
    curl
    git
  ];
}
