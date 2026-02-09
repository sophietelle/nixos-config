{ pkgs, ... }:

{
  qt.enable = true;

  programs.quickshell = {
    enable = true;
    systemd.enable = true;
    activeConfig = toString ../quickshell;
  };
}
