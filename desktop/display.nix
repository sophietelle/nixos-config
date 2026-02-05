{ pkgs, ... }:

{
  # Brightness keys & saving brightness between reboots
  services.illum.enable = true;

  # The login manager entry for Sway.
  #
  # Answering the question "Why do you use UWSM?":
  # With UWSM you can launch all the required tools
  # (Waybar, maybe wallpaper manager) as user systemd
  # units that depend on the window manager instead
  # of explicitly stating them in your WM configuration
  # + you always have access to logs and comfortable
  # process management.
  #
  # Example - restarting Waybar
  # `systemctl --user restart waybar.service`
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      sway = {
        prettyName = "Sway";
        comment = "Sway compositor managed by UWSM";
        binPath = "${pkgs.swayfx}/bin/sway";
        extraArgs = ["--unsupported-gpu"];
      };
    };
  };
}
