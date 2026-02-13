{ pkgs, config, lib, ... }:

let
  # Path to a wallpaper. toString with a relative argument
  # will reference a file in the flake folder. To use another
  # path not in a flake, just replace it with a string, e.g.
  # wallpaper = "/home/sophie/wallpapers/cool-wallpaper.png";
  wallpaper = toString ../wallpapers/v3.png;
  mode = "fill"; # stretch, fit, fill, center, tile, or solid_color

  target = config.wayland.systemd.target;
in
{
  home.packages = [ pkgs.swaybg ];

  systemd.user.services.swaybg = {
    Unit = {
      Description = "Wallpaper tool for Wayland compositors";
      After = [ target ];
    };

    Service = {
      ExecStart = lib.getExe pkgs.swaybg + " --image ${wallpaper} --mode ${mode}";
      Restart = "on-failure";
    };

    Install.WantedBy = [ target ];
  };
}
