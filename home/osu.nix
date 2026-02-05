# Sophie: https://git.pompy.dev/pomp/.dotfiles/src/commit/86717a4b621e6aa377a3cf68e69344acdd986984/modules/home-manager/osu.nix
{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    osu-lazer-bin
    inputs.nix-gaming.packages.${pkgs.stdenv.hostPlatform.system}.osu-stable
  ];

  home.file.".local/share/applications/osu.desktop".text = ''
    [Desktop Entry]
    Name=osu! (custom)
    # https://download.nvidia.com/XFree86/Linux-x86_64/525.78.01/README/openglenvvariables.html
    # https://github.com/PipeWire/pipewire?tab=readme-ov-file#usage
    Exec=env PIPEWIRE_LATENCY=256/44100 __GL_MaxFramesAllowed=1 __GL_SYNC_TO_VBLANK=0 obs-gamecapture osu! %U
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
