{ pkgs, lib, ... }:

let
  sway-config = pkgs.writeText "sway-regreet" ''
    exec "${lib.getExe pkgs.regreet}; ${pkgs.swayfx}/bin/swaymsg exit"
  '';
in
{
  programs.regreet = {
    enable = true;
  };

  services.greetd = {
    greeterManagesPlymouth = true;
    settings = {
      default_session = {
        command = "env GTK_USE_PORTAL=0 GDK_DEBUG=no-portals XDG_RUNTIME_DIR=/tmp/sway-greetd ${pkgs.swayfx}/bin/sway --unsupported-gpu --config ${sway-config}";
      };
    };
  };
}
