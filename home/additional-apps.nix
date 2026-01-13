{ pkgs, lib, osConfig, ... }:

let
  # Sophie: this is my personal garbage and you probably
  # won't want it :)
  shouldUse = osConfig.networking.hostName == "laptop";
in
{
  home.packages = lib.mkIf shouldUse (with pkgs; [
    gh
    android-tools
    scrcpy

    ida-pro
    telegram-desktop
    vesktop
    spotify
    transmission_4-qt
    osu-lazer-bin

    # Minecraft launcher
    (prismlauncher.override {
      jdks = [
        zulu8
        zulu21
      ];
    })
  ]);
}
