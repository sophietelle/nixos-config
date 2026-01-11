{
  description = "Sophie's NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # If you're wondering why there's inputs.nixpkgs.follows:
    # Every flake has a lock file. It fixes the version of each input, including nixpkgs.
    # This means, that we will have two, three or even four different versions of nixpkgs
    # flying around our system.
    # But we can make our inputs __follow__ the version of our nixpkgs - eliminating the
    # duplication and simultaneously having the newest possible versions of packages if
    # they are used in another input flake.
    home-manager = { url = "github:nix-community/home-manager/release-25.11"; inputs.nixpkgs.follows = "nixpkgs"; };
    stylix = { url = "github:nix-community/stylix/release-25.11"; inputs.nixpkgs.follows = "nixpkgs"; };
    ida-pro = { url = "path:./packages/ida-pro"; inputs.nixpkgs.follows = "nixpkgs"; };
  };

  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations = {
      base = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          {
            system.stateVersion = "25.11"; # Did you read the comment? # No
            nixpkgs.hostPlatform = nixpkgs.lib.mkDefault "x86_64-linux";
            networking.hostName = nixpkgs.lib.mkDefault "base";
          }

          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix

          ./themes/main.nix

          ./desktop/overlays.nix
          ./desktop/nix-config.nix

          ./desktop/bootloader.nix
          ./desktop/bluetooth.nix
          ./desktop/network.nix
          ./desktop/display.nix
          ./desktop/sound.nix
          ./desktop/greetd.nix

          ./desktop/apps.nix
          ./desktop/time-locale.nix

          # Copy it over from your own installation of NixOS.
          ./machine-specific/hardware-configuration.nix

          # You should probably edit your username in ./home/users.nix,
          # unless you are not called Sophie too ;)
          ./home
        ];
      };

      # When trying out, you should only use "base" configuration.
      # If you really want to use this configuration - at least remove
      # some modules because I'm literally overclocking everything
      # that my laptop has and shit might and will go wrong :skull:
      #
      # Feel free to remove all those files and this configuration, if
      # you don't need them.
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = self.nixosConfigurations.base._module.args.modules ++ [
          { networking.hostName = "laptop"; }

          ./machine-specific/tablet-rules.nix
          ./machine-specific/display-overclock.nix
          ./machine-specific/broadcom-bt.nix
          ./machine-specific/external-mounts.nix
          ./machine-specific/nvidia.nix
          ./machine-specific/keyboard-udev.nix
          ./machine-specific/sound-latency.nix
          # ./machine-specific/kernel-tweaks.nix
        ];
      };
    };
  };
}
