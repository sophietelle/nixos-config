{ pkgs,  ... }:

{
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 0;

    # Boot animation
    plymouth = {
      enable = true;
      theme = "bgrt";
    };

    kernelPackages = pkgs.linuxPackages_zen;
    kernelParams = [
      "boot.shell_on_fail"

      # Silent boot, disables boot logs
      "rd.systemd.show_status=auto"
      "quiet"
      "fbcon=vc:2-6"

      # FPS improvement (equivalent to the "disable HPET
      # in Device Manager" Windows tweak)
      "tsc=reliable"
      "clocksource=tsc"
    ];
  };
}
