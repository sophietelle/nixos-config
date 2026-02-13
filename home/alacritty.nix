{ pkgs, config, lib, ... }:

let
  target = config.wayland.systemd.target;
in
{
  programs.alacritty.enable = true;
  systemd.user.services.alacritty-daemon = {
    Unit = {
      Description = "Alacritty daemon";
      Documentation = "https://alacritty.org/config-alacritty.html";
      After = [ target ];
    };

    Service = {
      ExecStart = lib.getExe pkgs.alacritty + " --daemon";
      Restart = "on-failure";
    };

    Install.WantedBy = [ target ];
  };
}
