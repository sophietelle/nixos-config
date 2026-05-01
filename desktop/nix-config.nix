{ pkgs, ... }:

{
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    http-connections = 128;
    max-substitution-jobs = 128;
    max-jobs = "auto";
  };

  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;
}
