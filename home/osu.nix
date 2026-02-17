# Sophie: https://git.pompy.dev/pomp/.dotfiles/src/commit/86717a4b621e6aa377a3cf68e69344acdd986984/modules/home-manager/osu.nix
# Lazer runs at 44100hz. libbass is a bitch and i hate it sincerely
# Make sure to set 44100hz system-wide default sample rate to avoid resampling (-latency, +sound quality)
{ pkgs, inputs, lib, ... }:

let
  # Adapt if sound corruption happens
  # Good values: 32, 64, 96, 128
  latency = "64";
  rate = "44100";

  osuEnv = [
    # https://github.com/PipeWire/pipewire?tab=readme-ov-file#usage
    "PIPEWIRE_LATENCY=${latency}"
    "PIPEWIRE_QUANTUM=${latency}"
    "PIPEWIRE_RATE=${rate}"
    "PIPEWIRE_NODE=\"{node.latency=${latency}/${rate}}\""
    # https://download.nvidia.com/XFree86/Linux-x86_64/525.78.01/README/openglenvvariables.html
    "__GL_MaxFramesAllowed=1"
    "__GL_SYNC_TO_VBLANK=0"
    "vblank_mode=0"

    "obs-gamecapture"
    # programs.gamemode.enable in nix system config
    "gamemoderun"
  ];
in
{
  home.packages = with pkgs; [
    osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
  ];

  home.file.".local/share/applications/osu.desktop".text = ''
    [Desktop Entry]
    Name=osu! (custom)
    Exec=env ${lib.concatStringsSep " " osuEnv} osu! %U
    Categories=Game
    Comment=A free-to-win rhythm game. Rhythm is just a *click* away!
    SingleMainWindow=true
    Icon=osu
    StartupWMClass=osu!
    MimeType=application/x-osu-beatmap-archive;application/x-osu-skin-archive;application/x-osu-beatmap;application/x-osu-storyboard;application/x-osu-replay;x-scheme-handler/osu;
    StartupNotify=true
    Terminal=false
    Type=Application
    Version=1.5
  '';
}
