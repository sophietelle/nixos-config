{ pkgs, ... }:

{
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];

  hardware.opentabletdriver.enable = true;
}
