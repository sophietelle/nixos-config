# Reduces power usage, useful for laptops.
{
  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  # Time after which the USB devices will go to sleep.
  boot.kernelParams = [ "usbcore.autosuspend=60" ]; # Default value is 5-ish i think?
}
