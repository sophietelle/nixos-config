{ pkgs, lib, osConfig, ... }:

let
  # Sophie: this is my personal garbage and you probably
  # won't want it :)
  shouldUse = osConfig.networking.hostName == "laptop";
in
{
  imports = [
    ./osu.nix
  ];

  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vaapi
      obs-vkcapture
    ];
  };

  home.packages = lib.mkIf shouldUse (with pkgs; [
    winbox4
    gh
    android-tools
    scrcpy

    steam

    ida-pro
    binaryninja

    telegram-desktop
    vesktop
    spotify
    transmission_4-qt

    kdePackages.qtdeclarative

    # Minecraft launcher
    (prismlauncher.override {
      jdks = [
        zulu8
        zulu21
      ];
    })
  ]);
}
