{ pkgs, ... }:

{
  services.udev.packages = with pkgs; [
    wooting-udev-rules
    qmk-udev-rules
  ];
}
