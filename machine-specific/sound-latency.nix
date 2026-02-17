{
  boot.kernelParams = [
    "threadirqs"
    "preempt=full"
    "nmi_watchdog=0"
    "nowatchdog"
    "split_lock_detect=off"
  ];

  boot.kernel.sysctl = {
    "kernel.split_lock_mitigate" = 0;
  };

  services.udev.extraRules = ''
    KERNEL=="rtc0", GROUP="audio"
    KERNEL=="hpet", GROUP="audio"
    DEVPATH=="/devices/virtual/misc/cpu_dma_latency", OWNER="root", GROUP="audio", MODE="0660"
  '';

  security.pam.loginLimits = [
    {
      domain = "@audio";
      type = "-";  # both soft and hard
      item = "rtprio";
      value = "99";
    }
    {
      domain = "@audio";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
  ];

  # For osu!lazer.
  services.pipewire = {
    extraConfig = {
      pipewire."99-lowlatency" = {
        "context.properties" = {
          "default.clock.rate" = 44100;
        };
      };
    };
  };
}
