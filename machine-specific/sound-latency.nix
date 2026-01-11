# Sophie: Adapted from https://github.com/fufexan/nix-gaming, an MIT-licensed project
# https://github.com/fufexan/nix-gaming/blob/568772891364aaa7e29da6dd4f0b2f626f3a62ae/modules/pipewireLowLatency.nix

let
  inputMatch = "Family 17h/19h/1ah HD Audio Controller"; # wpctl status + wpctl inspect <id>

  quantum = 128;
  rate = 48000;
  format = "S32LE";

  qr = "${toString quantum}/${toString rate}";
in
{
  services.pipewire = {
    extraConfig = {
      pipewire."99-lowlatency" = {
        "context.properties.rules" = [{
          matches = [{
            "device.description" = inputMatch;
          }];
          actions = {
            update-props = {
              "default.clock.min-quantum" = quantum;
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
              "nice.level" = -15;
              "rt.prio" = 88;
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
            };
          }
        ];
      };
    };
  };
}
