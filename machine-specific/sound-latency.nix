# Sophie: Adapted from https://github.com/fufexan/nix-gaming, an MIT-licensed project
# https://github.com/fufexan/nix-gaming/blob/568772891364aaa7e29da6dd4f0b2f626f3a62ae/modules/pipewireLowLatency.nix

let
  inputMatch = "Family 17h/19h/1ah HD Audio Controller"; # wpctl status + wpctl inspect <id>

  quantum = 64;
  rate = 44100;
  format = "S32LE";

  qr = "${toString quantum}/${toString rate}";
in
{
  powerManagement.cpuFreqGovernor = "performance";

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

  services.pipewire = {
    extraConfig = {
      pipewire."99-lowlatency" = {
        "context.properties" = {
          "default.clock.rate" = rate;
          "cpu.zero.denormals" = true;
          "mem.allow-mlock" = true;
          "mem.mlock-all" = true;
          "link.max-buffers" = 16;
        };

        "context.properties.rules" = [{
          matches = [{
            "device.description" = inputMatch;
          }];
          actions = {
            update-props = {
              "default.clock.min-quantum" = quantum;
              "default.clock.quantum" = quantum;
              "default.clock.max-quantum" = quantum;
            };
          };
        }];

        "context.modules" = [
          {
            name = "libpipewire-module-rt";
            flags = [
              "ifexists"
              "nofail"
            ];
            args = {
              "nice.level" = -20;
              "rt.prio" = 99;
              "rt.time.soft" = 200000;
              "rt.time.hard" = 200000;
            };
          }
        ];
      };

      pipewire-pulse."99-lowlatency"."pulse.properties" = {
        "server.address" = ["unix:native"];
        "pulse.min.req" = qr;
        "pulse.min.quantum" = qr;
        "pulse.min.frag" = qr;
      };

      client."99-lowlatency"."stream.properties" = {
        "node.latency" = qr;
        "resample.quality" = 1;
      };
    };

    wireplumber = {
      extraConfig = {
        "99-alsa-lowlatency"."monitor.alsa.rules" = [
          {
            matches = [{"node.name" = "~alsa_output.*";}];
            actions.update-props = {
              "audio.format" = format;
              "audio.rate" = rate;
              "api.alsa.period-size" = quantum;
              "api.alsa.headroom" = quantum;
              # "api.alsa.headroom" = quantum;
              # "api.alsa.period-num" = 3;
              "session.suspend-timeout-seconds" = 0;
            };
          }
        ];
      };
    };
  };
}
