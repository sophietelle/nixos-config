{ pkgs, ... }:

{
  hardware.uinput.enable = true;
  boot.kernelModules = [ "uinput" ];

  # Wacom CTL-472
  # - Rotation: 180
  # - Area position:
  #   - X: 114 mm
  #   - Y: 51 mm
  # - Area dimensions:
  #   - Width: 75 mm
  #   - Height: 52.5 mm
  # - Filters:
  #   - BezierInterpolator:
  #     - Pre-interp smoothing: 3
  #     - Tilt smoothing: 1
  #     - Frequency: 200hz
  hardware.opentabletdriver.enable = true;
}
